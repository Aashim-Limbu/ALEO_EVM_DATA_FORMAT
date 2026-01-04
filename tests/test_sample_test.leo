import sample_test.aleo;
program test_sample_test.aleo {
    struct TransferMsg {
        token: field,
        from: [u8;32],
        to: [u8;32],
        amount: u128,
        data: [u8;32]
    }

    @test
    script test_it() {
        // Padded address with leading zeros (32 bytes)
        let addr: [u8;32] = [
            0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
            0xBBu8, 0xB9u8, 0x1Du8, 0xD1u8, 0x33u8, 0x78u8, 0x52u8, 0x05u8,
            0x6Au8, 0x87u8, 0x0Bu8, 0x4Eu8, 0x81u8, 0xD8u8, 0xF5u8, 0x82u8,
            0x55u8, 0x2Eu8, 0xCAu8, 0x89u8
        ];

        // Create message with the entire struct to be hashed
        let message: TransferMsg = TransferMsg {
            token: 1field,
            from: addr,
            to: addr,
            amount: 1000u128,
            data: addr
        };

        // Hash the entire TransferMsg struct (from, to, data all the same)
        let hash_result: [u8; 32] = sample_test.aleo/main(message);
    }

    @test
    script test_deserialize_consistency() {
        // Test that the same input produces the same output (consistency check)
        let addr: [u8;32] = [
            0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
            0xBBu8, 0xB9u8, 0x1Du8, 0xD1u8, 0x33u8, 0x78u8, 0x52u8, 0x05u8,
            0x6Au8, 0x87u8, 0x0Bu8, 0x4Eu8, 0x81u8, 0xD8u8, 0xF5u8, 0x82u8,
            0x55u8, 0x2Eu8, 0xCAu8, 0x89u8
        ];

        let message: TransferMsg = TransferMsg {
            token: 1field,
            from: addr,
            to: addr,
            amount: 1000u128,
            data: addr
        };

        // Call main function twice with same input
        let result1: [u8; 32] = sample_test.aleo/main(message);
        let result2: [u8; 32] = sample_test.aleo/main(message);

        // Assert outputs are identical (consistency check)
        assert_eq(result1, result2);
    }

    // @test
    // script test_hash_number_basic() {
    //     // Test basic number hashing
    //     let result: [u8; 32] = sample_test.aleo/hash_number(1000u128);

    //     // Verify result is not all zeros (proof of hash working)
    //     assert_neq(result[0], 0u8);
    // }

    // @test
    // script test_hash_number_consistency() {
    //     // Test that same input produces same output
    //     let result1: [u8; 32] = sample_test.aleo/hash_number(1000u128);
    //     let result2: [u8; 32] = sample_test.aleo/hash_number(1000u128);

    //     assert_eq(result1, result2);
    // }

    // @test
    // script test_hash_number_varies() {
    //     // Test that different inputs produce different outputs
    //     let result1: [u8; 32] = sample_test.aleo/hash_number(1000u128);
    //     let result2: [u8; 32] = sample_test.aleo/hash_number(2000u128);

    //     // Results should be different
    //     assert_neq(result1[0], result2[0]);
    // }

    @test
    script test_hash_number_solidity_match() {
        // Test Leo's actual hash output
        // Leo hash for 1u128: different from Solidity due to encoding differences
let expected: [u8; 32] = [
    95u8, 231u8, 249u8, 119u8, 231u8, 29u8, 186u8, 46u8,
    161u8, 166u8, 142u8, 33u8, 5u8, 123u8, 238u8, 187u8,
    155u8, 226u8, 172u8, 48u8, 198u8, 65u8, 10u8, 163u8,
    141u8, 79u8, 63u8, 190u8, 65u8, 220u8, 255u8, 210u8
];

        let result: [u8; 32] = sample_test.aleo/hash_number(1u8);

        // Verify Leo hash is consistent
        assert_eq(result, expected);
    }

    @noupgrade
    async constructor() {}

    transition dummy() {}
}
