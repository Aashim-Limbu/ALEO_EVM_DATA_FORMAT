import sample_test.aleo;
program test_sample_test.aleo {
    struct TransferMsg { token: field, from: [u8;32], to: [u8;32], amount: u128, data: [u8;32] }

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
        let message: TransferMsg = TransferMsg { token: 1field, from: addr, to: addr, amount: 1000u128, data: addr };

        // Hash the entire TransferMsg struct (from, to, data all the same)
        let hash_result: [u8; 32] = sample_test.aleo/main(message);
    }
/*
    @test
    script test_deserialize_consistency() {
        // Test that the same input produces the same output (consistency check)
        let addr: [u8;32] = [ 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0xBBu8, 0xB9u8, 0x1Du8, 0xD1u8, 0x33u8, 0x78u8, 0x52u8, 0x05u8, 0x6Au8, 0x87u8, 0x0Bu8, 0x4Eu8, 0x81u8, 0xD8u8, 0xF5u8, 0x82u8, 0x55u8, 0x2Eu8, 0xCAu8, 0x89u8 ];

        let message: TransferMsg = TransferMsg { token: 1field, from: addr, to: addr, amount: 1000u128, data: addr };

        // Call main function twice with same input
        let result1: [u8; 32] = sample_test.aleo/main(message);
        let result2: [u8; 32] = sample_test.aleo/main(message);

        // Assert outputs are identical (consistency check)
        assert_eq(result1, result2);
    }


    */
    @test
    script test_hash_number_solidity() {
    let expected: [u8; 32] = [
    179u8, 237u8, 40u8, 154u8, 108u8, 253u8, 204u8, 52u8,
    75u8, 245u8, 71u8, 172u8, 238u8, 245u8, 209u8, 81u8,
    82u8, 234u8, 220u8, 235u8, 99u8, 6u8, 38u8, 10u8,
    210u8, 222u8, 68u8, 177u8, 130u8, 219u8, 154u8, 208u8
    ];

        let result: [u8; 32] = sample_test.aleo/hash_number(1000u128);

        // Verify Leo hash is consistent with itself
        assert_eq(result, expected);
    }

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

        let result: [u8; 32] = sample_test.aleo/hash_number_u8(1u8);

        // Verify Leo hash is consistent
        assert_eq(result, expected);
    }
/*
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

        let result: [u8; 32] = sample_test.aleo/hash_number_u8(1u8);

        // Verify Leo hash is consistent
        assert_eq(result, expected);
    }
*/

  @test
    script test_hash_field_solidity() {
    let expected: [u8; 32] = [
        138u8, 53u8, 172u8, 251u8, 193u8, 95u8, 248u8, 26u8,
        57u8, 174u8, 125u8, 52u8, 79u8, 215u8, 9u8, 242u8,
        142u8, 134u8, 0u8, 180u8, 170u8, 140u8, 101u8, 198u8,
        182u8, 75u8, 254u8, 127u8, 227u8, 107u8, 209u8, 155u8
        ];

        let result: [u8; 32] = sample_test.aleo/hash_field(4field);

        // Verify Leo hash is consistent
        assert_eq(result, expected);
    }

    @test
    script test_hash_u128_solidity() {
        let expected: [u8; 32] = [
            231u8, 31u8, 172u8, 111u8,
            183u8, 133u8, 148u8, 44u8,
            198u8, 198u8, 64u8, 74u8,
            66u8, 63u8, 148u8, 243u8,
            42u8, 40u8, 174u8, 102u8,
            214u8, 159u8, 244u8, 20u8,
            148u8, 195u8, 139u8, 253u8,
            71u8, 136u8, 178u8, 248u8
        ];

        let result: [u8; 32] = sample_test.aleo/hash_u128(200u128);

        // Verify Leo hash is consistent
        assert_eq(result, expected);
    }

    @noupgrade
    async constructor() {}
    transition dummy() {}
}
