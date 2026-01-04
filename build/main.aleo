program sample_test.aleo;

struct TransferMsg:
    token as field;
    from as [u8; 32u32];
    to as [u8; 32u32];
    amount as u128;
    data as [u8; 32u32];

function main:
    input r0 as TransferMsg.private;
    hash.keccak256.native r0 into r1 as [boolean; 256u32];
    deserialize.bits.raw r1 ([boolean; 256u32]) into r2 ([u8; 32u32]);
    output r2 as [u8; 32u32].private;

closure hash_number:
    input r0 as u8;
    hash.keccak256.native.raw r0 into r1 as [boolean; 256u32];
    deserialize.bits.raw r1 ([boolean; 256u32]) into r2 ([u8; 32u32]);
    output r2 as [u8; 32u32];

constructor:
    assert.eq edition 0u16;
