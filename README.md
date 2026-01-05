# Sample Test - Leo Hashing Project

A Leo program that demonstrates cryptographic hashing, type conversion, and struct serialization using the Aleo blockchain.

## Project Overview

This project showcases:

- **Keccak256 hashing** of custom structs and primitive types
- **Bit-to-byte conversion** from `[bool; 256]` to `[u8; 32]`
- **Serialization** of Leo data types with and without metadata
- **Cross-chain compatibility testing** between Leo and Solidity
- **Type conversion utilities** between hex strings and Leo arrays

## Project Structure

```
sample_test/
├── src/
│   └── main.leo              # Core Leo program with hashing functions
├── tests/
│   └── test_sample_test.leo  # Comprehensive test suite
├── inputs/
│   └── message.in            # Input file for main transition
├── translate.ts              # TypeScript helper for hex ↔ [u8;32] conversion
├── config.leo                # Leo configuration
├── program.json              # Program metadata
└── README.md                 # This file
```

## Core Functions

### `main(message: TransferMsg) -> [u8;32]`

Hashes a `TransferMsg` struct using Keccak256 and returns the digest as a 32-byte array.

```leo
transition main(message: TransferMsg) -> [u8;32] {
    let digest: [bool; 256] = Keccak256::hash_to_bits(message);
    let message_bytes: [u8;32] = Deserialize::from_bits_raw::[u8;32](digest);
    return message_bytes;
}
```

**Input struct:**

```leo
struct TransferMsg {
    token: field,
    from: [u8;32],
    to: [u8;32],
    amount: u128,
    data: [u8;32]
}
```

### `hash_number(value: u128) -> [u8;32]`

Hashes a `u128` value using Keccak256 with raw (no metadata) serialization.

```leo
function hash_number(value: u128) -> [u8;32] {
    let digest: [bool; 256] = Keccak256::hash_to_bits_raw(value);
    let hash_bytes: [u8;32] = Deserialize::from_bits_raw::[u8;32](digest);
    return hash_bytes;
}
```

### `bit_to_bytes32(data: [bool; 253]) -> [u8; 32]`

Manually converts a 253-bit boolean array to a 32-byte unsigned integer array by packing bits into bytes.

## Tests

Run all tests:

```bash
leo test
```

Run specific test:

```bash
leo test test_it
```

### Test Suite

- **`test_it`** - Basic struct hashing test
- **`test_deserialize_consistency`** - Verify same input produces same output
- **`test_hash_number_solidity_match`** - Test hash compatibility with Solidity
- **`test_bit_to_bytes32`** - Test bit-to-byte conversion
- **`test_bit_to_bytes32_consistency`** - Verify consistency of conversion
- **`test_bit_to_bytes32_different_inputs`** - Verify different inputs produce different outputs

## Usage

### Debug Mode

Run the program interactively:

```bash
leo debug --block-timestamp $(date +%s)
```

Then in the debugger prompt:

```
✔ Command? · #set_program sample_test

✔ Command? · let addr: [u8;32] = [ /* address array */ ];

✔ Command? · let message: TransferMsg = TransferMsg { token: 1field, from: addr, to: addr, amount: 1000u128, data: addr };

✔ Command? · let result: [u8; 32] = sample_test.aleo/main(message);

✔ Command? · result
```

### Build

Compile the program:

```bash
leo build
```

### Type Conversion (TypeScript)

Use the provided `translate.ts` helper to convert between formats:

```bash
npx ts-node translate.ts
```

**Convert hex to Leo [u8;32]:**

```typescript
import { hexToU8Array32 } from "./translate";

const leo_format = hexToU8Array32(
  "0x5fe7f977e71dba2ea1a68e21057beebb9be2ac30c6410aa38d4f3fbe41dcffd2"
);
// Returns: [95u8, 231u8, 249u8, 119u8, ...]
```

**Convert Leo [u8;32] to hex:**

```typescript
import { u8ArrayToHex } from "./translate";

const hex = u8ArrayToHex("[95u8, 231u8, 249u8, 119u8, ...]");
// Returns: 0x5fe7f977e71dba2ea1a68e21057beebb9be2ac30c6410aa38d4f3fbe41dcffd2
```

## Cross-Chain Testing (Solidity)

To compare Leo hashes with Solidity, use Chisel (Solidity REPL):

```solidity
// Hash a u128 value
bytes32 test = keccak256(abi.encodePacked(uint128(1000)));

// Hash an address
address addr = 0x000000000000000000000000BBB91DD1337852056A870B4E81D8F582552ECA89;
bytes32 hash = keccak256(abi.encodePacked(addr));
```

**Note:** Leo and Solidity use different encoding standards, so hashes of the same value may differ. Use `abi.encodePacked()` in Solidity for raw encoding (similar to Leo's `_raw` functions).

## Key Learnings

### Serialization Differences

- **Leo** serializes with type metadata by default
- Use `Serialize::to_bits_raw()` and `Deserialize::from_bits_raw()` for raw encoding
- Raw encoding matches the actual bit representation without metadata overhead

### Type Compatibility

- `[bool; 256]` = 256 bits = 32 bytes (`[u8; 32]`)
- `address` in Solidity = 160 bits = 20 bytes
- `[bool; 253]` = 253 bits (serialized address size in Leo)

### Hash Consistency

- Same input → Same output (within the same language)
- Different languages may produce different hashes due to encoding differences
- Always use raw encoding for cross-chain compatibility attempts

## Dependencies

- **Leo**: Aleo's programming language
- **TypeScript**: For utility scripts
- **Solidity**: For cross-chain testing (Chisel)

## Installation

1. Install Leo:

```bash
curl https://sh.leo.app | sh
```

2. Clone/setup this project:

```bash
cd sample_test
leo build
```

3. Run tests:

```bash
leo test
```

## Environment Setup

The project includes a `.env` file with:

- `NETWORK=testnet`
- `PRIVATE_KEY=...` (for deployment)
- `ENDPOINT=...` (Aleo network endpoint)

## Future Enhancements

- [ ] Add Leo formatter support
- [ ] Implement `leo fmt` command
- [ ] Create more cross-chain compatibility tests
- [ ] Add support for additional hash functions (SHA256, etc.)
- [ ] Performance benchmarking suite

## Resources

- [Leo Documentation](https://docs.leo-lang.org/)
- [Aleo Network](https://aleo.org/)
- [Leo GitHub](https://github.com/ProvableHQ/leo)

## License

This project is part of the Aleo ecosystem and follows the same license guidelines.
