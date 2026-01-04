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

    transition main(message: TransferMsg) ->  [u8;32] {
        let digest: [bool; 256] = Keccak256::hash_to_bits(message);
        let message_bytes : [u8;32] = Deserialize::from_bits_raw::[[u8;32]](digest);
        return message_bytes;
    }

    function hash_number(value: u8) -> [u8;32] {
        // omit metadata.
        let digest: [bool; 256] = Keccak256::hash_to_bits_raw(value);
        let hash_bytes: [u8;32] = Deserialize::from_bits_raw::[[u8;32]](digest);
        return hash_bytes;
    }
}
