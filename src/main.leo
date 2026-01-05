program sample_test.aleo {
    struct TransferMsg {
    token: field,
    from: [u8;32],
    to: [u8;32],
    amount: u128,
    data: [u8;32]
    }

    @noupgrade
    async constructor() {}
        function hash_number_u8(value: u8) -> [u8;32] {
        // omit metadata.
        let digest: [bool; 256] = Keccak256::hash_to_bits_raw(value);
        let hash_bytes: [u8;32] = Deserialize::from_bits_raw::[[u8;32]](digest);
        return hash_bytes;
    }

    transition main(message: TransferMsg) ->  [u8;32] {
        let digest: [bool; 256] = Keccak256::hash_to_bits(message);
        let message_bytes : [u8;32] = Deserialize::from_bits_raw::[[u8;32]](digest);
        return message_bytes;
    }

    inline u128_to_bytes16(value: u128) -> [u8; 16] {
        // Convert u128 to 16 bytes (big-endian) to match Solidity's abi.encodePacked(uint128)
        // No padding - just the raw 16-byte representation

        // Extract each byte from the u128 (16 bytes total) in big-endian order
        let b0: u8 = ((value >> 120u8) & 0xFFu128) as u8;
        let b1: u8 = ((value >> 112u8) & 0xFFu128) as u8;
        let b2: u8 = ((value >> 104u8) & 0xFFu128) as u8;
        let b3: u8 = ((value >> 96u8) & 0xFFu128) as u8;
        let b4: u8 = ((value >> 88u8) & 0xFFu128) as u8;
        let b5: u8 = ((value >> 80u8) & 0xFFu128) as u8;
        let b6: u8 = ((value >> 72u8) & 0xFFu128) as u8;
        let b7: u8 = ((value >> 64u8) & 0xFFu128) as u8;
        let b8: u8 = ((value >> 56u8) & 0xFFu128) as u8;
        let b9: u8 = ((value >> 48u8) & 0xFFu128) as u8;
        let b10: u8 = ((value >> 40u8) & 0xFFu128) as u8;
        let b11: u8 = ((value >> 32u8) & 0xFFu128) as u8;
        let b12: u8 = ((value >> 24u8) & 0xFFu128) as u8;
        let b13: u8 = ((value >> 16u8) & 0xFFu128) as u8;
        let b14: u8 = ((value >> 8u8) & 0xFFu128) as u8;
        let b15: u8 = (value & 0xFFu128) as u8;

        // Return 16 bytes in big-endian order
        return [
            b0, b1, b2, b3, b4, b5, b6, b7,          // high bytes (bytes 0-7)
            b8, b9, b10, b11, b12, b13, b14, b15     // low bytes (bytes 8-15)
        ];
    }

    function hash_number(value: u128) -> [u8;32] {
        // Convert u128 to 16 bytes in EVM format (abi.encodePacked)
        let value_bytes: [u8; 16] = u128_to_bytes16(value);

        // Now hash the 16-byte array
        let digest: [bool; 256] = Keccak256::hash_to_bits_raw(value_bytes);
        let hash_bytes: [u8;32] = Deserialize::from_bits_raw::[[u8;32]](digest);
        return hash_bytes;
    }
    function hash_field(field_value: field) -> [u8; 32] {
        //! Attention to finding - Theseare the finding and for now the test is passing pretty well. 
        // BYTE ARRAY APPROACH (handles full 253-bit field range)
        // To match Solidity's keccak256(abi.encodePacked(uint256(x))), we need big-endian bytes

        // Step 1: Get field as 253 bits (little-endian: field_bits[0] = LSB)
        let field_bits: [bool; 253] = Serialize::to_bits_raw(field_value);

        // Step 2: Pad to 256 bits (little-endian style, padding at end)
        let bits256: [bool; 256] = [false; 256];
        for i: u32 in 0u32..253u32 {
            bits256[i] = field_bits[i];
        }
        // bits256[253-255] remain false (padding)

        // Step 3: Deserialize to bytes (gives little-endian byte order)
        let bytes_le: [u8; 32] = Deserialize::from_bits_raw::[[u8; 32]](bits256);

        // Step 4: Reverse byte order to convert to big-endian
        // Solidity uses big-endian: byte[0] = MSB, byte[31] = LSB
        // Leo gives us little-endian: byte[0] = LSB, byte[31] = MSB
        let bytes_be: [u8; 32] = [0u8; 32];
        for i: u32 in 0u32..32u32 {
            bytes_be[i] = bytes_le[31u32 - i];
        }

        // Step 5: Hash the big-endian byte array
        let digest: [bool; 256] = Keccak256::hash_to_bits_raw(bytes_be);
        let hash_bytes: [u8; 32] = Deserialize::from_bits_raw::[[u8; 32]](digest);

        return hash_bytes;
    }
  }
