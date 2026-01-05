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

closure hash_number_u8:
    input r0 as u8;
    hash.keccak256.native.raw r0 into r1 as [boolean; 256u32];
    deserialize.bits.raw r1 ([boolean; 256u32]) into r2 ([u8; 32u32]);
    output r2 as [u8; 32u32];

closure hash_number:
    input r0 as u128;
    shr r0 120u8 into r1;
    and r1 255u128 into r2;
    cast r2 into r3 as u8;
    shr r0 112u8 into r4;
    and r4 255u128 into r5;
    cast r5 into r6 as u8;
    shr r0 104u8 into r7;
    and r7 255u128 into r8;
    cast r8 into r9 as u8;
    shr r0 96u8 into r10;
    and r10 255u128 into r11;
    cast r11 into r12 as u8;
    shr r0 88u8 into r13;
    and r13 255u128 into r14;
    cast r14 into r15 as u8;
    shr r0 80u8 into r16;
    and r16 255u128 into r17;
    cast r17 into r18 as u8;
    shr r0 72u8 into r19;
    and r19 255u128 into r20;
    cast r20 into r21 as u8;
    shr r0 64u8 into r22;
    and r22 255u128 into r23;
    cast r23 into r24 as u8;
    shr r0 56u8 into r25;
    and r25 255u128 into r26;
    cast r26 into r27 as u8;
    shr r0 48u8 into r28;
    and r28 255u128 into r29;
    cast r29 into r30 as u8;
    shr r0 40u8 into r31;
    and r31 255u128 into r32;
    cast r32 into r33 as u8;
    shr r0 32u8 into r34;
    and r34 255u128 into r35;
    cast r35 into r36 as u8;
    shr r0 24u8 into r37;
    and r37 255u128 into r38;
    cast r38 into r39 as u8;
    shr r0 16u8 into r40;
    and r40 255u128 into r41;
    cast r41 into r42 as u8;
    shr r0 8u8 into r43;
    and r43 255u128 into r44;
    cast r44 into r45 as u8;
    and r0 255u128 into r46;
    cast r46 into r47 as u8;
    cast r3 r6 r9 r12 r15 r18 r21 r24 r27 r30 r33 r36 r39 r42 r45 r47 into r48 as [u8; 16u32];
    hash.keccak256.native.raw r48 into r49 as [boolean; 256u32];
    deserialize.bits.raw r49 ([boolean; 256u32]) into r50 ([u8; 32u32]);
    output r50 as [u8; 32u32];

closure hash_field:
    input r0 as field;
    serialize.bits.raw r0 (field) into r1 ([boolean; 253u32]);
    cast false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false into r2 as [boolean; 256u32];
    cast r1[0u32] r1[1u32] r1[2u32] r1[3u32] r1[4u32] r1[5u32] r1[6u32] r1[7u32] r1[8u32] r1[9u32] r1[10u32] r1[11u32] r1[12u32] r1[13u32] r1[14u32] r1[15u32] r1[16u32] r1[17u32] r1[18u32] r1[19u32] r1[20u32] r1[21u32] r1[22u32] r1[23u32] r1[24u32] r1[25u32] r1[26u32] r1[27u32] r1[28u32] r1[29u32] r1[30u32] r1[31u32] r1[32u32] r1[33u32] r1[34u32] r1[35u32] r1[36u32] r1[37u32] r1[38u32] r1[39u32] r1[40u32] r1[41u32] r1[42u32] r1[43u32] r1[44u32] r1[45u32] r1[46u32] r1[47u32] r1[48u32] r1[49u32] r1[50u32] r1[51u32] r1[52u32] r1[53u32] r1[54u32] r1[55u32] r1[56u32] r1[57u32] r1[58u32] r1[59u32] r1[60u32] r1[61u32] r1[62u32] r1[63u32] r1[64u32] r1[65u32] r1[66u32] r1[67u32] r1[68u32] r1[69u32] r1[70u32] r1[71u32] r1[72u32] r1[73u32] r1[74u32] r1[75u32] r1[76u32] r1[77u32] r1[78u32] r1[79u32] r1[80u32] r1[81u32] r1[82u32] r1[83u32] r1[84u32] r1[85u32] r1[86u32] r1[87u32] r1[88u32] r1[89u32] r1[90u32] r1[91u32] r1[92u32] r1[93u32] r1[94u32] r1[95u32] r1[96u32] r1[97u32] r1[98u32] r1[99u32] r1[100u32] r1[101u32] r1[102u32] r1[103u32] r1[104u32] r1[105u32] r1[106u32] r1[107u32] r1[108u32] r1[109u32] r1[110u32] r1[111u32] r1[112u32] r1[113u32] r1[114u32] r1[115u32] r1[116u32] r1[117u32] r1[118u32] r1[119u32] r1[120u32] r1[121u32] r1[122u32] r1[123u32] r1[124u32] r1[125u32] r1[126u32] r1[127u32] r1[128u32] r1[129u32] r1[130u32] r1[131u32] r1[132u32] r1[133u32] r1[134u32] r1[135u32] r1[136u32] r1[137u32] r1[138u32] r1[139u32] r1[140u32] r1[141u32] r1[142u32] r1[143u32] r1[144u32] r1[145u32] r1[146u32] r1[147u32] r1[148u32] r1[149u32] r1[150u32] r1[151u32] r1[152u32] r1[153u32] r1[154u32] r1[155u32] r1[156u32] r1[157u32] r1[158u32] r1[159u32] r1[160u32] r1[161u32] r1[162u32] r1[163u32] r1[164u32] r1[165u32] r1[166u32] r1[167u32] r1[168u32] r1[169u32] r1[170u32] r1[171u32] r1[172u32] r1[173u32] r1[174u32] r1[175u32] r1[176u32] r1[177u32] r1[178u32] r1[179u32] r1[180u32] r1[181u32] r1[182u32] r1[183u32] r1[184u32] r1[185u32] r1[186u32] r1[187u32] r1[188u32] r1[189u32] r1[190u32] r1[191u32] r1[192u32] r1[193u32] r1[194u32] r1[195u32] r1[196u32] r1[197u32] r1[198u32] r1[199u32] r1[200u32] r1[201u32] r1[202u32] r1[203u32] r1[204u32] r1[205u32] r1[206u32] r1[207u32] r1[208u32] r1[209u32] r1[210u32] r1[211u32] r1[212u32] r1[213u32] r1[214u32] r1[215u32] r1[216u32] r1[217u32] r1[218u32] r1[219u32] r1[220u32] r1[221u32] r1[222u32] r1[223u32] r1[224u32] r1[225u32] r1[226u32] r1[227u32] r1[228u32] r1[229u32] r1[230u32] r1[231u32] r1[232u32] r1[233u32] r1[234u32] r1[235u32] r1[236u32] r1[237u32] r1[238u32] r1[239u32] r1[240u32] r1[241u32] r1[242u32] r1[243u32] r1[244u32] r1[245u32] r1[246u32] r1[247u32] r1[248u32] r1[249u32] r1[250u32] r1[251u32] r1[252u32] r2[253u32] r2[254u32] r2[255u32] into r3 as [boolean; 256u32];
    deserialize.bits.raw r3 ([boolean; 256u32]) into r4 ([u8; 32u32]);
    cast r4[31u32] r4[30u32] r4[29u32] r4[28u32] r4[27u32] r4[26u32] r4[25u32] r4[24u32] r4[23u32] r4[22u32] r4[21u32] r4[20u32] r4[19u32] r4[18u32] r4[17u32] r4[16u32] r4[15u32] r4[14u32] r4[13u32] r4[12u32] r4[11u32] r4[10u32] r4[9u32] r4[8u32] r4[7u32] r4[6u32] r4[5u32] r4[4u32] r4[3u32] r4[2u32] r4[1u32] r4[0u32] into r5 as [u8; 32u32];
    hash.keccak256.native.raw r5 into r6 as [boolean; 256u32];
    deserialize.bits.raw r6 ([boolean; 256u32]) into r7 ([u8; 32u32]);
    output r7 as [u8; 32u32];

closure hash_u128:
    input r0 as u128;
    serialize.bits.raw r0 (u128) into r1 ([boolean; 128u32]);
    cast false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false into r2 as [boolean; 256u32];
    cast r1[0u32] r1[1u32] r1[2u32] r1[3u32] r1[4u32] r1[5u32] r1[6u32] r1[7u32] r1[8u32] r1[9u32] r1[10u32] r1[11u32] r1[12u32] r1[13u32] r1[14u32] r1[15u32] r1[16u32] r1[17u32] r1[18u32] r1[19u32] r1[20u32] r1[21u32] r1[22u32] r1[23u32] r1[24u32] r1[25u32] r1[26u32] r1[27u32] r1[28u32] r1[29u32] r1[30u32] r1[31u32] r1[32u32] r1[33u32] r1[34u32] r1[35u32] r1[36u32] r1[37u32] r1[38u32] r1[39u32] r1[40u32] r1[41u32] r1[42u32] r1[43u32] r1[44u32] r1[45u32] r1[46u32] r1[47u32] r1[48u32] r1[49u32] r1[50u32] r1[51u32] r1[52u32] r1[53u32] r1[54u32] r1[55u32] r1[56u32] r1[57u32] r1[58u32] r1[59u32] r1[60u32] r1[61u32] r1[62u32] r1[63u32] r1[64u32] r1[65u32] r1[66u32] r1[67u32] r1[68u32] r1[69u32] r1[70u32] r1[71u32] r1[72u32] r1[73u32] r1[74u32] r1[75u32] r1[76u32] r1[77u32] r1[78u32] r1[79u32] r1[80u32] r1[81u32] r1[82u32] r1[83u32] r1[84u32] r1[85u32] r1[86u32] r1[87u32] r1[88u32] r1[89u32] r1[90u32] r1[91u32] r1[92u32] r1[93u32] r1[94u32] r1[95u32] r1[96u32] r1[97u32] r1[98u32] r1[99u32] r1[100u32] r1[101u32] r1[102u32] r1[103u32] r1[104u32] r1[105u32] r1[106u32] r1[107u32] r1[108u32] r1[109u32] r1[110u32] r1[111u32] r1[112u32] r1[113u32] r1[114u32] r1[115u32] r1[116u32] r1[117u32] r1[118u32] r1[119u32] r1[120u32] r1[121u32] r1[122u32] r1[123u32] r1[124u32] r1[125u32] r1[126u32] r1[127u32] r2[128u32] r2[129u32] r2[130u32] r2[131u32] r2[132u32] r2[133u32] r2[134u32] r2[135u32] r2[136u32] r2[137u32] r2[138u32] r2[139u32] r2[140u32] r2[141u32] r2[142u32] r2[143u32] r2[144u32] r2[145u32] r2[146u32] r2[147u32] r2[148u32] r2[149u32] r2[150u32] r2[151u32] r2[152u32] r2[153u32] r2[154u32] r2[155u32] r2[156u32] r2[157u32] r2[158u32] r2[159u32] r2[160u32] r2[161u32] r2[162u32] r2[163u32] r2[164u32] r2[165u32] r2[166u32] r2[167u32] r2[168u32] r2[169u32] r2[170u32] r2[171u32] r2[172u32] r2[173u32] r2[174u32] r2[175u32] r2[176u32] r2[177u32] r2[178u32] r2[179u32] r2[180u32] r2[181u32] r2[182u32] r2[183u32] r2[184u32] r2[185u32] r2[186u32] r2[187u32] r2[188u32] r2[189u32] r2[190u32] r2[191u32] r2[192u32] r2[193u32] r2[194u32] r2[195u32] r2[196u32] r2[197u32] r2[198u32] r2[199u32] r2[200u32] r2[201u32] r2[202u32] r2[203u32] r2[204u32] r2[205u32] r2[206u32] r2[207u32] r2[208u32] r2[209u32] r2[210u32] r2[211u32] r2[212u32] r2[213u32] r2[214u32] r2[215u32] r2[216u32] r2[217u32] r2[218u32] r2[219u32] r2[220u32] r2[221u32] r2[222u32] r2[223u32] r2[224u32] r2[225u32] r2[226u32] r2[227u32] r2[228u32] r2[229u32] r2[230u32] r2[231u32] r2[232u32] r2[233u32] r2[234u32] r2[235u32] r2[236u32] r2[237u32] r2[238u32] r2[239u32] r2[240u32] r2[241u32] r2[242u32] r2[243u32] r2[244u32] r2[245u32] r2[246u32] r2[247u32] r2[248u32] r2[249u32] r2[250u32] r2[251u32] r2[252u32] r2[253u32] r2[254u32] r2[255u32] into r3 as [boolean; 256u32];
    deserialize.bits.raw r3 ([boolean; 256u32]) into r4 ([u8; 32u32]);
    cast r4[31u32] r4[30u32] r4[29u32] r4[28u32] r4[27u32] r4[26u32] r4[25u32] r4[24u32] r4[23u32] r4[22u32] r4[21u32] r4[20u32] r4[19u32] r4[18u32] r4[17u32] r4[16u32] r4[15u32] r4[14u32] r4[13u32] r4[12u32] r4[11u32] r4[10u32] r4[9u32] r4[8u32] r4[7u32] r4[6u32] r4[5u32] r4[4u32] r4[3u32] r4[2u32] r4[1u32] r4[0u32] into r5 as [u8; 32u32];
    hash.keccak256.native.raw r5 into r6 as [boolean; 256u32];
    deserialize.bits.raw r6 ([boolean; 256u32]) into r7 ([u8; 32u32]);
    output r7 as [u8; 32u32];

constructor:
    assert.eq edition 0u16;
