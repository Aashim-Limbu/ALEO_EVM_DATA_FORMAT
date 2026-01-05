# Aleo Internal Serialization: The Core Problem Explained

## The Core Problem in One Sentence

**When you hash a u128 directly in Aleo, it doesn't hash the raw 16 bytes of the number—it hashes a serialized representation that includes type information and metadata, which EVM doesn't use.**

---

## What is "Internal Serialization"?

### Simple Analogy

Imagine you want to send the number `1000` to someone:

- **Raw bytes** (what EVM does): Send just the number
  - `[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 232]` (16 bytes)

- **With metadata** (what Aleo does): Send the number with a label
  - `"type:u128, value:1000"` (serialized with type info)
  - Actual bytes might be something like: `[TYPE_TAG, LENGTH, ...data...]`

**The problem**: They're hashing different bytes, so they get different hashes!

---

## Practical Example: What Gets Hashed?

Let's trace exactly what bytes get hashed for `1000u128`:

### Option 1: Direct Hashing (Aleo's Default) ❌

```leo
let value: u128 = 1000u128;
let digest: [bool; 256] = Keccak256::hash_to_bits_raw(value);
```

**What actually gets hashed:**
```
Aleo's serialization might produce something like:
[
  // Type metadata (example - actual format varies)
  0x05,           // Type tag for u128
  0x10,           // Length: 16 bytes

  // The actual value in little-endian (Aleo's internal format)
  0xE8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // 1000 in little-endian
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
]

Total: ~18 bytes (metadata + value)
Hash of these bytes: [194u8, 202u8, 205u8, ...] ❌
```

### Option 2: Manual Byte Conversion (Our Solution) ✓

```leo
let value: u128 = 1000u128;
let value_bytes: [u8; 16] = u128_to_bytes16(value);
let digest: [bool; 256] = Keccak256::hash_to_bits_raw(value_bytes);
```

**What actually gets hashed:**
```
Raw bytes in big-endian (matching EVM):
[
  // Just the value, no metadata
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // High bytes (all zeros)
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xE8   // Low bytes (1000 = 0x03E8)
]

Total: 16 bytes (just the value)
Hash of these bytes: [179u8, 237u8, 40u8, ...] ✓
```

### EVM's Approach

```solidity
uint128 value = 1000;
bytes32 hash = keccak256(abi.encodePacked(value));
```

**What gets hashed:**
```
abi.encodePacked(uint128(1000)):
[
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // High bytes
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xE8   // Low bytes (1000 = 0x03E8)
]

Total: 16 bytes (just the value)
Hash of these bytes: [179u8, 237u8, 40u8, ...] ✓
```

**Same bytes → Same hash!**

---

## Why Does Aleo Add Metadata?

### The Reason: Type Safety & Deserialization

Aleo's serialization includes metadata so that when you deserialize data, you know:
- What type it was (u8, u16, u64, u128, etc.)
- How long the data is
- How to interpret the bytes

**Example use case:**
```leo
// Serialize mixed data
let data = serialize([1000u128, 42u64, 255u8]);

// Later, deserialize it correctly
let values = deserialize(data);
// Aleo knows: "First is u128, second is u64, third is u8"
```

**This is great for Aleo's internal operations**, but **terrible for cross-chain hashing** because:
- EVM doesn't use the same metadata format
- Different metadata = different bytes = different hash

---

## The Endianness Difference

Another part of the problem: **byte order**

### Little-Endian (Aleo's Internal)

Stores the **least significant byte first**:
```
1000 in decimal = 0x03E8 in hex

Little-endian representation:
[0xE8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
 ^^^^  ^^^^
 LSB   MSB starts here
```

**Why**: Efficient for CPU operations on many architectures

### Big-Endian (EVM/Network Standard)

Stores the **most significant byte first**:
```
1000 in decimal = 0x03E8 in hex

Big-endian representation:
[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xE8]
                                                                                        ^^^^  ^^^^
                                                                                        MSB   LSB
```

**Why**: Human-readable, network protocols, most blockchain standards

### Visual Comparison

```
Value: 1000 (0x000000000000000000000000000003E8 as 16 bytes)

Little-endian (Aleo):   [E8, 03, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00]
Big-endian (EVM):       [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 03, E8]
                         ^                                                           ^
                      Reads left-to-right                                    Reads left-to-right
                      like a number!                                          (reversed)
```

**Different byte order → Different hash!**

---

## A Concrete Demonstration

Let's see what **actually** happens when hashing different byte sequences:

### Scenario 1: Hash with Metadata (Simulated Aleo Internal)

```
Input bytes (with type metadata):
[0x05, 0x10, 0xE8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
 ^^^^  ^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 type  len   value in little-endian
 tag   info

Keccak256 hash → Some hash (let's call it Hash_A)
```

### Scenario 2: Hash Without Metadata, Little-Endian

```
Input bytes (no metadata, little-endian):
[0xE8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]

Keccak256 hash → Hash_B (different from Hash_A)
```

### Scenario 3: Hash Without Metadata, Big-Endian (What We Want) ✓

```
Input bytes (no metadata, big-endian):
[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xE8]

Keccak256 hash → 0xb3ed289a6cfdcc344bf547aceef5d15152eadceb6306260ad2de44b182db9ad0
              → [179u8, 237u8, 40u8, 154u8, ...] ✓ MATCHES EVM!
```

---

## Why u8 Worked But u128 Didn't

### u8: No Serialization Issues

```leo
let value: u8 = 60u8;
Keccak256::hash_to_bits_raw(value);
```

**Even with metadata, the value is just 1 byte:**
```
Possible serialization:
[0x01, 0x01, 0x3C]  // type:u8, length:1, value:60
 ^^^^  ^^^^  ^^^^
 type  len   value

But for u8, Aleo might optimize and just use:
[0x3C]  // Just the single byte
```

**EVM side:**
```solidity
keccak256(abi.encodePacked(uint8(60)))
→ Hash of: [0x3C]  // Just the single byte
```

**Both hash the same single byte `0x3C`** → Same hash! ✓

### u128: Serialization Nightmare

```leo
let value: u128 = 1000u128;
Keccak256::hash_to_bits_raw(value);
```

**With metadata + little-endian:**
```
Possible serialization:
[0x05, 0x10, 0xE8, 0x03, 0x00, ...] (18 bytes with metadata)
OR
[0xE8, 0x03, 0x00, ...] (16 bytes little-endian without metadata)

Either way, NOT the same as EVM!
```

**EVM side:**
```solidity
keccak256(abi.encodePacked(uint128(1000)))
→ Hash of: [0x00, 0x00, ..., 0x03, 0xE8]  // 16 bytes big-endian
```

**Different bytes** → Different hash! ❌

---

## The Solution: Manual Control

Instead of letting Aleo serialize the u128, we **manually convert** it to bytes in the exact format EVM uses:

```leo
inline u128_to_bytes16(value: u128) -> [u8; 16] {
    // Extract each byte manually in big-endian order
    let b0: u8 = ((value >> 120u8) & 0xFFu128) as u8;   // Most significant
    let b1: u8 = ((value >> 112u8) & 0xFFu128) as u8;
    // ...
    let b15: u8 = (value & 0xFFu128) as u8;             // Least significant

    return [b0, b1, b2, ..., b15];  // Big-endian, no metadata
}
```

**What this does:**
1. Takes the raw u128 value (1000)
2. Extracts each byte using bit shifts
3. Arranges them in **big-endian** order
4. Returns a **pure byte array** with **no metadata**

**Result for 1000:**
```
[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xE8]
```

**This matches EVM exactly!** ✓

---

## Visual Summary

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         Value: 1000u128                                 │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│ ALEO (Direct Hash) ❌                                                   │
├─────────────────────────────────────────────────────────────────────────┤
│ Keccak256::hash_to_bits_raw(1000u128)                                  │
│                                                                          │
│ Serializes to (conceptual):                                             │
│ [TYPE, LEN, 0xE8, 0x03, 0x00, 0x00, ...] (metadata + little-endian)    │
│                                                                          │
│ Hash: [194u8, 202u8, 205u8, ...] ❌                                    │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│ ALEO (Manual Conversion) ✓                                              │
├─────────────────────────────────────────────────────────────────────────┤
│ let bytes = u128_to_bytes16(1000u128)                                  │
│ Keccak256::hash_to_bits_raw(bytes)                                     │
│                                                                          │
│ Bytes:                                                                   │
│ [0x00, 0x00, ..., 0x03, 0xE8] (16 bytes, big-endian, no metadata)      │
│                                                                          │
│ Hash: [179u8, 237u8, 40u8, ...] ✓                                      │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│ EVM ✓                                                                   │
├─────────────────────────────────────────────────────────────────────────┤
│ keccak256(abi.encodePacked(uint128(1000)))                             │
│                                                                          │
│ Bytes:                                                                   │
│ [0x00, 0x00, ..., 0x03, 0xE8] (16 bytes, big-endian, no metadata)      │
│                                                                          │
│ Hash: 0xb3ed289a... = [179u8, 237u8, 40u8, ...] ✓                      │
└─────────────────────────────────────────────────────────────────────────┘

✓ Manual conversion + EVM both hash identical bytes → Same hash!
```

---

## Key Insights

### 1. The Core Problem

**Abstraction vs. Control:**
- Aleo's `hash(value)` is high-level: "Hash this value" (includes serialization)
- EVM's `keccak256(bytes)` is low-level: "Hash these exact bytes"

When systems use different serialization, high-level abstraction breaks compatibility.

### 2. Why This Matters for Cross-Chain

Different blockchains have different:
- **Serialization formats** (metadata, structure)
- **Byte ordering** (endianness)
- **Type systems** (how types are represented)

For cross-chain consistency, you need **byte-level control**.

### 3. The General Pattern

```
❌ WRONG:
Chain A: hash(value) → Uses Chain A's serialization → Hash_A
Chain B: hash(value) → Uses Chain B's serialization → Hash_B
Result: Hash_A ≠ Hash_B

✓ RIGHT:
Chain A: bytes = to_bytes_standard(value) → hash(bytes) → Hash
Chain B: bytes = to_bytes_standard(value) → hash(bytes) → Hash
Result: Same bytes → Same hash
```

**The lesson**: When you need cross-chain compatibility, **always control the byte representation explicitly**.

---

## Conclusion

**Aleo's internal serialization** includes metadata and uses little-endian byte order, which is great for Aleo's internal operations but incompatible with EVM's raw big-endian encoding.

**The fix**: Bypass Aleo's serialization by manually converting values to bytes in the exact format that EVM uses (big-endian, no metadata), then hash those bytes.

**The broader lesson**: Cross-chain compatibility requires **byte-level precision**—you can't rely on language-level abstractions when different systems use different serialization formats.
