import sample_test.aleo;
program test_sample_test.aleo;

struct TransferMsg:
    token as field;
    from as [u8; 32u32];
    to as [u8; 32u32];
    amount as u128;
    data as [u8; 32u32];

function dummy:

constructor:
    assert.eq edition 0u16;
