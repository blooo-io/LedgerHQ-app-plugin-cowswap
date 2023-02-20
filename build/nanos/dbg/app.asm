
build/nanos/bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
    libcall_params[1] = 0x100;
    libcall_params[2] = RUN_APPLICATION;
    os_lib_call((unsigned int *) &libcall_params);
}

__attribute__((section(".boot"))) int main(int arg0) {
c0d00000:	b570      	push	{r4, r5, r6, lr}
c0d00002:	b090      	sub	sp, #64	; 0x40
c0d00004:	4604      	mov	r4, r0
    // exit critical section
    __asm volatile("cpsie i");
c0d00006:	b662      	cpsie	i

    // ensure exception will work as planned
    os_boot();
c0d00008:	f000 fc50 	bl	c0d008ac <os_boot>
c0d0000c:	ad01      	add	r5, sp, #4

    BEGIN_TRY {
        TRY {
c0d0000e:	4628      	mov	r0, r5
c0d00010:	f001 f830 	bl	c0d01074 <setjmp>
c0d00014:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00016:	b285      	uxth	r5, r0
c0d00018:	2d00      	cmp	r5, #0
c0d0001a:	d019      	beq.n	c0d00050 <main+0x50>
c0d0001c:	a801      	add	r0, sp, #4
c0d0001e:	2600      	movs	r6, #0
                    dispatch_plugin_calls(args[0], (void *) args[1]);
                }
                os_lib_end();
            }
        }
        CATCH_OTHER(e) {
c0d00020:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d00022:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00024:	f000 fe76 	bl	c0d00d14 <try_context_set>
c0d00028:	4823      	ldr	r0, [pc, #140]	; (c0d000b8 <main+0xb8>)
            switch (e) {
c0d0002a:	4285      	cmp	r5, r0
c0d0002c:	d001      	beq.n	c0d00032 <main+0x32>
c0d0002e:	2d07      	cmp	r5, #7
c0d00030:	d108      	bne.n	c0d00044 <main+0x44>
    switch (args[0]) {
c0d00032:	6820      	ldr	r0, [r4, #0]
c0d00034:	2101      	movs	r1, #1
c0d00036:	0209      	lsls	r1, r1, #8
c0d00038:	1d89      	adds	r1, r1, #6
c0d0003a:	4288      	cmp	r0, r1
c0d0003c:	d102      	bne.n	c0d00044 <main+0x44>
            ((ethQueryContractUI_t *) args[1])->result = ETH_PLUGIN_RESULT_ERROR;
c0d0003e:	6860      	ldr	r0, [r4, #4]
c0d00040:	2134      	movs	r1, #52	; 0x34
c0d00042:	5446      	strb	r6, [r0, r1]
                    handle_query_ui_exception((unsigned int *) arg0);
                    break;
                default:
                    break;
            }
            PRINTF("Exception 0x%x caught\n", e);
c0d00044:	481e      	ldr	r0, [pc, #120]	; (c0d000c0 <main+0xc0>)
c0d00046:	4478      	add	r0, pc
c0d00048:	4629      	mov	r1, r5
c0d0004a:	f000 fc57 	bl	c0d008fc <mcu_usb_printf>
c0d0004e:	e017      	b.n	c0d00080 <main+0x80>
c0d00050:	a801      	add	r0, sp, #4
        TRY {
c0d00052:	f000 fe5f 	bl	c0d00d14 <try_context_set>
c0d00056:	900b      	str	r0, [sp, #44]	; 0x2c
// get API level
SYSCALL unsigned int get_api_level(void);

#ifndef HAVE_BOLOS
static inline void check_api_level(unsigned int apiLevel) {
  if (apiLevel < get_api_level()) {
c0d00058:	f000 fe0e 	bl	c0d00c78 <get_api_level>
c0d0005c:	280d      	cmp	r0, #13
c0d0005e:	d302      	bcc.n	c0d00066 <main+0x66>
c0d00060:	20ff      	movs	r0, #255	; 0xff
    os_sched_exit(-1);
c0d00062:	f000 fe31 	bl	c0d00cc8 <os_sched_exit>
c0d00066:	2001      	movs	r0, #1
c0d00068:	0201      	lsls	r1, r0, #8
            if (!arg0) {
c0d0006a:	2c00      	cmp	r4, #0
c0d0006c:	d019      	beq.n	c0d000a2 <main+0xa2>
                if (args[0] != ETH_PLUGIN_CHECK_PRESENCE) {
c0d0006e:	6820      	ldr	r0, [r4, #0]
c0d00070:	31ff      	adds	r1, #255	; 0xff
c0d00072:	4288      	cmp	r0, r1
c0d00074:	d002      	beq.n	c0d0007c <main+0x7c>
                    dispatch_plugin_calls(args[0], (void *) args[1]);
c0d00076:	6861      	ldr	r1, [r4, #4]
c0d00078:	f000 fba8 	bl	c0d007cc <dispatch_plugin_calls>
                os_lib_end();
c0d0007c:	f000 fe18 	bl	c0d00cb0 <os_lib_end>
        }
        FINALLY {
c0d00080:	f000 fe3c 	bl	c0d00cfc <try_context_get>
c0d00084:	a901      	add	r1, sp, #4
c0d00086:	4288      	cmp	r0, r1
c0d00088:	d102      	bne.n	c0d00090 <main+0x90>
c0d0008a:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0008c:	f000 fe42 	bl	c0d00d14 <try_context_set>
            // Call `os_lib_end`, go back to the ethereum app.
            os_lib_end();
c0d00090:	f000 fe0e 	bl	c0d00cb0 <os_lib_end>
c0d00094:	a801      	add	r0, sp, #4
        }
    }
    END_TRY;
c0d00096:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00098:	2800      	cmp	r0, #0
c0d0009a:	d10b      	bne.n	c0d000b4 <main+0xb4>
c0d0009c:	2000      	movs	r0, #0

    return 0;
}
c0d0009e:	b010      	add	sp, #64	; 0x40
c0d000a0:	bd70      	pop	{r4, r5, r6, pc}
    libcall_params[2] = RUN_APPLICATION;
c0d000a2:	900f      	str	r0, [sp, #60]	; 0x3c
    libcall_params[1] = 0x100;
c0d000a4:	910e      	str	r1, [sp, #56]	; 0x38
    libcall_params[0] = (unsigned int) "Ethereum";
c0d000a6:	4805      	ldr	r0, [pc, #20]	; (c0d000bc <main+0xbc>)
c0d000a8:	4478      	add	r0, pc
c0d000aa:	900d      	str	r0, [sp, #52]	; 0x34
c0d000ac:	a80d      	add	r0, sp, #52	; 0x34
    os_lib_call((unsigned int *) &libcall_params);
c0d000ae:	f000 fdf1 	bl	c0d00c94 <os_lib_call>
c0d000b2:	e7f3      	b.n	c0d0009c <main+0x9c>
    END_TRY;
c0d000b4:	f000 fc00 	bl	c0d008b8 <os_longjmp>
c0d000b8:	00006502 	.word	0x00006502
c0d000bc:	000012b3 	.word	0x000012b3
c0d000c0:	0000131e 	.word	0x0000131e

c0d000c4 <adjustDecimals>:

bool adjustDecimals(const char *src,
                    size_t srcLength,
                    char *target,
                    size_t targetLength,
                    uint8_t decimals) {
c0d000c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000c6:	b081      	sub	sp, #4
c0d000c8:	4614      	mov	r4, r2
c0d000ca:	460e      	mov	r6, r1
c0d000cc:	4605      	mov	r5, r0
    uint32_t startOffset;
    uint32_t lastZeroOffset = 0;
    uint32_t offset = 0;
    if ((srcLength == 1) && (*src == '0')) {
c0d000ce:	2901      	cmp	r1, #1
c0d000d0:	d10a      	bne.n	c0d000e8 <adjustDecimals+0x24>
c0d000d2:	7828      	ldrb	r0, [r5, #0]
c0d000d4:	2830      	cmp	r0, #48	; 0x30
c0d000d6:	d107      	bne.n	c0d000e8 <adjustDecimals+0x24>
        if (targetLength < 2) {
c0d000d8:	2b02      	cmp	r3, #2
c0d000da:	d32e      	bcc.n	c0d0013a <adjustDecimals+0x76>
c0d000dc:	2000      	movs	r0, #0
            return false;
        }
        target[0] = '0';
        target[1] = '\0';
c0d000de:	7060      	strb	r0, [r4, #1]
c0d000e0:	2030      	movs	r0, #48	; 0x30
        target[0] = '0';
c0d000e2:	7020      	strb	r0, [r4, #0]
c0d000e4:	2001      	movs	r0, #1
c0d000e6:	e05f      	b.n	c0d001a8 <adjustDecimals+0xe4>
c0d000e8:	9806      	ldr	r0, [sp, #24]
        return true;
    }
    if (srcLength <= decimals) {
c0d000ea:	42b0      	cmp	r0, r6
c0d000ec:	d222      	bcs.n	c0d00134 <adjustDecimals+0x70>
        }
        target[offset] = '\0';
    } else {
        uint32_t sourceOffset = 0;
        uint32_t delta = srcLength - decimals;
        if (targetLength < srcLength + 1 + 1) {
c0d000ee:	1cb1      	adds	r1, r6, #2
c0d000f0:	4299      	cmp	r1, r3
c0d000f2:	d822      	bhi.n	c0d0013a <adjustDecimals+0x76>
c0d000f4:	1a31      	subs	r1, r6, r0
            return false;
        }
        while (offset < delta) {
c0d000f6:	9100      	str	r1, [sp, #0]
c0d000f8:	d009      	beq.n	c0d0010e <adjustDecimals+0x4a>
c0d000fa:	4629      	mov	r1, r5
c0d000fc:	9b00      	ldr	r3, [sp, #0]
c0d000fe:	4627      	mov	r7, r4
            target[offset++] = src[sourceOffset++];
c0d00100:	780a      	ldrb	r2, [r1, #0]
c0d00102:	703a      	strb	r2, [r7, #0]
        while (offset < delta) {
c0d00104:	1c49      	adds	r1, r1, #1
c0d00106:	1e5b      	subs	r3, r3, #1
c0d00108:	1c7f      	adds	r7, r7, #1
c0d0010a:	2b00      	cmp	r3, #0
c0d0010c:	d1f8      	bne.n	c0d00100 <adjustDecimals+0x3c>
        }
        if (decimals != 0) {
c0d0010e:	2800      	cmp	r0, #0
c0d00110:	9a00      	ldr	r2, [sp, #0]
c0d00112:	4611      	mov	r1, r2
c0d00114:	d002      	beq.n	c0d0011c <adjustDecimals+0x58>
c0d00116:	212e      	movs	r1, #46	; 0x2e
            target[offset++] = '.';
c0d00118:	54a1      	strb	r1, [r4, r2]
c0d0011a:	1c51      	adds	r1, r2, #1
        }
        startOffset = offset;
        while (sourceOffset < srcLength) {
c0d0011c:	42b2      	cmp	r2, r6
c0d0011e:	d228      	bcs.n	c0d00172 <adjustDecimals+0xae>
c0d00120:	1863      	adds	r3, r4, r1
c0d00122:	18ad      	adds	r5, r5, r2
c0d00124:	2200      	movs	r2, #0
            target[offset++] = src[sourceOffset++];
c0d00126:	5cae      	ldrb	r6, [r5, r2]
c0d00128:	549e      	strb	r6, [r3, r2]
        while (sourceOffset < srcLength) {
c0d0012a:	1c52      	adds	r2, r2, #1
c0d0012c:	4290      	cmp	r0, r2
c0d0012e:	d1fa      	bne.n	c0d00126 <adjustDecimals+0x62>
c0d00130:	188a      	adds	r2, r1, r2
c0d00132:	e01f      	b.n	c0d00174 <adjustDecimals+0xb0>
        if (targetLength < srcLength + 1 + 2 + delta) {
c0d00134:	1cc1      	adds	r1, r0, #3
c0d00136:	4299      	cmp	r1, r3
c0d00138:	d901      	bls.n	c0d0013e <adjustDecimals+0x7a>
c0d0013a:	2000      	movs	r0, #0
c0d0013c:	e034      	b.n	c0d001a8 <adjustDecimals+0xe4>
c0d0013e:	1b87      	subs	r7, r0, r6
c0d00140:	202e      	movs	r0, #46	; 0x2e
        target[offset++] = '.';
c0d00142:	7060      	strb	r0, [r4, #1]
c0d00144:	2030      	movs	r0, #48	; 0x30
        target[offset++] = '0';
c0d00146:	7020      	strb	r0, [r4, #0]
        for (uint32_t i = 0; i < delta; i++) {
c0d00148:	2f00      	cmp	r7, #0
c0d0014a:	d006      	beq.n	c0d0015a <adjustDecimals+0x96>
c0d0014c:	1ca0      	adds	r0, r4, #2
c0d0014e:	2230      	movs	r2, #48	; 0x30
            target[offset++] = '0';
c0d00150:	4639      	mov	r1, r7
c0d00152:	f000 fe67 	bl	c0d00e24 <__aeabi_memset>
        for (uint32_t i = 0; i < delta; i++) {
c0d00156:	1cb9      	adds	r1, r7, #2
c0d00158:	e000      	b.n	c0d0015c <adjustDecimals+0x98>
c0d0015a:	2102      	movs	r1, #2
        for (uint32_t i = 0; i < srcLength; i++) {
c0d0015c:	2e00      	cmp	r6, #0
c0d0015e:	d008      	beq.n	c0d00172 <adjustDecimals+0xae>
c0d00160:	1862      	adds	r2, r4, r1
c0d00162:	2000      	movs	r0, #0
            target[offset++] = src[i];
c0d00164:	5c2b      	ldrb	r3, [r5, r0]
c0d00166:	5413      	strb	r3, [r2, r0]
        for (uint32_t i = 0; i < srcLength; i++) {
c0d00168:	1c40      	adds	r0, r0, #1
c0d0016a:	4286      	cmp	r6, r0
c0d0016c:	d1fa      	bne.n	c0d00164 <adjustDecimals+0xa0>
c0d0016e:	180a      	adds	r2, r1, r0
c0d00170:	e000      	b.n	c0d00174 <adjustDecimals+0xb0>
c0d00172:	460a      	mov	r2, r1
c0d00174:	2500      	movs	r5, #0
c0d00176:	54a5      	strb	r5, [r4, r2]
c0d00178:	2001      	movs	r0, #1
        }
        target[offset] = '\0';
    }
    for (uint32_t i = startOffset; i < offset; i++) {
c0d0017a:	4291      	cmp	r1, r2
c0d0017c:	d214      	bcs.n	c0d001a8 <adjustDecimals+0xe4>
        if (target[i] == '0') {
c0d0017e:	2d00      	cmp	r5, #0
c0d00180:	460b      	mov	r3, r1
c0d00182:	d000      	beq.n	c0d00186 <adjustDecimals+0xc2>
c0d00184:	462b      	mov	r3, r5
c0d00186:	5c65      	ldrb	r5, [r4, r1]
c0d00188:	2d30      	cmp	r5, #48	; 0x30
c0d0018a:	d000      	beq.n	c0d0018e <adjustDecimals+0xca>
c0d0018c:	2300      	movs	r3, #0
    for (uint32_t i = startOffset; i < offset; i++) {
c0d0018e:	1c49      	adds	r1, r1, #1
c0d00190:	428a      	cmp	r2, r1
c0d00192:	461d      	mov	r5, r3
c0d00194:	d1f3      	bne.n	c0d0017e <adjustDecimals+0xba>
            }
        } else {
            lastZeroOffset = 0;
        }
    }
    if (lastZeroOffset != 0) {
c0d00196:	2b00      	cmp	r3, #0
c0d00198:	d006      	beq.n	c0d001a8 <adjustDecimals+0xe4>
c0d0019a:	2100      	movs	r1, #0
        target[lastZeroOffset] = '\0';
c0d0019c:	54e1      	strb	r1, [r4, r3]
        if (target[lastZeroOffset - 1] == '.') {
c0d0019e:	1e5a      	subs	r2, r3, #1
c0d001a0:	5ca3      	ldrb	r3, [r4, r2]
c0d001a2:	2b2e      	cmp	r3, #46	; 0x2e
c0d001a4:	d100      	bne.n	c0d001a8 <adjustDecimals+0xe4>
            target[lastZeroOffset - 1] = '\0';
c0d001a6:	54a1      	strb	r1, [r4, r2]
        }
    }
    return true;
}
c0d001a8:	b001      	add	sp, #4
c0d001aa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d001ac <uint256_to_decimal>:

bool uint256_to_decimal(const uint8_t *value, size_t value_len, char *out, size_t out_len) {
c0d001ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d001ae:	b08d      	sub	sp, #52	; 0x34
c0d001b0:	9301      	str	r3, [sp, #4]
c0d001b2:	9203      	str	r2, [sp, #12]
    if (value_len > INT256_LENGTH) {
c0d001b4:	2920      	cmp	r1, #32
c0d001b6:	d902      	bls.n	c0d001be <uint256_to_decimal+0x12>
c0d001b8:	2000      	movs	r0, #0
        out[pos] = '0' + carry;
    }
    memmove(out, out + pos, out_len - pos);
    out[out_len - pos] = 0;
    return true;
}
c0d001ba:	b00d      	add	sp, #52	; 0x34
c0d001bc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d001be:	460e      	mov	r6, r1
c0d001c0:	4607      	mov	r7, r0
c0d001c2:	ad05      	add	r5, sp, #20
c0d001c4:	2120      	movs	r1, #32
    uint16_t n[16] = {0};
c0d001c6:	4628      	mov	r0, r5
c0d001c8:	f000 fe1e 	bl	c0d00e08 <__aeabi_memclr>
    memcpy((uint8_t *) n + INT256_LENGTH - value_len, value, value_len);
c0d001cc:	1ba8      	subs	r0, r5, r6
c0d001ce:	3020      	adds	r0, #32
c0d001d0:	4639      	mov	r1, r7
c0d001d2:	4632      	mov	r2, r6
c0d001d4:	f000 fe1e 	bl	c0d00e14 <__aeabi_memcpy>
} extraInfo_t;

static __attribute__((no_instrument_function)) inline int allzeroes(const void *buf, size_t n) {
    uint8_t *p = (uint8_t *) buf;
    for (size_t i = 0; i < n; ++i) {
        if (p[i]) {
c0d001d8:	7828      	ldrb	r0, [r5, #0]
c0d001da:	2800      	cmp	r0, #0
c0d001dc:	d10a      	bne.n	c0d001f4 <uint256_to_decimal+0x48>
c0d001de:	a805      	add	r0, sp, #20
    for (size_t i = 0; i < n; ++i) {
c0d001e0:	1c41      	adds	r1, r0, #1
c0d001e2:	2000      	movs	r0, #0
        if (p[i]) {
c0d001e4:	5c0a      	ldrb	r2, [r1, r0]
c0d001e6:	2a00      	cmp	r2, #0
c0d001e8:	d102      	bne.n	c0d001f0 <uint256_to_decimal+0x44>
    for (size_t i = 0; i < n; ++i) {
c0d001ea:	1c40      	adds	r0, r0, #1
c0d001ec:	281f      	cmp	r0, #31
c0d001ee:	d1f9      	bne.n	c0d001e4 <uint256_to_decimal+0x38>
    if (allzeroes(n, INT256_LENGTH)) {
c0d001f0:	281f      	cmp	r0, #31
c0d001f2:	d23f      	bcs.n	c0d00274 <uint256_to_decimal+0xc8>
c0d001f4:	2000      	movs	r0, #0
c0d001f6:	a905      	add	r1, sp, #20
        n[i] = __builtin_bswap16(*p++);
c0d001f8:	5a0a      	ldrh	r2, [r1, r0]
c0d001fa:	ba52      	rev16	r2, r2
c0d001fc:	520a      	strh	r2, [r1, r0]
    for (int i = 0; i < 16; i++) {
c0d001fe:	1c80      	adds	r0, r0, #2
c0d00200:	2820      	cmp	r0, #32
c0d00202:	d1f8      	bne.n	c0d001f6 <uint256_to_decimal+0x4a>
c0d00204:	a805      	add	r0, sp, #20
    while (!allzeroes(n, sizeof(n))) {
c0d00206:	1c43      	adds	r3, r0, #1
c0d00208:	9a01      	ldr	r2, [sp, #4]
c0d0020a:	9302      	str	r3, [sp, #8]
c0d0020c:	a805      	add	r0, sp, #20
        if (p[i]) {
c0d0020e:	7800      	ldrb	r0, [r0, #0]
c0d00210:	2800      	cmp	r0, #0
c0d00212:	d108      	bne.n	c0d00226 <uint256_to_decimal+0x7a>
c0d00214:	2000      	movs	r0, #0
c0d00216:	5c19      	ldrb	r1, [r3, r0]
c0d00218:	2900      	cmp	r1, #0
c0d0021a:	d102      	bne.n	c0d00222 <uint256_to_decimal+0x76>
    for (size_t i = 0; i < n; ++i) {
c0d0021c:	1c40      	adds	r0, r0, #1
c0d0021e:	281f      	cmp	r0, #31
c0d00220:	d1f9      	bne.n	c0d00216 <uint256_to_decimal+0x6a>
c0d00222:	281e      	cmp	r0, #30
c0d00224:	d81b      	bhi.n	c0d0025e <uint256_to_decimal+0xb2>
        if (pos == 0) {
c0d00226:	2a00      	cmp	r2, #0
c0d00228:	d0c6      	beq.n	c0d001b8 <uint256_to_decimal+0xc>
c0d0022a:	9204      	str	r2, [sp, #16]
c0d0022c:	2700      	movs	r7, #0
c0d0022e:	4638      	mov	r0, r7
c0d00230:	ac05      	add	r4, sp, #20
            int rem = ((carry << 16) | n[i]) % 10;
c0d00232:	5be1      	ldrh	r1, [r4, r7]
c0d00234:	0400      	lsls	r0, r0, #16
c0d00236:	1845      	adds	r5, r0, r1
c0d00238:	260a      	movs	r6, #10
            n[i] = ((carry << 16) | n[i]) / 10;
c0d0023a:	4628      	mov	r0, r5
c0d0023c:	4631      	mov	r1, r6
c0d0023e:	f000 fd77 	bl	c0d00d30 <__udivsi3>
c0d00242:	53e0      	strh	r0, [r4, r7]
c0d00244:	4346      	muls	r6, r0
c0d00246:	1ba8      	subs	r0, r5, r6
        for (int i = 0; i < 16; i++) {
c0d00248:	1cbf      	adds	r7, r7, #2
c0d0024a:	2f20      	cmp	r7, #32
c0d0024c:	d1f0      	bne.n	c0d00230 <uint256_to_decimal+0x84>
c0d0024e:	2130      	movs	r1, #48	; 0x30
        out[pos] = '0' + carry;
c0d00250:	4308      	orrs	r0, r1
c0d00252:	9a04      	ldr	r2, [sp, #16]
        pos -= 1;
c0d00254:	1e52      	subs	r2, r2, #1
        out[pos] = '0' + carry;
c0d00256:	9903      	ldr	r1, [sp, #12]
c0d00258:	5488      	strb	r0, [r1, r2]
c0d0025a:	9b02      	ldr	r3, [sp, #8]
c0d0025c:	e7d6      	b.n	c0d0020c <uint256_to_decimal+0x60>
c0d0025e:	9c03      	ldr	r4, [sp, #12]
    memmove(out, out + pos, out_len - pos);
c0d00260:	18a1      	adds	r1, r4, r2
c0d00262:	9801      	ldr	r0, [sp, #4]
c0d00264:	1a85      	subs	r5, r0, r2
c0d00266:	4620      	mov	r0, r4
c0d00268:	462a      	mov	r2, r5
c0d0026a:	f000 fdd7 	bl	c0d00e1c <__aeabi_memmove>
c0d0026e:	2000      	movs	r0, #0
    out[out_len - pos] = 0;
c0d00270:	5560      	strb	r0, [r4, r5]
c0d00272:	e007      	b.n	c0d00284 <uint256_to_decimal+0xd8>
c0d00274:	9a01      	ldr	r2, [sp, #4]
        if (out_len < 2) {
c0d00276:	2a02      	cmp	r2, #2
c0d00278:	d39e      	bcc.n	c0d001b8 <uint256_to_decimal+0xc>
        strlcpy(out, "0", out_len);
c0d0027a:	4903      	ldr	r1, [pc, #12]	; (c0d00288 <uint256_to_decimal+0xdc>)
c0d0027c:	4479      	add	r1, pc
c0d0027e:	9803      	ldr	r0, [sp, #12]
c0d00280:	f000 ff12 	bl	c0d010a8 <strlcpy>
c0d00284:	2001      	movs	r0, #1
c0d00286:	e798      	b.n	c0d001ba <uint256_to_decimal+0xe>
c0d00288:	00000ed2 	.word	0x00000ed2

c0d0028c <amountToString>:
void amountToString(const uint8_t *amount,
                    uint8_t amount_size,
                    uint8_t decimals,
                    const char *ticker,
                    char *out_buffer,
                    size_t out_buffer_size) {
c0d0028c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0028e:	b09d      	sub	sp, #116	; 0x74
c0d00290:	9303      	str	r3, [sp, #12]
c0d00292:	9202      	str	r2, [sp, #8]
c0d00294:	460c      	mov	r4, r1
c0d00296:	4605      	mov	r5, r0
c0d00298:	af04      	add	r7, sp, #16
c0d0029a:	2664      	movs	r6, #100	; 0x64
    char tmp_buffer[100] = {0};
c0d0029c:	4638      	mov	r0, r7
c0d0029e:	4631      	mov	r1, r6
c0d002a0:	f000 fdb2 	bl	c0d00e08 <__aeabi_memclr>

    if (uint256_to_decimal(amount, amount_size, tmp_buffer, sizeof(tmp_buffer)) == false) {
c0d002a4:	4628      	mov	r0, r5
c0d002a6:	4621      	mov	r1, r4
c0d002a8:	463a      	mov	r2, r7
c0d002aa:	4633      	mov	r3, r6
c0d002ac:	f7ff ff7e 	bl	c0d001ac <uint256_to_decimal>
c0d002b0:	2800      	cmp	r0, #0
c0d002b2:	d02e      	beq.n	c0d00312 <amountToString+0x86>
c0d002b4:	9e23      	ldr	r6, [sp, #140]	; 0x8c
c0d002b6:	9d22      	ldr	r5, [sp, #136]	; 0x88
c0d002b8:	a804      	add	r0, sp, #16
c0d002ba:	2164      	movs	r1, #100	; 0x64
        THROW(EXCEPTION_OVERFLOW);
    }

    uint8_t amount_len = strnlen(tmp_buffer, sizeof(tmp_buffer));
c0d002bc:	f000 ff1c 	bl	c0d010f8 <strnlen>
c0d002c0:	9001      	str	r0, [sp, #4]
c0d002c2:	210b      	movs	r1, #11
    uint8_t ticker_len = strnlen(ticker, MAX_TICKER_LEN);
c0d002c4:	9803      	ldr	r0, [sp, #12]
c0d002c6:	f000 ff17 	bl	c0d010f8 <strnlen>
c0d002ca:	4604      	mov	r4, r0

    memcpy(out_buffer, ticker, MIN(out_buffer_size, ticker_len));
c0d002cc:	b2c7      	uxtb	r7, r0
c0d002ce:	42b7      	cmp	r7, r6
c0d002d0:	4632      	mov	r2, r6
c0d002d2:	d800      	bhi.n	c0d002d6 <amountToString+0x4a>
c0d002d4:	463a      	mov	r2, r7
c0d002d6:	4628      	mov	r0, r5
c0d002d8:	9903      	ldr	r1, [sp, #12]
c0d002da:	f000 fd9b 	bl	c0d00e14 <__aeabi_memcpy>
    if (ticker_len > 0) {
c0d002de:	2f00      	cmp	r7, #0
c0d002e0:	d004      	beq.n	c0d002ec <amountToString+0x60>
c0d002e2:	2020      	movs	r0, #32
        out_buffer[ticker_len++] = ' ';
c0d002e4:	55e8      	strb	r0, [r5, r7]
c0d002e6:	1c60      	adds	r0, r4, #1
    }

    if (adjustDecimals(tmp_buffer,
                       amount_len,
                       out_buffer + ticker_len,
c0d002e8:	b2c0      	uxtb	r0, r0
c0d002ea:	e000      	b.n	c0d002ee <amountToString+0x62>
c0d002ec:	2000      	movs	r0, #0
c0d002ee:	9902      	ldr	r1, [sp, #8]
    if (adjustDecimals(tmp_buffer,
c0d002f0:	9100      	str	r1, [sp, #0]
                       out_buffer + ticker_len,
c0d002f2:	182a      	adds	r2, r5, r0
                       out_buffer_size - ticker_len - 1,
c0d002f4:	43c0      	mvns	r0, r0
c0d002f6:	1983      	adds	r3, r0, r6
                       amount_len,
c0d002f8:	9801      	ldr	r0, [sp, #4]
c0d002fa:	b2c1      	uxtb	r1, r0
c0d002fc:	a804      	add	r0, sp, #16
    if (adjustDecimals(tmp_buffer,
c0d002fe:	f7ff fee1 	bl	c0d000c4 <adjustDecimals>
c0d00302:	2800      	cmp	r0, #0
c0d00304:	d005      	beq.n	c0d00312 <amountToString+0x86>
                       decimals) == false) {
        THROW(EXCEPTION_OVERFLOW);
    }

    out_buffer[out_buffer_size - 1] = '\0';
c0d00306:	1970      	adds	r0, r6, r5
c0d00308:	1e40      	subs	r0, r0, #1
c0d0030a:	2100      	movs	r1, #0
c0d0030c:	7001      	strb	r1, [r0, #0]
}
c0d0030e:	b01d      	add	sp, #116	; 0x74
c0d00310:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00312:	2007      	movs	r0, #7
c0d00314:	f000 fad0 	bl	c0d008b8 <os_longjmp>

c0d00318 <handle_finalize>:
static void received_network_token(cowswap_parameters_t *context) {
    context->decimals_received = WEI_TO_ETHER;
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
}

void handle_finalize(void *parameters) {
c0d00318:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0031a:	b083      	sub	sp, #12
c0d0031c:	4604      	mov	r4, r0
    ethPluginFinalize_t *msg = (ethPluginFinalize_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0d0031e:	6885      	ldr	r5, [r0, #8]
c0d00320:	2084      	movs	r0, #132	; 0x84
    
    if (context->valid) {
c0d00322:	5c28      	ldrb	r0, [r5, r0]
c0d00324:	2800      	cmp	r0, #0
c0d00326:	d02d      	beq.n	c0d00384 <handle_finalize+0x6c>
c0d00328:	4628      	mov	r0, r5
c0d0032a:	3083      	adds	r0, #131	; 0x83
c0d0032c:	9002      	str	r0, [sp, #8]
c0d0032e:	2602      	movs	r6, #2
        msg->numScreens = 2;
c0d00330:	7766      	strb	r6, [r4, #29]
        if (!ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
c0d00332:	462f      	mov	r7, r5
c0d00334:	3740      	adds	r7, #64	; 0x40
c0d00336:	4936      	ldr	r1, [pc, #216]	; (c0d00410 <handle_finalize+0xf8>)
c0d00338:	4479      	add	r1, pc
c0d0033a:	2214      	movs	r2, #20
c0d0033c:	4638      	mov	r0, r7
c0d0033e:	f000 fd79 	bl	c0d00e34 <memcmp>
c0d00342:	2800      	cmp	r0, #0
c0d00344:	d024      	beq.n	c0d00390 <handle_finalize+0x78>
c0d00346:	4933      	ldr	r1, [pc, #204]	; (c0d00414 <handle_finalize+0xfc>)
c0d00348:	4479      	add	r1, pc
c0d0034a:	2214      	movs	r2, #20
c0d0034c:	4638      	mov	r0, r7
c0d0034e:	f000 fd71 	bl	c0d00e34 <memcmp>
c0d00352:	2800      	cmp	r0, #0
c0d00354:	d01c      	beq.n	c0d00390 <handle_finalize+0x78>
c0d00356:	9600      	str	r6, [sp, #0]
c0d00358:	9401      	str	r4, [sp, #4]
void handle_query_contract_id(void *parameters);

static inline void printf_hex_array(const char *title __attribute__((unused)),
                                    size_t len __attribute__((unused)),
                                    const uint8_t *data __attribute__((unused))) {
    PRINTF(title);
c0d0035a:	482f      	ldr	r0, [pc, #188]	; (c0d00418 <handle_finalize+0x100>)
c0d0035c:	4478      	add	r0, pc
c0d0035e:	f000 facd 	bl	c0d008fc <mcu_usb_printf>
c0d00362:	2440      	movs	r4, #64	; 0x40
c0d00364:	4e2d      	ldr	r6, [pc, #180]	; (c0d0041c <handle_finalize+0x104>)
c0d00366:	447e      	add	r6, pc
    for (size_t i = 0; i < len; ++i) {
        PRINTF("%02x", data[i]);
c0d00368:	5d29      	ldrb	r1, [r5, r4]
c0d0036a:	4630      	mov	r0, r6
c0d0036c:	f000 fac6 	bl	c0d008fc <mcu_usb_printf>
    for (size_t i = 0; i < len; ++i) {
c0d00370:	1c64      	adds	r4, r4, #1
c0d00372:	2c54      	cmp	r4, #84	; 0x54
c0d00374:	d1f8      	bne.n	c0d00368 <handle_finalize+0x50>
    };
    PRINTF("\n");
c0d00376:	482a      	ldr	r0, [pc, #168]	; (c0d00420 <handle_finalize+0x108>)
c0d00378:	4478      	add	r0, pc
c0d0037a:	f000 fabf 	bl	c0d008fc <mcu_usb_printf>
c0d0037e:	9c01      	ldr	r4, [sp, #4]
c0d00380:	9e00      	ldr	r6, [sp, #0]
c0d00382:	e00d      	b.n	c0d003a0 <handle_finalize+0x88>
        }

        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;
    } else {
        PRINTF("Context not valid\n");
c0d00384:	482c      	ldr	r0, [pc, #176]	; (c0d00438 <handle_finalize+0x120>)
c0d00386:	4478      	add	r0, pc
c0d00388:	f000 fab8 	bl	c0d008fc <mcu_usb_printf>
c0d0038c:	2006      	movs	r0, #6
c0d0038e:	e03b      	b.n	c0d00408 <handle_finalize+0xf0>
c0d00390:	2012      	movs	r0, #18
c0d00392:	9a02      	ldr	r2, [sp, #8]
    context->decimals_sent = WEI_TO_ETHER;
c0d00394:	7090      	strb	r0, [r2, #2]
    context->tokens_found |= TOKEN_SENT_FOUND;
c0d00396:	7810      	ldrb	r0, [r2, #0]
c0d00398:	2101      	movs	r1, #1
c0d0039a:	4301      	orrs	r1, r0
c0d0039c:	7011      	strb	r1, [r2, #0]
c0d0039e:	2700      	movs	r7, #0
c0d003a0:	60e7      	str	r7, [r4, #12]
        if (!ADDRESS_IS_NETWORK_TOKEN(context->contract_address_received)) {
c0d003a2:	462f      	mov	r7, r5
c0d003a4:	3754      	adds	r7, #84	; 0x54
c0d003a6:	491f      	ldr	r1, [pc, #124]	; (c0d00424 <handle_finalize+0x10c>)
c0d003a8:	4479      	add	r1, pc
c0d003aa:	2214      	movs	r2, #20
c0d003ac:	4638      	mov	r0, r7
c0d003ae:	f000 fd41 	bl	c0d00e34 <memcmp>
c0d003b2:	2800      	cmp	r0, #0
c0d003b4:	d01e      	beq.n	c0d003f4 <handle_finalize+0xdc>
c0d003b6:	491c      	ldr	r1, [pc, #112]	; (c0d00428 <handle_finalize+0x110>)
c0d003b8:	4479      	add	r1, pc
c0d003ba:	2214      	movs	r2, #20
c0d003bc:	4638      	mov	r0, r7
c0d003be:	f000 fd39 	bl	c0d00e34 <memcmp>
c0d003c2:	2800      	cmp	r0, #0
c0d003c4:	d016      	beq.n	c0d003f4 <handle_finalize+0xdc>
c0d003c6:	9600      	str	r6, [sp, #0]
c0d003c8:	9401      	str	r4, [sp, #4]
    PRINTF(title);
c0d003ca:	4818      	ldr	r0, [pc, #96]	; (c0d0042c <handle_finalize+0x114>)
c0d003cc:	4478      	add	r0, pc
c0d003ce:	f000 fa95 	bl	c0d008fc <mcu_usb_printf>
c0d003d2:	2454      	movs	r4, #84	; 0x54
c0d003d4:	4e16      	ldr	r6, [pc, #88]	; (c0d00430 <handle_finalize+0x118>)
c0d003d6:	447e      	add	r6, pc
        PRINTF("%02x", data[i]);
c0d003d8:	5d29      	ldrb	r1, [r5, r4]
c0d003da:	4630      	mov	r0, r6
c0d003dc:	f000 fa8e 	bl	c0d008fc <mcu_usb_printf>
    for (size_t i = 0; i < len; ++i) {
c0d003e0:	1c64      	adds	r4, r4, #1
c0d003e2:	2c68      	cmp	r4, #104	; 0x68
c0d003e4:	d1f8      	bne.n	c0d003d8 <handle_finalize+0xc0>
    PRINTF("\n");
c0d003e6:	4813      	ldr	r0, [pc, #76]	; (c0d00434 <handle_finalize+0x11c>)
c0d003e8:	4478      	add	r0, pc
c0d003ea:	f000 fa87 	bl	c0d008fc <mcu_usb_printf>
c0d003ee:	9c01      	ldr	r4, [sp, #4]
c0d003f0:	9e00      	ldr	r6, [sp, #0]
c0d003f2:	e006      	b.n	c0d00402 <handle_finalize+0xea>
c0d003f4:	2012      	movs	r0, #18
c0d003f6:	9902      	ldr	r1, [sp, #8]
    context->decimals_received = WEI_TO_ETHER;
c0d003f8:	70c8      	strb	r0, [r1, #3]
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
c0d003fa:	7808      	ldrb	r0, [r1, #0]
c0d003fc:	4330      	orrs	r0, r6
c0d003fe:	7008      	strb	r0, [r1, #0]
c0d00400:	2700      	movs	r7, #0
        msg->uiType = ETH_UI_TYPE_GENERIC;
c0d00402:	7726      	strb	r6, [r4, #28]
c0d00404:	6127      	str	r7, [r4, #16]
c0d00406:	2004      	movs	r0, #4
c0d00408:	77a0      	strb	r0, [r4, #30]
        msg->result = ETH_PLUGIN_RESULT_FALLBACK;
    }
}
c0d0040a:	b003      	add	sp, #12
c0d0040c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0040e:	46c0      	nop			; (mov r8, r8)
c0d00410:	00000de8 	.word	0x00000de8
c0d00414:	0000106d 	.word	0x0000106d
c0d00418:	00000df4 	.word	0x00000df4
c0d0041c:	00000e35 	.word	0x00000e35
c0d00420:	0000101b 	.word	0x0000101b
c0d00424:	00000d78 	.word	0x00000d78
c0d00428:	00000ffd 	.word	0x00000ffd
c0d0042c:	00000d9e 	.word	0x00000d9e
c0d00430:	00000dc5 	.word	0x00000dc5
c0d00434:	00000fab 	.word	0x00000fab
c0d00438:	00000e02 	.word	0x00000e02

c0d0043c <handle_init_contract>:
#include "cowswap_plugin.h"

// Called once to init.
void handle_init_contract(void *parameters) {
c0d0043c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0043e:	b081      	sub	sp, #4
c0d00440:	4604      	mov	r4, r0
    ethPluginInitContract_t *msg = (ethPluginInitContract_t *) parameters;
    if (msg->interfaceVersion != ETH_PLUGIN_INTERFACE_VERSION_LATEST) {
c0d00442:	7800      	ldrb	r0, [r0, #0]
c0d00444:	2806      	cmp	r0, #6
c0d00446:	d104      	bne.n	c0d00452 <handle_init_contract+0x16>
        msg->result = ETH_PLUGIN_RESULT_UNAVAILABLE;
        return;
    }
    if (msg->pluginContextLength < sizeof(cowswap_parameters_t)) {
c0d00448:	6920      	ldr	r0, [r4, #16]
c0d0044a:	288a      	cmp	r0, #138	; 0x8a
c0d0044c:	d205      	bcs.n	c0d0045a <handle_init_contract+0x1e>
c0d0044e:	2600      	movs	r6, #0
c0d00450:	e000      	b.n	c0d00454 <handle_init_contract+0x18>
c0d00452:	2601      	movs	r6, #1
c0d00454:	7066      	strb	r6, [r4, #1]
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
}
c0d00456:	b001      	add	sp, #4
c0d00458:	bdf0      	pop	{r4, r5, r6, r7, pc}
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0d0045a:	68e5      	ldr	r5, [r4, #12]
c0d0045c:	218a      	movs	r1, #138	; 0x8a
    memset(context, 0, sizeof(*context));
c0d0045e:	4628      	mov	r0, r5
c0d00460:	f000 fcd2 	bl	c0d00e08 <__aeabi_memclr>
c0d00464:	2084      	movs	r0, #132	; 0x84
c0d00466:	2701      	movs	r7, #1
    context->valid = 1;
c0d00468:	542f      	strb	r7, [r5, r0]
c0d0046a:	481c      	ldr	r0, [pc, #112]	; (c0d004dc <handle_init_contract+0xa0>)
c0d0046c:	4478      	add	r0, pc
c0d0046e:	6806      	ldr	r6, [r0, #0]
c0d00470:	3582      	adds	r5, #130	; 0x82
c0d00472:	9500      	str	r5, [sp, #0]
c0d00474:	2100      	movs	r1, #0
c0d00476:	4638      	mov	r0, r7
c0d00478:	460d      	mov	r5, r1
    for (i = 0; i < NUM_COWSWAP_SELECTORS; i++) {
c0d0047a:	07c0      	lsls	r0, r0, #31
c0d0047c:	d01e      	beq.n	c0d004bc <handle_init_contract+0x80>
        if (memcmp((uint8_t *) PIC(COWSWAP_SELECTORS[i]), msg->selector, SELECTOR_SIZE) == 0) {
c0d0047e:	4630      	mov	r0, r6
c0d00480:	f000 fbe4 	bl	c0d00c4c <pic>
c0d00484:	7801      	ldrb	r1, [r0, #0]
c0d00486:	7842      	ldrb	r2, [r0, #1]
c0d00488:	0212      	lsls	r2, r2, #8
c0d0048a:	1851      	adds	r1, r2, r1
c0d0048c:	7882      	ldrb	r2, [r0, #2]
c0d0048e:	78c0      	ldrb	r0, [r0, #3]
c0d00490:	0200      	lsls	r0, r0, #8
c0d00492:	1880      	adds	r0, r0, r2
c0d00494:	0400      	lsls	r0, r0, #16
c0d00496:	1841      	adds	r1, r0, r1
c0d00498:	6960      	ldr	r0, [r4, #20]
c0d0049a:	7802      	ldrb	r2, [r0, #0]
c0d0049c:	7843      	ldrb	r3, [r0, #1]
c0d0049e:	021b      	lsls	r3, r3, #8
c0d004a0:	189a      	adds	r2, r3, r2
c0d004a2:	7883      	ldrb	r3, [r0, #2]
c0d004a4:	78c0      	ldrb	r0, [r0, #3]
c0d004a6:	0200      	lsls	r0, r0, #8
c0d004a8:	18c0      	adds	r0, r0, r3
c0d004aa:	0400      	lsls	r0, r0, #16
c0d004ac:	1882      	adds	r2, r0, r2
c0d004ae:	2000      	movs	r0, #0
c0d004b0:	4291      	cmp	r1, r2
c0d004b2:	4639      	mov	r1, r7
c0d004b4:	d1e0      	bne.n	c0d00478 <handle_init_contract+0x3c>
c0d004b6:	2000      	movs	r0, #0
            context->selectorIndex = i;
c0d004b8:	9900      	ldr	r1, [sp, #0]
c0d004ba:	7148      	strb	r0, [r1, #5]
c0d004bc:	2600      	movs	r6, #0
    if (i == NUM_COWSWAP_SELECTORS) {
c0d004be:	07e8      	lsls	r0, r5, #31
c0d004c0:	d1c8      	bne.n	c0d00454 <handle_init_contract+0x18>
c0d004c2:	9900      	ldr	r1, [sp, #0]
    switch (context->selectorIndex) {
c0d004c4:	7948      	ldrb	r0, [r1, #5]
c0d004c6:	2800      	cmp	r0, #0
c0d004c8:	d004      	beq.n	c0d004d4 <handle_init_contract+0x98>
            PRINTF("Missing selectorIndex\n");
c0d004ca:	4805      	ldr	r0, [pc, #20]	; (c0d004e0 <handle_init_contract+0xa4>)
c0d004cc:	4478      	add	r0, pc
c0d004ce:	f000 fa15 	bl	c0d008fc <mcu_usb_printf>
c0d004d2:	e7bf      	b.n	c0d00454 <handle_init_contract+0x18>
c0d004d4:	2002      	movs	r0, #2
            context->next_param = NONE;
c0d004d6:	7008      	strb	r0, [r1, #0]
c0d004d8:	2604      	movs	r6, #4
c0d004da:	e7bb      	b.n	c0d00454 <handle_init_contract+0x18>
c0d004dc:	00000cb0 	.word	0x00000cb0
c0d004e0:	00000cd4 	.word	0x00000cd4

c0d004e4 <handle_provide_parameter>:
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
c0d004e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004e6:	b083      	sub	sp, #12
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0d004e8:	6887      	ldr	r7, [r0, #8]
c0d004ea:	9002      	str	r0, [sp, #8]
    printf_hex_array("Plugin provide parameter: ", PARAMETER_LENGTH, msg->parameter);
c0d004ec:	68c5      	ldr	r5, [r0, #12]
    PRINTF(title);
c0d004ee:	4823      	ldr	r0, [pc, #140]	; (c0d0057c <handle_provide_parameter+0x98>)
c0d004f0:	4478      	add	r0, pc
c0d004f2:	f000 fa03 	bl	c0d008fc <mcu_usb_printf>
c0d004f6:	9701      	str	r7, [sp, #4]
c0d004f8:	377e      	adds	r7, #126	; 0x7e
c0d004fa:	2400      	movs	r4, #0
c0d004fc:	4e20      	ldr	r6, [pc, #128]	; (c0d00580 <handle_provide_parameter+0x9c>)
c0d004fe:	447e      	add	r6, pc
        PRINTF("%02x", data[i]);
c0d00500:	5d29      	ldrb	r1, [r5, r4]
c0d00502:	4630      	mov	r0, r6
c0d00504:	f000 f9fa 	bl	c0d008fc <mcu_usb_printf>
    for (size_t i = 0; i < len; ++i) {
c0d00508:	1c64      	adds	r4, r4, #1
c0d0050a:	2c20      	cmp	r4, #32
c0d0050c:	d1f8      	bne.n	c0d00500 <handle_provide_parameter+0x1c>
    PRINTF("\n");
c0d0050e:	481d      	ldr	r0, [pc, #116]	; (c0d00584 <handle_provide_parameter+0xa0>)
c0d00510:	4478      	add	r0, pc
c0d00512:	f000 f9f3 	bl	c0d008fc <mcu_usb_printf>
c0d00516:	2004      	movs	r0, #4
c0d00518:	9c02      	ldr	r4, [sp, #8]

    msg->result = ETH_PLUGIN_RESULT_OK;
c0d0051a:	7520      	strb	r0, [r4, #20]

// If not used remove from here
    if (context->skip) {
c0d0051c:	7af8      	ldrb	r0, [r7, #11]
c0d0051e:	2800      	cmp	r0, #0
c0d00520:	d002      	beq.n	c0d00528 <handle_provide_parameter+0x44>
        // Skip this step, and don't forget to decrease skipping counter.
        context->skip--;
c0d00522:	1e40      	subs	r0, r0, #1
c0d00524:	72f8      	strb	r0, [r7, #11]
c0d00526:	e027      	b.n	c0d00578 <handle_provide_parameter+0x94>
    } else {
        if ((context->offset) && msg->parameterOffset != context->checkpoint + context->offset) {
c0d00528:	8839      	ldrh	r1, [r7, #0]
c0d0052a:	2900      	cmp	r1, #0
c0d0052c:	d004      	beq.n	c0d00538 <handle_provide_parameter+0x54>
c0d0052e:	887a      	ldrh	r2, [r7, #2]
c0d00530:	1850      	adds	r0, r2, r1
c0d00532:	6923      	ldr	r3, [r4, #16]
c0d00534:	4283      	cmp	r3, r0
c0d00536:	d109      	bne.n	c0d0054c <handle_provide_parameter+0x68>
c0d00538:	2600      	movs	r6, #0
                   context->offset,
                   context->checkpoint,
                   msg->parameterOffset);
            return;
        }
        context->offset = 0;
c0d0053a:	803e      	strh	r6, [r7, #0]
// To here
        switch (context->selectorIndex) {
c0d0053c:	7a79      	ldrb	r1, [r7, #9]
c0d0053e:	2900      	cmp	r1, #0
c0d00540:	d009      	beq.n	c0d00556 <handle_provide_parameter+0x72>
            case DEPOSIT:
                handle_deposit(msg, context);
                break;
            default:
                PRINTF("Selector Index %d not supported\n", context->selectorIndex);
c0d00542:	4813      	ldr	r0, [pc, #76]	; (c0d00590 <handle_provide_parameter+0xac>)
c0d00544:	4478      	add	r0, pc
c0d00546:	f000 f9d9 	bl	c0d008fc <mcu_usb_printf>
c0d0054a:	e014      	b.n	c0d00576 <handle_provide_parameter+0x92>
            PRINTF("offset: %d, checkpoint: %d, parameterOffset: %d\n",
c0d0054c:	480e      	ldr	r0, [pc, #56]	; (c0d00588 <handle_provide_parameter+0xa4>)
c0d0054e:	4478      	add	r0, pc
c0d00550:	f000 f9d4 	bl	c0d008fc <mcu_usb_printf>
c0d00554:	e010      	b.n	c0d00578 <handle_provide_parameter+0x94>
    switch (context->next_param) {
c0d00556:	7938      	ldrb	r0, [r7, #4]
c0d00558:	2802      	cmp	r0, #2
c0d0055a:	d108      	bne.n	c0d0056e <handle_provide_parameter+0x8a>
    memcpy(context->amount_sent, msg->pluginSharedRO->txContent->value.value , msg->pluginSharedRO->txContent->value.length);
c0d0055c:	6860      	ldr	r0, [r4, #4]
c0d0055e:	6801      	ldr	r1, [r0, #0]
c0d00560:	2062      	movs	r0, #98	; 0x62
c0d00562:	5c0a      	ldrb	r2, [r1, r0]
c0d00564:	3142      	adds	r1, #66	; 0x42
c0d00566:	9801      	ldr	r0, [sp, #4]
c0d00568:	f000 fc54 	bl	c0d00e14 <__aeabi_memcpy>
c0d0056c:	e004      	b.n	c0d00578 <handle_provide_parameter+0x94>
            PRINTF("Param not supported\n");
c0d0056e:	4807      	ldr	r0, [pc, #28]	; (c0d0058c <handle_provide_parameter+0xa8>)
c0d00570:	4478      	add	r0, pc
c0d00572:	f000 f9c3 	bl	c0d008fc <mcu_usb_printf>
c0d00576:	7526      	strb	r6, [r4, #20]
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
        }
    }
c0d00578:	b003      	add	sp, #12
c0d0057a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0057c:	00000cc7 	.word	0x00000cc7
c0d00580:	00000c9d 	.word	0x00000c9d
c0d00584:	00000e83 	.word	0x00000e83
c0d00588:	00000c84 	.word	0x00000c84
c0d0058c:	00000cb4 	.word	0x00000cb4
c0d00590:	00000cbf 	.word	0x00000cbf

c0d00594 <handle_provide_token>:
static void received_network_token(cowswap_parameters_t *context) {
    context->decimals_received = WEI_TO_ETHER;
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
}

void handle_provide_token(void *parameters) {
c0d00594:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00596:	b081      	sub	sp, #4
c0d00598:	4604      	mov	r4, r0
    ethPluginProvideInfo_t *msg = (ethPluginProvideInfo_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0d0059a:	6885      	ldr	r5, [r0, #8]
    PRINTF("Plugin provide tokens : 0x%p, 0x%p\n", msg->item1, msg->item2);
c0d0059c:	68c1      	ldr	r1, [r0, #12]
c0d0059e:	6902      	ldr	r2, [r0, #16]
c0d005a0:	4835      	ldr	r0, [pc, #212]	; (c0d00678 <handle_provide_token+0xe4>)
c0d005a2:	4478      	add	r0, pc
c0d005a4:	f000 f9aa 	bl	c0d008fc <mcu_usb_printf>

    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
c0d005a8:	462e      	mov	r6, r5
c0d005aa:	3640      	adds	r6, #64	; 0x40
c0d005ac:	4933      	ldr	r1, [pc, #204]	; (c0d0067c <handle_provide_token+0xe8>)
c0d005ae:	4479      	add	r1, pc
c0d005b0:	2214      	movs	r2, #20
c0d005b2:	4630      	mov	r0, r6
c0d005b4:	f000 fc3e 	bl	c0d00e34 <memcmp>
c0d005b8:	462f      	mov	r7, r5
c0d005ba:	3783      	adds	r7, #131	; 0x83
c0d005bc:	2800      	cmp	r0, #0
c0d005be:	d013      	beq.n	c0d005e8 <handle_provide_token+0x54>
c0d005c0:	492f      	ldr	r1, [pc, #188]	; (c0d00680 <handle_provide_token+0xec>)
c0d005c2:	4479      	add	r1, pc
c0d005c4:	2214      	movs	r2, #20
c0d005c6:	4630      	mov	r0, r6
c0d005c8:	f000 fc34 	bl	c0d00e34 <memcmp>
c0d005cc:	2800      	cmp	r0, #0
c0d005ce:	d00b      	beq.n	c0d005e8 <handle_provide_token+0x54>
        sent_network_token(context);
    } else if (msg->item1 != NULL) {
c0d005d0:	68e1      	ldr	r1, [r4, #12]
c0d005d2:	2900      	cmp	r1, #0
c0d005d4:	d036      	beq.n	c0d00644 <handle_provide_token+0xb0>
        context->decimals_sent = msg->item1->token.decimals;
c0d005d6:	7fc8      	ldrb	r0, [r1, #31]
c0d005d8:	70b8      	strb	r0, [r7, #2]
        strlcpy(context->ticker_sent,
c0d005da:	4628      	mov	r0, r5
c0d005dc:	3068      	adds	r0, #104	; 0x68
        context->decimals_sent = msg->item1->token.decimals;
c0d005de:	3114      	adds	r1, #20
c0d005e0:	220b      	movs	r2, #11
        strlcpy(context->ticker_sent,
c0d005e2:	f000 fd61 	bl	c0d010a8 <strlcpy>
c0d005e6:	e001      	b.n	c0d005ec <handle_provide_token+0x58>
c0d005e8:	2012      	movs	r0, #18
    context->decimals_sent = WEI_TO_ETHER;
c0d005ea:	70b8      	strb	r0, [r7, #2]
c0d005ec:	7838      	ldrb	r0, [r7, #0]
c0d005ee:	2101      	movs	r1, #1
c0d005f0:	4301      	orrs	r1, r0
c0d005f2:	7039      	strb	r1, [r7, #0]
        strlcpy(context->ticker_sent, DEFAULT_TICKER, sizeof(context->ticker_sent));
        // // We will need an additional screen to display a warning message.
        msg->additionalScreens++;
    }

    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_received)) {
c0d005f4:	462e      	mov	r6, r5
c0d005f6:	3654      	adds	r6, #84	; 0x54
c0d005f8:	4923      	ldr	r1, [pc, #140]	; (c0d00688 <handle_provide_token+0xf4>)
c0d005fa:	4479      	add	r1, pc
c0d005fc:	2214      	movs	r2, #20
c0d005fe:	4630      	mov	r0, r6
c0d00600:	f000 fc18 	bl	c0d00e34 <memcmp>
c0d00604:	2800      	cmp	r0, #0
c0d00606:	d013      	beq.n	c0d00630 <handle_provide_token+0x9c>
c0d00608:	4920      	ldr	r1, [pc, #128]	; (c0d0068c <handle_provide_token+0xf8>)
c0d0060a:	4479      	add	r1, pc
c0d0060c:	2214      	movs	r2, #20
c0d0060e:	4630      	mov	r0, r6
c0d00610:	f000 fc10 	bl	c0d00e34 <memcmp>
c0d00614:	2800      	cmp	r0, #0
c0d00616:	d00b      	beq.n	c0d00630 <handle_provide_token+0x9c>
        received_network_token(context);
    } else if (msg->item2 != NULL) {
c0d00618:	6921      	ldr	r1, [r4, #16]
c0d0061a:	2900      	cmp	r1, #0
c0d0061c:	d01f      	beq.n	c0d0065e <handle_provide_token+0xca>
        context->decimals_received = msg->item2->token.decimals;
c0d0061e:	7fc8      	ldrb	r0, [r1, #31]
c0d00620:	70f8      	strb	r0, [r7, #3]
        strlcpy(context->ticker_received,
c0d00622:	3573      	adds	r5, #115	; 0x73
        context->decimals_received = msg->item2->token.decimals;
c0d00624:	3114      	adds	r1, #20
c0d00626:	220b      	movs	r2, #11
        strlcpy(context->ticker_received,
c0d00628:	4628      	mov	r0, r5
c0d0062a:	f000 fd3d 	bl	c0d010a8 <strlcpy>
c0d0062e:	e001      	b.n	c0d00634 <handle_provide_token+0xa0>
c0d00630:	2012      	movs	r0, #18
    context->decimals_received = WEI_TO_ETHER;
c0d00632:	70f8      	strb	r0, [r7, #3]
c0d00634:	7838      	ldrb	r0, [r7, #0]
c0d00636:	2102      	movs	r1, #2
c0d00638:	4301      	orrs	r1, r0
c0d0063a:	7039      	strb	r1, [r7, #0]
c0d0063c:	2004      	movs	r0, #4
        strlcpy(context->ticker_received, DEFAULT_TICKER, sizeof(context->ticker_sent));
        // // We will need an additional screen to display a warning message.
        msg->additionalScreens++;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
c0d0063e:	7560      	strb	r0, [r4, #21]
c0d00640:	b001      	add	sp, #4
c0d00642:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00644:	2012      	movs	r0, #18
        context->decimals_sent = DEFAULT_DECIMAL;
c0d00646:	70b8      	strb	r0, [r7, #2]
        strlcpy(context->ticker_sent, DEFAULT_TICKER, sizeof(context->ticker_sent));
c0d00648:	4628      	mov	r0, r5
c0d0064a:	3068      	adds	r0, #104	; 0x68
c0d0064c:	490d      	ldr	r1, [pc, #52]	; (c0d00684 <handle_provide_token+0xf0>)
c0d0064e:	4479      	add	r1, pc
c0d00650:	220b      	movs	r2, #11
c0d00652:	f000 fd29 	bl	c0d010a8 <strlcpy>
        msg->additionalScreens++;
c0d00656:	7d20      	ldrb	r0, [r4, #20]
c0d00658:	1c40      	adds	r0, r0, #1
c0d0065a:	7520      	strb	r0, [r4, #20]
c0d0065c:	e7ca      	b.n	c0d005f4 <handle_provide_token+0x60>
c0d0065e:	2012      	movs	r0, #18
        context->decimals_received = DEFAULT_DECIMAL;
c0d00660:	70f8      	strb	r0, [r7, #3]
        strlcpy(context->ticker_received, DEFAULT_TICKER, sizeof(context->ticker_sent));
c0d00662:	3573      	adds	r5, #115	; 0x73
c0d00664:	490a      	ldr	r1, [pc, #40]	; (c0d00690 <handle_provide_token+0xfc>)
c0d00666:	4479      	add	r1, pc
c0d00668:	220b      	movs	r2, #11
c0d0066a:	4628      	mov	r0, r5
c0d0066c:	f000 fd1c 	bl	c0d010a8 <strlcpy>
        msg->additionalScreens++;
c0d00670:	7d20      	ldrb	r0, [r4, #20]
c0d00672:	1c40      	adds	r0, r0, #1
c0d00674:	7520      	strb	r0, [r4, #20]
c0d00676:	e7e1      	b.n	c0d0063c <handle_provide_token+0xa8>
c0d00678:	00000c97 	.word	0x00000c97
c0d0067c:	00000b72 	.word	0x00000b72
c0d00680:	00000df3 	.word	0x00000df3
c0d00684:	00000d46 	.word	0x00000d46
c0d00688:	00000b26 	.word	0x00000b26
c0d0068c:	00000dab 	.word	0x00000dab
c0d00690:	00000d2e 	.word	0x00000d2e

c0d00694 <handle_query_contract_id>:
#include "cowswap_plugin.h"

void handle_query_contract_id(void *parameters) {
c0d00694:	b5b0      	push	{r4, r5, r7, lr}
c0d00696:	4604      	mov	r4, r0
    ethQueryContractID_t *msg = (ethQueryContractID_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0d00698:	6885      	ldr	r5, [r0, #8]

    strlcpy(msg->name, PLUGIN_NAME, msg->nameLength);
c0d0069a:	68c0      	ldr	r0, [r0, #12]
c0d0069c:	6922      	ldr	r2, [r4, #16]
c0d0069e:	490b      	ldr	r1, [pc, #44]	; (c0d006cc <handle_query_contract_id+0x38>)
c0d006a0:	4479      	add	r1, pc
c0d006a2:	f000 fd01 	bl	c0d010a8 <strlcpy>
c0d006a6:	2087      	movs	r0, #135	; 0x87

    switch (context->selectorIndex) {
c0d006a8:	5c29      	ldrb	r1, [r5, r0]
c0d006aa:	2900      	cmp	r1, #0
c0d006ac:	d005      	beq.n	c0d006ba <handle_query_contract_id+0x26>
        case DEPOSIT:
            strlcpy(msg->version, "Deposit", msg->versionLength);
            break;
        default:
            PRINTF("Selector Index :%d not supported\n", context->selectorIndex);
c0d006ae:	4809      	ldr	r0, [pc, #36]	; (c0d006d4 <handle_query_contract_id+0x40>)
c0d006b0:	4478      	add	r0, pc
c0d006b2:	f000 f923 	bl	c0d008fc <mcu_usb_printf>
c0d006b6:	2000      	movs	r0, #0
c0d006b8:	e006      	b.n	c0d006c8 <handle_query_contract_id+0x34>
            strlcpy(msg->version, "Deposit", msg->versionLength);
c0d006ba:	6960      	ldr	r0, [r4, #20]
c0d006bc:	69a2      	ldr	r2, [r4, #24]
c0d006be:	4904      	ldr	r1, [pc, #16]	; (c0d006d0 <handle_query_contract_id+0x3c>)
c0d006c0:	4479      	add	r1, pc
c0d006c2:	f000 fcf1 	bl	c0d010a8 <strlcpy>
c0d006c6:	2004      	movs	r0, #4
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
c0d006c8:	7720      	strb	r0, [r4, #28]
c0d006ca:	bdb0      	pop	{r4, r5, r7, pc}
c0d006cc:	00000bbd 	.word	0x00000bbd
c0d006d0:	00000ba6 	.word	0x00000ba6
c0d006d4:	00000bbe 	.word	0x00000bbe

c0d006d8 <handle_query_contract_ui>:
            return ERROR;
    }
    return ERROR;
}

void handle_query_contract_ui(void *parameters) {
c0d006d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006da:	b083      	sub	sp, #12
c0d006dc:	4605      	mov	r5, r0
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0d006de:	69c4      	ldr	r4, [r0, #28]
    memset(msg->title, 0, msg->titleLength);
c0d006e0:	6a40      	ldr	r0, [r0, #36]	; 0x24
c0d006e2:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d006e4:	f000 fb90 	bl	c0d00e08 <__aeabi_memclr>
    memset(msg->msg, 0, msg->msgLength);
c0d006e8:	6ae8      	ldr	r0, [r5, #44]	; 0x2c
c0d006ea:	6b29      	ldr	r1, [r5, #48]	; 0x30
c0d006ec:	f000 fb8c 	bl	c0d00e08 <__aeabi_memclr>
c0d006f0:	462e      	mov	r6, r5
c0d006f2:	3620      	adds	r6, #32
c0d006f4:	2004      	movs	r0, #4
    msg->result = ETH_PLUGIN_RESULT_OK;
c0d006f6:	7530      	strb	r0, [r6, #20]
c0d006f8:	2020      	movs	r0, #32
    uint8_t index = msg->screenIndex;
c0d006fa:	5c28      	ldrb	r0, [r5, r0]

    screens_t screen = get_screen(msg, context);
    switch (screen) {
c0d006fc:	2800      	cmp	r0, #0
c0d006fe:	d003      	beq.n	c0d00708 <handle_query_contract_ui+0x30>
            break;
        case WARN_SCREEN:
            set_warning_ui(msg, context);
            break;
        default:
            PRINTF("Received an invalid screenIndex %d\n", screen);
c0d00700:	4830      	ldr	r0, [pc, #192]	; (c0d007c4 <handle_query_contract_ui+0xec>)
c0d00702:	4478      	add	r0, pc
c0d00704:	2103      	movs	r1, #3
c0d00706:	e006      	b.n	c0d00716 <handle_query_contract_ui+0x3e>
c0d00708:	4627      	mov	r7, r4
c0d0070a:	3785      	adds	r7, #133	; 0x85
    switch (context->selectorIndex) {
c0d0070c:	78b9      	ldrb	r1, [r7, #2]
c0d0070e:	2900      	cmp	r1, #0
c0d00710:	d007      	beq.n	c0d00722 <handle_query_contract_ui+0x4a>
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
c0d00712:	482d      	ldr	r0, [pc, #180]	; (c0d007c8 <handle_query_contract_ui+0xf0>)
c0d00714:	4478      	add	r0, pc
c0d00716:	f000 f8f1 	bl	c0d008fc <mcu_usb_printf>
c0d0071a:	2000      	movs	r0, #0
c0d0071c:	7530      	strb	r0, [r6, #20]
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }
}
c0d0071e:	b003      	add	sp, #12
c0d00720:	bdf0      	pop	{r4, r5, r6, r7, pc}
        PRINTF("AMOUNT SENT1: %s\n", msg->msg);
c0d00722:	6ae9      	ldr	r1, [r5, #44]	; 0x2c
c0d00724:	4822      	ldr	r0, [pc, #136]	; (c0d007b0 <handle_query_contract_ui+0xd8>)
c0d00726:	4478      	add	r0, pc
c0d00728:	f000 f8e8 	bl	c0d008fc <mcu_usb_printf>
            strlcpy(msg->title, "Send", msg->titleLength);
c0d0072c:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0072e:	6aaa      	ldr	r2, [r5, #40]	; 0x28
c0d00730:	4920      	ldr	r1, [pc, #128]	; (c0d007b4 <handle_query_contract_ui+0xdc>)
c0d00732:	4479      	add	r1, pc
c0d00734:	f000 fcb8 	bl	c0d010a8 <strlcpy>
    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
c0d00738:	4626      	mov	r6, r4
c0d0073a:	3640      	adds	r6, #64	; 0x40
c0d0073c:	491e      	ldr	r1, [pc, #120]	; (c0d007b8 <handle_query_contract_ui+0xe0>)
c0d0073e:	4479      	add	r1, pc
c0d00740:	2214      	movs	r2, #20
c0d00742:	4630      	mov	r0, r6
c0d00744:	f000 fb76 	bl	c0d00e34 <memcmp>
c0d00748:	2800      	cmp	r0, #0
c0d0074a:	d007      	beq.n	c0d0075c <handle_query_contract_ui+0x84>
c0d0074c:	491b      	ldr	r1, [pc, #108]	; (c0d007bc <handle_query_contract_ui+0xe4>)
c0d0074e:	4479      	add	r1, pc
c0d00750:	2214      	movs	r2, #20
c0d00752:	4630      	mov	r0, r6
c0d00754:	f000 fb6e 	bl	c0d00e34 <memcmp>
c0d00758:	2800      	cmp	r0, #0
c0d0075a:	d106      	bne.n	c0d0076a <handle_query_contract_ui+0x92>
        strlcpy(context->ticker_sent, msg->network_ticker, sizeof(context->ticker_sent));
c0d0075c:	4620      	mov	r0, r4
c0d0075e:	3068      	adds	r0, #104	; 0x68
c0d00760:	4629      	mov	r1, r5
c0d00762:	3110      	adds	r1, #16
c0d00764:	220b      	movs	r2, #11
c0d00766:	f000 fc9f 	bl	c0d010a8 <strlcpy>
    switch(context->selectorIndex) {
c0d0076a:	78b8      	ldrb	r0, [r7, #2]
c0d0076c:	2800      	cmp	r0, #0
c0d0076e:	d00b      	beq.n	c0d00788 <handle_query_contract_ui+0xb0>
                   context->decimals_sent,
c0d00770:	783a      	ldrb	r2, [r7, #0]
                   msg->msg,
c0d00772:	6ae8      	ldr	r0, [r5, #44]	; 0x2c
                   msg->msgLength);
c0d00774:	6b29      	ldr	r1, [r5, #48]	; 0x30
            amountToString(context->amount_sent,
c0d00776:	9000      	str	r0, [sp, #0]
c0d00778:	9101      	str	r1, [sp, #4]
                   context->ticker_sent,
c0d0077a:	4623      	mov	r3, r4
c0d0077c:	3368      	adds	r3, #104	; 0x68
c0d0077e:	2120      	movs	r1, #32
            amountToString(context->amount_sent,
c0d00780:	4620      	mov	r0, r4
c0d00782:	f7ff fd83 	bl	c0d0028c <amountToString>
c0d00786:	e7ca      	b.n	c0d0071e <handle_query_contract_ui+0x46>
            amountToString(msg->pluginSharedRO->txContent->value.value,
c0d00788:	6868      	ldr	r0, [r5, #4]
c0d0078a:	6800      	ldr	r0, [r0, #0]
c0d0078c:	2162      	movs	r1, #98	; 0x62
                    msg->pluginSharedRO->txContent->value.length,
c0d0078e:	5c41      	ldrb	r1, [r0, r1]
                    msg->msg,
c0d00790:	6aea      	ldr	r2, [r5, #44]	; 0x2c
                    msg->msgLength);
c0d00792:	6b2b      	ldr	r3, [r5, #48]	; 0x30
            amountToString(msg->pluginSharedRO->txContent->value.value,
c0d00794:	9200      	str	r2, [sp, #0]
c0d00796:	9301      	str	r3, [sp, #4]
                    context->ticker_sent,
c0d00798:	3468      	adds	r4, #104	; 0x68
            amountToString(msg->pluginSharedRO->txContent->value.value,
c0d0079a:	3042      	adds	r0, #66	; 0x42
c0d0079c:	2212      	movs	r2, #18
c0d0079e:	4623      	mov	r3, r4
c0d007a0:	f7ff fd74 	bl	c0d0028c <amountToString>
    PRINTF("AMOUNT SENT: %s\n", msg->msg);
c0d007a4:	6ae9      	ldr	r1, [r5, #44]	; 0x2c
c0d007a6:	4806      	ldr	r0, [pc, #24]	; (c0d007c0 <handle_query_contract_ui+0xe8>)
c0d007a8:	4478      	add	r0, pc
c0d007aa:	f000 f8a7 	bl	c0d008fc <mcu_usb_printf>
c0d007ae:	e7b6      	b.n	c0d0071e <handle_query_contract_ui+0x46>
c0d007b0:	00000b8e 	.word	0x00000b8e
c0d007b4:	00000b94 	.word	0x00000b94
c0d007b8:	000009e2 	.word	0x000009e2
c0d007bc:	00000c67 	.word	0x00000c67
c0d007c0:	00000b41 	.word	0x00000b41
c0d007c4:	00000b8e 	.word	0x00000b8e
c0d007c8:	00000bb7 	.word	0x00000bb7

c0d007cc <dispatch_plugin_calls>:
void dispatch_plugin_calls(int message, void *parameters) {
c0d007cc:	b5b0      	push	{r4, r5, r7, lr}
c0d007ce:	460c      	mov	r4, r1
c0d007d0:	4605      	mov	r5, r0
    PRINTF("Handling message %d\n", message);
c0d007d2:	482e      	ldr	r0, [pc, #184]	; (c0d0088c <dispatch_plugin_calls+0xc0>)
c0d007d4:	4478      	add	r0, pc
c0d007d6:	4629      	mov	r1, r5
c0d007d8:	f000 f890 	bl	c0d008fc <mcu_usb_printf>
c0d007dc:	21ff      	movs	r1, #255	; 0xff
c0d007de:	4608      	mov	r0, r1
c0d007e0:	3004      	adds	r0, #4
    switch (message) {
c0d007e2:	4285      	cmp	r5, r0
c0d007e4:	dc11      	bgt.n	c0d0080a <dispatch_plugin_calls+0x3e>
c0d007e6:	3102      	adds	r1, #2
c0d007e8:	428d      	cmp	r5, r1
c0d007ea:	d024      	beq.n	c0d00836 <dispatch_plugin_calls+0x6a>
c0d007ec:	2281      	movs	r2, #129	; 0x81
c0d007ee:	0052      	lsls	r2, r2, #1
c0d007f0:	4295      	cmp	r5, r2
c0d007f2:	d028      	beq.n	c0d00846 <dispatch_plugin_calls+0x7a>
c0d007f4:	4285      	cmp	r5, r0
c0d007f6:	d143      	bne.n	c0d00880 <dispatch_plugin_calls+0xb4>
            PRINTF("SLI3 %d\n", message);
c0d007f8:	1c89      	adds	r1, r1, #2
c0d007fa:	4825      	ldr	r0, [pc, #148]	; (c0d00890 <dispatch_plugin_calls+0xc4>)
c0d007fc:	4478      	add	r0, pc
c0d007fe:	f000 f87d 	bl	c0d008fc <mcu_usb_printf>
            handle_finalize(parameters);
c0d00802:	4620      	mov	r0, r4
c0d00804:	f7ff fd88 	bl	c0d00318 <handle_finalize>
}
c0d00808:	bdb0      	pop	{r4, r5, r7, pc}
c0d0080a:	2041      	movs	r0, #65	; 0x41
c0d0080c:	0080      	lsls	r0, r0, #2
    switch (message) {
c0d0080e:	4285      	cmp	r5, r0
c0d00810:	d022      	beq.n	c0d00858 <dispatch_plugin_calls+0x8c>
c0d00812:	4608      	mov	r0, r1
c0d00814:	3006      	adds	r0, #6
c0d00816:	4285      	cmp	r5, r0
c0d00818:	d028      	beq.n	c0d0086c <dispatch_plugin_calls+0xa0>
c0d0081a:	2083      	movs	r0, #131	; 0x83
c0d0081c:	0040      	lsls	r0, r0, #1
c0d0081e:	4285      	cmp	r5, r0
c0d00820:	d12e      	bne.n	c0d00880 <dispatch_plugin_calls+0xb4>
c0d00822:	3102      	adds	r1, #2
            PRINTF("SLI6 %d\n", message);
c0d00824:	1d49      	adds	r1, r1, #5
c0d00826:	481b      	ldr	r0, [pc, #108]	; (c0d00894 <dispatch_plugin_calls+0xc8>)
c0d00828:	4478      	add	r0, pc
c0d0082a:	f000 f867 	bl	c0d008fc <mcu_usb_printf>
            handle_query_contract_ui(parameters);
c0d0082e:	4620      	mov	r0, r4
c0d00830:	f7ff ff52 	bl	c0d006d8 <handle_query_contract_ui>
}
c0d00834:	bdb0      	pop	{r4, r5, r7, pc}
            PRINTF("SLI1 %d\n", message);
c0d00836:	4818      	ldr	r0, [pc, #96]	; (c0d00898 <dispatch_plugin_calls+0xcc>)
c0d00838:	4478      	add	r0, pc
c0d0083a:	f000 f85f 	bl	c0d008fc <mcu_usb_printf>
            handle_init_contract(parameters);
c0d0083e:	4620      	mov	r0, r4
c0d00840:	f7ff fdfc 	bl	c0d0043c <handle_init_contract>
}
c0d00844:	bdb0      	pop	{r4, r5, r7, pc}
            PRINTF("SLI2 %d\n", message);
c0d00846:	1c49      	adds	r1, r1, #1
c0d00848:	4814      	ldr	r0, [pc, #80]	; (c0d0089c <dispatch_plugin_calls+0xd0>)
c0d0084a:	4478      	add	r0, pc
c0d0084c:	f000 f856 	bl	c0d008fc <mcu_usb_printf>
            handle_provide_parameter(parameters);
c0d00850:	4620      	mov	r0, r4
c0d00852:	f7ff fe47 	bl	c0d004e4 <handle_provide_parameter>
}
c0d00856:	bdb0      	pop	{r4, r5, r7, pc}
c0d00858:	3102      	adds	r1, #2
            PRINTF("SLI4 %d\n", message);
c0d0085a:	1cc9      	adds	r1, r1, #3
c0d0085c:	4810      	ldr	r0, [pc, #64]	; (c0d008a0 <dispatch_plugin_calls+0xd4>)
c0d0085e:	4478      	add	r0, pc
c0d00860:	f000 f84c 	bl	c0d008fc <mcu_usb_printf>
            handle_provide_token(parameters);
c0d00864:	4620      	mov	r0, r4
c0d00866:	f7ff fe95 	bl	c0d00594 <handle_provide_token>
}
c0d0086a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0086c:	3102      	adds	r1, #2
            PRINTF("SLI5 %d\n", message);
c0d0086e:	1d09      	adds	r1, r1, #4
c0d00870:	480c      	ldr	r0, [pc, #48]	; (c0d008a4 <dispatch_plugin_calls+0xd8>)
c0d00872:	4478      	add	r0, pc
c0d00874:	f000 f842 	bl	c0d008fc <mcu_usb_printf>
            handle_query_contract_id(parameters);
c0d00878:	4620      	mov	r0, r4
c0d0087a:	f7ff ff0b 	bl	c0d00694 <handle_query_contract_id>
}
c0d0087e:	bdb0      	pop	{r4, r5, r7, pc}
            PRINTF("Unhandled message %d\n", message);
c0d00880:	4809      	ldr	r0, [pc, #36]	; (c0d008a8 <dispatch_plugin_calls+0xdc>)
c0d00882:	4478      	add	r0, pc
c0d00884:	4629      	mov	r1, r5
c0d00886:	f000 f839 	bl	c0d008fc <mcu_usb_printf>
}
c0d0088a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0088c:	00000b26 	.word	0x00000b26
c0d00890:	00000b25 	.word	0x00000b25
c0d00894:	00000b14 	.word	0x00000b14
c0d00898:	00000ad7 	.word	0x00000ad7
c0d0089c:	00000ace 	.word	0x00000ace
c0d008a0:	00000acc 	.word	0x00000acc
c0d008a4:	00000ac1 	.word	0x00000ac1
c0d008a8:	00000ac3 	.word	0x00000ac3

c0d008ac <os_boot>:

// apdu buffer must hold a complete apdu to avoid troubles
unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];

#ifndef BOLOS_OS_UPGRADER_APP
void os_boot(void) {
c0d008ac:	b580      	push	{r7, lr}
c0d008ae:	2000      	movs	r0, #0
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0d008b0:	f000 fa30 	bl	c0d00d14 <try_context_set>
#endif // HAVE_BOLOS
}
c0d008b4:	bd80      	pop	{r7, pc}
	...

c0d008b8 <os_longjmp>:
  }
  return xoracc;
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d008b8:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
c0d008ba:	4672      	mov	r2, lr
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
c0d008bc:	4804      	ldr	r0, [pc, #16]	; (c0d008d0 <os_longjmp+0x18>)
c0d008be:	4478      	add	r0, pc
c0d008c0:	4621      	mov	r1, r4
c0d008c2:	f000 f81b 	bl	c0d008fc <mcu_usb_printf>
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0d008c6:	f000 fa19 	bl	c0d00cfc <try_context_get>
c0d008ca:	4621      	mov	r1, r4
c0d008cc:	f000 fbde 	bl	c0d0108c <longjmp>
c0d008d0:	00000abd 	.word	0x00000abd

c0d008d4 <mcu_usb_prints>:
  return ret;
}
#endif // !defined(APP_UX)

#ifdef HAVE_PRINTF
void mcu_usb_prints(const char* str, unsigned int charcount) {
c0d008d4:	b5b0      	push	{r4, r5, r7, lr}
c0d008d6:	b082      	sub	sp, #8
c0d008d8:	460c      	mov	r4, r1
c0d008da:	4605      	mov	r5, r0
c0d008dc:	a801      	add	r0, sp, #4
  unsigned char buf[4];

  buf[0] = SEPROXYHAL_TAG_PRINTF;
  buf[1] = charcount >> 8;
  buf[2] = charcount;
c0d008de:	7081      	strb	r1, [r0, #2]
c0d008e0:	215f      	movs	r1, #95	; 0x5f
  buf[0] = SEPROXYHAL_TAG_PRINTF;
c0d008e2:	7001      	strb	r1, [r0, #0]
  buf[1] = charcount >> 8;
c0d008e4:	0a21      	lsrs	r1, r4, #8
c0d008e6:	7041      	strb	r1, [r0, #1]
c0d008e8:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(buf, 3);
c0d008ea:	f000 f9fb 	bl	c0d00ce4 <io_seph_send>
  io_seproxyhal_spi_send((unsigned char*)str, charcount);
c0d008ee:	b2a1      	uxth	r1, r4
c0d008f0:	4628      	mov	r0, r5
c0d008f2:	f000 f9f7 	bl	c0d00ce4 <io_seph_send>
}
c0d008f6:	b002      	add	sp, #8
c0d008f8:	bdb0      	pop	{r4, r5, r7, pc}
	...

c0d008fc <mcu_usb_printf>:
#include "usbd_def.h"
#include "usbd_core.h"

void screen_printf(const char* format, ...) __attribute__ ((weak, alias ("mcu_usb_printf")));

void mcu_usb_printf(const char* format, ...) {
c0d008fc:	b083      	sub	sp, #12
c0d008fe:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00900:	b08e      	sub	sp, #56	; 0x38
c0d00902:	ac13      	add	r4, sp, #76	; 0x4c
c0d00904:	c40e      	stmia	r4!, {r1, r2, r3}
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(format == 0) {
c0d00906:	2800      	cmp	r0, #0
c0d00908:	d100      	bne.n	c0d0090c <mcu_usb_printf+0x10>
c0d0090a:	e181      	b.n	c0d00c10 <mcu_usb_printf+0x314>
c0d0090c:	4604      	mov	r4, r0
c0d0090e:	a813      	add	r0, sp, #76	; 0x4c
    }

    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d00910:	9008      	str	r0, [sp, #32]

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d00912:	7820      	ldrb	r0, [r4, #0]
c0d00914:	2800      	cmp	r0, #0
c0d00916:	d100      	bne.n	c0d0091a <mcu_usb_printf+0x1e>
c0d00918:	e17a      	b.n	c0d00c10 <mcu_usb_printf+0x314>
c0d0091a:	2101      	movs	r1, #1
c0d0091c:	9103      	str	r1, [sp, #12]
c0d0091e:	2500      	movs	r5, #0
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d00920:	2800      	cmp	r0, #0
c0d00922:	d005      	beq.n	c0d00930 <mcu_usb_printf+0x34>
c0d00924:	2825      	cmp	r0, #37	; 0x25
c0d00926:	d003      	beq.n	c0d00930 <mcu_usb_printf+0x34>
c0d00928:	1960      	adds	r0, r4, r5
c0d0092a:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0d0092c:	1c6d      	adds	r5, r5, #1
c0d0092e:	e7f7      	b.n	c0d00920 <mcu_usb_printf+0x24>
        }

        //
        // Write this portion of the string.
        //
        mcu_usb_prints(format, ulIdx);
c0d00930:	4620      	mov	r0, r4
c0d00932:	4629      	mov	r1, r5
c0d00934:	f7ff ffce 	bl	c0d008d4 <mcu_usb_prints>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d00938:	5d60      	ldrb	r0, [r4, r5]
c0d0093a:	2825      	cmp	r0, #37	; 0x25
c0d0093c:	d143      	bne.n	c0d009c6 <mcu_usb_printf+0xca>
            ulCount = 0;
            cFill = ' ';
            ulStrlen = 0;
            cStrlenSet = 0;
            ulCap = 0;
            ulBase = 10;
c0d0093e:	1960      	adds	r0, r4, r5
c0d00940:	1c44      	adds	r4, r0, #1
c0d00942:	2300      	movs	r3, #0
c0d00944:	2720      	movs	r7, #32
c0d00946:	461e      	mov	r6, r3
c0d00948:	4618      	mov	r0, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d0094a:	7821      	ldrb	r1, [r4, #0]
c0d0094c:	1c64      	adds	r4, r4, #1
c0d0094e:	2200      	movs	r2, #0
c0d00950:	292d      	cmp	r1, #45	; 0x2d
c0d00952:	dc0c      	bgt.n	c0d0096e <mcu_usb_printf+0x72>
c0d00954:	4610      	mov	r0, r2
c0d00956:	d0f8      	beq.n	c0d0094a <mcu_usb_printf+0x4e>
c0d00958:	2925      	cmp	r1, #37	; 0x25
c0d0095a:	d06d      	beq.n	c0d00a38 <mcu_usb_printf+0x13c>
c0d0095c:	292a      	cmp	r1, #42	; 0x2a
c0d0095e:	d000      	beq.n	c0d00962 <mcu_usb_printf+0x66>
c0d00960:	e101      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
                  goto error;
                }

                case '*':
                {
                  if (*format == 's' ) {
c0d00962:	7820      	ldrb	r0, [r4, #0]
c0d00964:	2873      	cmp	r0, #115	; 0x73
c0d00966:	d000      	beq.n	c0d0096a <mcu_usb_printf+0x6e>
c0d00968:	e0fd      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
c0d0096a:	2002      	movs	r0, #2
c0d0096c:	e026      	b.n	c0d009bc <mcu_usb_printf+0xc0>
            switch(*format++)
c0d0096e:	2947      	cmp	r1, #71	; 0x47
c0d00970:	dc2b      	bgt.n	c0d009ca <mcu_usb_printf+0xce>
c0d00972:	460a      	mov	r2, r1
c0d00974:	3a30      	subs	r2, #48	; 0x30
c0d00976:	2a0a      	cmp	r2, #10
c0d00978:	d20f      	bcs.n	c0d0099a <mcu_usb_printf+0x9e>
c0d0097a:	9705      	str	r7, [sp, #20]
c0d0097c:	2230      	movs	r2, #48	; 0x30
c0d0097e:	461f      	mov	r7, r3
                    if((format[-1] == '0') && (ulCount == 0))
c0d00980:	460b      	mov	r3, r1
c0d00982:	4053      	eors	r3, r2
c0d00984:	9706      	str	r7, [sp, #24]
c0d00986:	433b      	orrs	r3, r7
c0d00988:	d000      	beq.n	c0d0098c <mcu_usb_printf+0x90>
c0d0098a:	9a05      	ldr	r2, [sp, #20]
c0d0098c:	230a      	movs	r3, #10
                    ulCount *= 10;
c0d0098e:	9f06      	ldr	r7, [sp, #24]
c0d00990:	437b      	muls	r3, r7
                    ulCount += format[-1] - '0';
c0d00992:	185b      	adds	r3, r3, r1
c0d00994:	3b30      	subs	r3, #48	; 0x30
c0d00996:	4617      	mov	r7, r2
c0d00998:	e7d7      	b.n	c0d0094a <mcu_usb_printf+0x4e>
            switch(*format++)
c0d0099a:	292e      	cmp	r1, #46	; 0x2e
c0d0099c:	d000      	beq.n	c0d009a0 <mcu_usb_printf+0xa4>
c0d0099e:	e0e2      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d009a0:	7820      	ldrb	r0, [r4, #0]
c0d009a2:	282a      	cmp	r0, #42	; 0x2a
c0d009a4:	d000      	beq.n	c0d009a8 <mcu_usb_printf+0xac>
c0d009a6:	e0de      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
c0d009a8:	7860      	ldrb	r0, [r4, #1]
c0d009aa:	2848      	cmp	r0, #72	; 0x48
c0d009ac:	d004      	beq.n	c0d009b8 <mcu_usb_printf+0xbc>
c0d009ae:	2873      	cmp	r0, #115	; 0x73
c0d009b0:	d002      	beq.n	c0d009b8 <mcu_usb_printf+0xbc>
c0d009b2:	2868      	cmp	r0, #104	; 0x68
c0d009b4:	d000      	beq.n	c0d009b8 <mcu_usb_printf+0xbc>
c0d009b6:	e0d6      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
c0d009b8:	1c64      	adds	r4, r4, #1
c0d009ba:	2001      	movs	r0, #1
c0d009bc:	9908      	ldr	r1, [sp, #32]
c0d009be:	1d0a      	adds	r2, r1, #4
c0d009c0:	9208      	str	r2, [sp, #32]
c0d009c2:	680e      	ldr	r6, [r1, #0]
c0d009c4:	e7c1      	b.n	c0d0094a <mcu_usb_printf+0x4e>
c0d009c6:	1964      	adds	r4, r4, r5
c0d009c8:	e0dd      	b.n	c0d00b86 <mcu_usb_printf+0x28a>
            switch(*format++)
c0d009ca:	2967      	cmp	r1, #103	; 0x67
c0d009cc:	9404      	str	r4, [sp, #16]
c0d009ce:	dd08      	ble.n	c0d009e2 <mcu_usb_printf+0xe6>
c0d009d0:	2972      	cmp	r1, #114	; 0x72
c0d009d2:	dd10      	ble.n	c0d009f6 <mcu_usb_printf+0xfa>
c0d009d4:	2973      	cmp	r1, #115	; 0x73
c0d009d6:	d032      	beq.n	c0d00a3e <mcu_usb_printf+0x142>
c0d009d8:	2975      	cmp	r1, #117	; 0x75
c0d009da:	d036      	beq.n	c0d00a4a <mcu_usb_printf+0x14e>
c0d009dc:	2978      	cmp	r1, #120	; 0x78
c0d009de:	d010      	beq.n	c0d00a02 <mcu_usb_printf+0x106>
c0d009e0:	e0c1      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
c0d009e2:	2962      	cmp	r1, #98	; 0x62
c0d009e4:	dc16      	bgt.n	c0d00a14 <mcu_usb_printf+0x118>
c0d009e6:	2948      	cmp	r1, #72	; 0x48
c0d009e8:	d100      	bne.n	c0d009ec <mcu_usb_printf+0xf0>
c0d009ea:	e0a4      	b.n	c0d00b36 <mcu_usb_printf+0x23a>
c0d009ec:	2958      	cmp	r1, #88	; 0x58
c0d009ee:	d000      	beq.n	c0d009f2 <mcu_usb_printf+0xf6>
c0d009f0:	e0b9      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
c0d009f2:	2001      	movs	r0, #1
c0d009f4:	e006      	b.n	c0d00a04 <mcu_usb_printf+0x108>
c0d009f6:	2968      	cmp	r1, #104	; 0x68
c0d009f8:	d100      	bne.n	c0d009fc <mcu_usb_printf+0x100>
c0d009fa:	e0a0      	b.n	c0d00b3e <mcu_usb_printf+0x242>
c0d009fc:	2970      	cmp	r1, #112	; 0x70
c0d009fe:	d000      	beq.n	c0d00a02 <mcu_usb_printf+0x106>
c0d00a00:	e0b1      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
c0d00a02:	2000      	movs	r0, #0
c0d00a04:	9001      	str	r0, [sp, #4]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d00a06:	9808      	ldr	r0, [sp, #32]
c0d00a08:	1d01      	adds	r1, r0, #4
c0d00a0a:	9108      	str	r1, [sp, #32]
c0d00a0c:	6800      	ldr	r0, [r0, #0]
c0d00a0e:	900d      	str	r0, [sp, #52]	; 0x34
c0d00a10:	2610      	movs	r6, #16
c0d00a12:	e022      	b.n	c0d00a5a <mcu_usb_printf+0x15e>
            switch(*format++)
c0d00a14:	2963      	cmp	r1, #99	; 0x63
c0d00a16:	d100      	bne.n	c0d00a1a <mcu_usb_printf+0x11e>
c0d00a18:	e0aa      	b.n	c0d00b70 <mcu_usb_printf+0x274>
c0d00a1a:	2964      	cmp	r1, #100	; 0x64
c0d00a1c:	d000      	beq.n	c0d00a20 <mcu_usb_printf+0x124>
c0d00a1e:	e0a2      	b.n	c0d00b66 <mcu_usb_printf+0x26a>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d00a20:	9808      	ldr	r0, [sp, #32]
c0d00a22:	1d01      	adds	r1, r0, #4
c0d00a24:	9108      	str	r1, [sp, #32]
c0d00a26:	6800      	ldr	r0, [r0, #0]
c0d00a28:	900d      	str	r0, [sp, #52]	; 0x34
c0d00a2a:	260a      	movs	r6, #10
                    if((long)ulValue < 0)
c0d00a2c:	2800      	cmp	r0, #0
c0d00a2e:	d500      	bpl.n	c0d00a32 <mcu_usb_printf+0x136>
c0d00a30:	e0d2      	b.n	c0d00bd8 <mcu_usb_printf+0x2dc>
c0d00a32:	2100      	movs	r1, #0
c0d00a34:	9101      	str	r1, [sp, #4]
c0d00a36:	e010      	b.n	c0d00a5a <mcu_usb_printf+0x15e>
c0d00a38:	9404      	str	r4, [sp, #16]
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    mcu_usb_prints(format - 1, 1);
c0d00a3a:	1e60      	subs	r0, r4, #1
c0d00a3c:	e09e      	b.n	c0d00b7c <mcu_usb_printf+0x280>
c0d00a3e:	4619      	mov	r1, r3
c0d00a40:	4a77      	ldr	r2, [pc, #476]	; (c0d00c20 <mcu_usb_printf+0x324>)
c0d00a42:	447a      	add	r2, pc
c0d00a44:	9206      	str	r2, [sp, #24]
c0d00a46:	2400      	movs	r4, #0
c0d00a48:	e07e      	b.n	c0d00b48 <mcu_usb_printf+0x24c>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d00a4a:	9808      	ldr	r0, [sp, #32]
c0d00a4c:	1d01      	adds	r1, r0, #4
c0d00a4e:	9108      	str	r1, [sp, #32]
c0d00a50:	6800      	ldr	r0, [r0, #0]
c0d00a52:	900d      	str	r0, [sp, #52]	; 0x34
c0d00a54:	2100      	movs	r1, #0
c0d00a56:	9101      	str	r1, [sp, #4]
c0d00a58:	260a      	movs	r6, #10
c0d00a5a:	9903      	ldr	r1, [sp, #12]
c0d00a5c:	9102      	str	r1, [sp, #8]
c0d00a5e:	9705      	str	r7, [sp, #20]
c0d00a60:	9007      	str	r0, [sp, #28]
                        (((ulIdx * ulBase) <= ulValue) &&
c0d00a62:	4286      	cmp	r6, r0
c0d00a64:	d901      	bls.n	c0d00a6a <mcu_usb_printf+0x16e>
c0d00a66:	9f03      	ldr	r7, [sp, #12]
c0d00a68:	e014      	b.n	c0d00a94 <mcu_usb_printf+0x198>
                    for(ulIdx = 1;
c0d00a6a:	1e5a      	subs	r2, r3, #1
c0d00a6c:	4630      	mov	r0, r6
c0d00a6e:	4607      	mov	r7, r0
c0d00a70:	4615      	mov	r5, r2
c0d00a72:	2100      	movs	r1, #0
                        (((ulIdx * ulBase) <= ulValue) &&
c0d00a74:	4630      	mov	r0, r6
c0d00a76:	463a      	mov	r2, r7
c0d00a78:	460b      	mov	r3, r1
c0d00a7a:	f000 f9a1 	bl	c0d00dc0 <__aeabi_lmul>
c0d00a7e:	1e4a      	subs	r2, r1, #1
c0d00a80:	4191      	sbcs	r1, r2
c0d00a82:	9a07      	ldr	r2, [sp, #28]
c0d00a84:	4290      	cmp	r0, r2
c0d00a86:	d804      	bhi.n	c0d00a92 <mcu_usb_printf+0x196>
                    for(ulIdx = 1;
c0d00a88:	1e6a      	subs	r2, r5, #1
c0d00a8a:	2900      	cmp	r1, #0
c0d00a8c:	462b      	mov	r3, r5
c0d00a8e:	d0ee      	beq.n	c0d00a6e <mcu_usb_printf+0x172>
c0d00a90:	e000      	b.n	c0d00a94 <mcu_usb_printf+0x198>
c0d00a92:	462b      	mov	r3, r5
c0d00a94:	9a02      	ldr	r2, [sp, #8]
                    if(ulNeg)
c0d00a96:	4610      	mov	r0, r2
c0d00a98:	9903      	ldr	r1, [sp, #12]
c0d00a9a:	4048      	eors	r0, r1
c0d00a9c:	1a1c      	subs	r4, r3, r0
                    if(ulNeg && (cFill == '0'))
c0d00a9e:	9406      	str	r4, [sp, #24]
c0d00aa0:	2a00      	cmp	r2, #0
c0d00aa2:	d001      	beq.n	c0d00aa8 <mcu_usb_printf+0x1ac>
c0d00aa4:	2500      	movs	r5, #0
c0d00aa6:	e00c      	b.n	c0d00ac2 <mcu_usb_printf+0x1c6>
c0d00aa8:	9a05      	ldr	r2, [sp, #20]
c0d00aaa:	b2d2      	uxtb	r2, r2
c0d00aac:	2100      	movs	r1, #0
c0d00aae:	2a30      	cmp	r2, #48	; 0x30
c0d00ab0:	460d      	mov	r5, r1
c0d00ab2:	d106      	bne.n	c0d00ac2 <mcu_usb_printf+0x1c6>
c0d00ab4:	aa09      	add	r2, sp, #36	; 0x24
c0d00ab6:	461d      	mov	r5, r3
c0d00ab8:	232d      	movs	r3, #45	; 0x2d
                        pcBuf[ulPos++] = '-';
c0d00aba:	7013      	strb	r3, [r2, #0]
c0d00abc:	462b      	mov	r3, r5
c0d00abe:	2501      	movs	r5, #1
c0d00ac0:	9903      	ldr	r1, [sp, #12]
c0d00ac2:	9c06      	ldr	r4, [sp, #24]
                    if((ulCount > 1) && (ulCount < 16))
c0d00ac4:	1ea2      	subs	r2, r4, #2
c0d00ac6:	2a0d      	cmp	r2, #13
c0d00ac8:	d80f      	bhi.n	c0d00aea <mcu_usb_printf+0x1ee>
c0d00aca:	9102      	str	r1, [sp, #8]
c0d00acc:	1e61      	subs	r1, r4, #1
c0d00ace:	d00b      	beq.n	c0d00ae8 <mcu_usb_printf+0x1ec>
c0d00ad0:	4244      	negs	r4, r0
c0d00ad2:	a809      	add	r0, sp, #36	; 0x24
                        for(ulCount--; ulCount; ulCount--)
c0d00ad4:	1940      	adds	r0, r0, r5
                            pcBuf[ulPos++] = cFill;
c0d00ad6:	9a05      	ldr	r2, [sp, #20]
c0d00ad8:	b2d2      	uxtb	r2, r2
c0d00ada:	9306      	str	r3, [sp, #24]
c0d00adc:	f000 f9a2 	bl	c0d00e24 <__aeabi_memset>
                        for(ulCount--; ulCount; ulCount--)
c0d00ae0:	9806      	ldr	r0, [sp, #24]
c0d00ae2:	1828      	adds	r0, r5, r0
c0d00ae4:	1900      	adds	r0, r0, r4
c0d00ae6:	1e45      	subs	r5, r0, #1
c0d00ae8:	9902      	ldr	r1, [sp, #8]
                    if(ulNeg)
c0d00aea:	2900      	cmp	r1, #0
c0d00aec:	d103      	bne.n	c0d00af6 <mcu_usb_printf+0x1fa>
c0d00aee:	a809      	add	r0, sp, #36	; 0x24
c0d00af0:	212d      	movs	r1, #45	; 0x2d
                        pcBuf[ulPos++] = '-';
c0d00af2:	5541      	strb	r1, [r0, r5]
c0d00af4:	1c6d      	adds	r5, r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0d00af6:	2f00      	cmp	r7, #0
c0d00af8:	d01a      	beq.n	c0d00b30 <mcu_usb_printf+0x234>
c0d00afa:	4634      	mov	r4, r6
c0d00afc:	9801      	ldr	r0, [sp, #4]
c0d00afe:	2800      	cmp	r0, #0
c0d00b00:	d002      	beq.n	c0d00b08 <mcu_usb_printf+0x20c>
c0d00b02:	4e4d      	ldr	r6, [pc, #308]	; (c0d00c38 <mcu_usb_printf+0x33c>)
c0d00b04:	447e      	add	r6, pc
c0d00b06:	e001      	b.n	c0d00b0c <mcu_usb_printf+0x210>
c0d00b08:	4e4a      	ldr	r6, [pc, #296]	; (c0d00c34 <mcu_usb_printf+0x338>)
c0d00b0a:	447e      	add	r6, pc
c0d00b0c:	9807      	ldr	r0, [sp, #28]
c0d00b0e:	4639      	mov	r1, r7
c0d00b10:	f000 f90e 	bl	c0d00d30 <__udivsi3>
c0d00b14:	4621      	mov	r1, r4
c0d00b16:	f000 f947 	bl	c0d00da8 <__aeabi_uidivmod>
c0d00b1a:	5c70      	ldrb	r0, [r6, r1]
c0d00b1c:	a909      	add	r1, sp, #36	; 0x24
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0d00b1e:	5548      	strb	r0, [r1, r5]
                    for(; ulIdx; ulIdx /= ulBase)
c0d00b20:	4638      	mov	r0, r7
c0d00b22:	4621      	mov	r1, r4
c0d00b24:	f000 f904 	bl	c0d00d30 <__udivsi3>
c0d00b28:	1c6d      	adds	r5, r5, #1
c0d00b2a:	42bc      	cmp	r4, r7
c0d00b2c:	4607      	mov	r7, r0
c0d00b2e:	d9ed      	bls.n	c0d00b0c <mcu_usb_printf+0x210>
c0d00b30:	a809      	add	r0, sp, #36	; 0x24
                    mcu_usb_prints(pcBuf, ulPos);
c0d00b32:	4629      	mov	r1, r5
c0d00b34:	e023      	b.n	c0d00b7e <mcu_usb_printf+0x282>
c0d00b36:	4619      	mov	r1, r3
c0d00b38:	4a3a      	ldr	r2, [pc, #232]	; (c0d00c24 <mcu_usb_printf+0x328>)
c0d00b3a:	447a      	add	r2, pc
c0d00b3c:	e002      	b.n	c0d00b44 <mcu_usb_printf+0x248>
c0d00b3e:	4619      	mov	r1, r3
c0d00b40:	4a39      	ldr	r2, [pc, #228]	; (c0d00c28 <mcu_usb_printf+0x32c>)
c0d00b42:	447a      	add	r2, pc
c0d00b44:	9206      	str	r2, [sp, #24]
c0d00b46:	9c03      	ldr	r4, [sp, #12]
                    pcStr = va_arg(vaArgP, char *);
c0d00b48:	9a08      	ldr	r2, [sp, #32]
c0d00b4a:	1d13      	adds	r3, r2, #4
c0d00b4c:	9308      	str	r3, [sp, #32]
                    switch(cStrlenSet) {
c0d00b4e:	b2c0      	uxtb	r0, r0
                    pcStr = va_arg(vaArgP, char *);
c0d00b50:	6817      	ldr	r7, [r2, #0]
                    switch(cStrlenSet) {
c0d00b52:	2800      	cmp	r0, #0
c0d00b54:	d01a      	beq.n	c0d00b8c <mcu_usb_printf+0x290>
c0d00b56:	2801      	cmp	r0, #1
c0d00b58:	d020      	beq.n	c0d00b9c <mcu_usb_printf+0x2a0>
c0d00b5a:	2802      	cmp	r0, #2
c0d00b5c:	d11d      	bne.n	c0d00b9a <mcu_usb_printf+0x29e>
                        if (pcStr[0] == '\0') {
c0d00b5e:	7838      	ldrb	r0, [r7, #0]
c0d00b60:	2800      	cmp	r0, #0
c0d00b62:	9c04      	ldr	r4, [sp, #16]
c0d00b64:	d03e      	beq.n	c0d00be4 <mcu_usb_printf+0x2e8>
c0d00b66:	9404      	str	r4, [sp, #16]
                default:
                {
                    //
                    // Indicate an error.
                    //
                    mcu_usb_prints("ERROR", 5);
c0d00b68:	482c      	ldr	r0, [pc, #176]	; (c0d00c1c <mcu_usb_printf+0x320>)
c0d00b6a:	4478      	add	r0, pc
c0d00b6c:	2105      	movs	r1, #5
c0d00b6e:	e006      	b.n	c0d00b7e <mcu_usb_printf+0x282>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d00b70:	9808      	ldr	r0, [sp, #32]
c0d00b72:	1d01      	adds	r1, r0, #4
c0d00b74:	9108      	str	r1, [sp, #32]
c0d00b76:	6800      	ldr	r0, [r0, #0]
c0d00b78:	900d      	str	r0, [sp, #52]	; 0x34
c0d00b7a:	a80d      	add	r0, sp, #52	; 0x34
c0d00b7c:	2101      	movs	r1, #1
c0d00b7e:	f7ff fea9 	bl	c0d008d4 <mcu_usb_prints>
c0d00b82:	9c04      	ldr	r4, [sp, #16]
    while(*format)
c0d00b84:	7820      	ldrb	r0, [r4, #0]
c0d00b86:	2800      	cmp	r0, #0
c0d00b88:	d042      	beq.n	c0d00c10 <mcu_usb_printf+0x314>
c0d00b8a:	e6c8      	b.n	c0d0091e <mcu_usb_printf+0x22>
c0d00b8c:	2000      	movs	r0, #0
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d00b8e:	5c3a      	ldrb	r2, [r7, r0]
c0d00b90:	1c40      	adds	r0, r0, #1
c0d00b92:	2a00      	cmp	r2, #0
c0d00b94:	d1fb      	bne.n	c0d00b8e <mcu_usb_printf+0x292>
                    switch(ulBase) {
c0d00b96:	1e46      	subs	r6, r0, #1
c0d00b98:	e000      	b.n	c0d00b9c <mcu_usb_printf+0x2a0>
c0d00b9a:	462e      	mov	r6, r5
c0d00b9c:	2c00      	cmp	r4, #0
c0d00b9e:	d015      	beq.n	c0d00bcc <mcu_usb_printf+0x2d0>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d00ba0:	2e00      	cmp	r6, #0
c0d00ba2:	d0ee      	beq.n	c0d00b82 <mcu_usb_printf+0x286>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d00ba4:	7838      	ldrb	r0, [r7, #0]
c0d00ba6:	9007      	str	r0, [sp, #28]
c0d00ba8:	0900      	lsrs	r0, r0, #4
c0d00baa:	9c06      	ldr	r4, [sp, #24]
c0d00bac:	1820      	adds	r0, r4, r0
c0d00bae:	2501      	movs	r5, #1
c0d00bb0:	4629      	mov	r1, r5
c0d00bb2:	f7ff fe8f 	bl	c0d008d4 <mcu_usb_prints>
c0d00bb6:	200f      	movs	r0, #15
                          nibble2 = pcStr[ulCount]&0xF;
c0d00bb8:	9907      	ldr	r1, [sp, #28]
c0d00bba:	4008      	ands	r0, r1
c0d00bbc:	1820      	adds	r0, r4, r0
c0d00bbe:	4629      	mov	r1, r5
c0d00bc0:	f7ff fe88 	bl	c0d008d4 <mcu_usb_prints>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d00bc4:	1c7f      	adds	r7, r7, #1
c0d00bc6:	1e76      	subs	r6, r6, #1
c0d00bc8:	d1ec      	bne.n	c0d00ba4 <mcu_usb_printf+0x2a8>
c0d00bca:	e7da      	b.n	c0d00b82 <mcu_usb_printf+0x286>
c0d00bcc:	9106      	str	r1, [sp, #24]
                        mcu_usb_prints(pcStr, ulIdx);
c0d00bce:	4638      	mov	r0, r7
c0d00bd0:	4631      	mov	r1, r6
c0d00bd2:	f7ff fe7f 	bl	c0d008d4 <mcu_usb_prints>
c0d00bd6:	e00f      	b.n	c0d00bf8 <mcu_usb_printf+0x2fc>
                        ulValue = -(long)ulValue;
c0d00bd8:	4240      	negs	r0, r0
c0d00bda:	900d      	str	r0, [sp, #52]	; 0x34
c0d00bdc:	2100      	movs	r1, #0
c0d00bde:	9102      	str	r1, [sp, #8]
            ulCap = 0;
c0d00be0:	9101      	str	r1, [sp, #4]
c0d00be2:	e73c      	b.n	c0d00a5e <mcu_usb_printf+0x162>
c0d00be4:	9106      	str	r1, [sp, #24]
                          do {
c0d00be6:	1c74      	adds	r4, r6, #1
                            mcu_usb_prints(" ", 1);
c0d00be8:	4810      	ldr	r0, [pc, #64]	; (c0d00c2c <mcu_usb_printf+0x330>)
c0d00bea:	4478      	add	r0, pc
c0d00bec:	2101      	movs	r1, #1
c0d00bee:	f7ff fe71 	bl	c0d008d4 <mcu_usb_prints>
                          } while(ulStrlen-- > 0);
c0d00bf2:	1e64      	subs	r4, r4, #1
c0d00bf4:	d1f8      	bne.n	c0d00be8 <mcu_usb_printf+0x2ec>
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d00bf6:	462e      	mov	r6, r5
c0d00bf8:	9806      	ldr	r0, [sp, #24]
                    if(ulCount > ulIdx)
c0d00bfa:	42b0      	cmp	r0, r6
c0d00bfc:	d9c1      	bls.n	c0d00b82 <mcu_usb_printf+0x286>
                        while(ulCount--)
c0d00bfe:	1a34      	subs	r4, r6, r0
                            mcu_usb_prints(" ", 1);
c0d00c00:	480b      	ldr	r0, [pc, #44]	; (c0d00c30 <mcu_usb_printf+0x334>)
c0d00c02:	4478      	add	r0, pc
c0d00c04:	2101      	movs	r1, #1
c0d00c06:	f7ff fe65 	bl	c0d008d4 <mcu_usb_prints>
                        while(ulCount--)
c0d00c0a:	1c64      	adds	r4, r4, #1
c0d00c0c:	d3f8      	bcc.n	c0d00c00 <mcu_usb_printf+0x304>
c0d00c0e:	e7b8      	b.n	c0d00b82 <mcu_usb_printf+0x286>

    //
    // End the varargs processing.
    //
    va_end(vaArgP);
}
c0d00c10:	b00e      	add	sp, #56	; 0x38
c0d00c12:	bcf0      	pop	{r4, r5, r6, r7}
c0d00c14:	bc01      	pop	{r0}
c0d00c16:	b003      	add	sp, #12
c0d00c18:	4700      	bx	r0
c0d00c1a:	46c0      	nop			; (mov r8, r8)
c0d00c1c:	000005de 	.word	0x000005de
c0d00c20:	00000953 	.word	0x00000953
c0d00c24:	0000086b 	.word	0x0000086b
c0d00c28:	00000853 	.word	0x00000853
c0d00c2c:	0000059c 	.word	0x0000059c
c0d00c30:	00000584 	.word	0x00000584
c0d00c34:	0000088b 	.word	0x0000088b
c0d00c38:	000008a1 	.word	0x000008a1

c0d00c3c <pic_internal>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
__attribute__((naked)) void *pic_internal(void *link_address)
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");
c0d00c3c:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");
c0d00c3e:	4902      	ldr	r1, [pc, #8]	; (c0d00c48 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");
c0d00c40:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");
c0d00c42:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");
c0d00c44:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d00c46:	4770      	bx	lr
c0d00c48:	c0d00c3d 	.word	0xc0d00c3d

c0d00c4c <pic>:
extern void _nvram;
extern void _envram;

#if defined(ST31)

void *pic(void *link_address) {
c0d00c4c:	b580      	push	{r7, lr}
  // check if in the LINKED TEXT zone
  if (link_address >= &_nvram && link_address < &_envram) {
c0d00c4e:	4904      	ldr	r1, [pc, #16]	; (c0d00c60 <pic+0x14>)
c0d00c50:	4288      	cmp	r0, r1
c0d00c52:	d304      	bcc.n	c0d00c5e <pic+0x12>
c0d00c54:	4903      	ldr	r1, [pc, #12]	; (c0d00c64 <pic+0x18>)
c0d00c56:	4288      	cmp	r0, r1
c0d00c58:	d201      	bcs.n	c0d00c5e <pic+0x12>
    link_address = pic_internal(link_address);
c0d00c5a:	f7ff ffef 	bl	c0d00c3c <pic_internal>
  }

  return link_address;
c0d00c5e:	bd80      	pop	{r7, pc}
c0d00c60:	c0d00000 	.word	0xc0d00000
c0d00c64:	c0d01400 	.word	0xc0d01400

c0d00c68 <SVC_Call>:
.thumb
.thumb_func
.global SVC_Call

SVC_Call:
    svc 1
c0d00c68:	df01      	svc	1
    cmp r1, #0
c0d00c6a:	2900      	cmp	r1, #0
    bne exception
c0d00c6c:	d100      	bne.n	c0d00c70 <exception>
    bx lr
c0d00c6e:	4770      	bx	lr

c0d00c70 <exception>:
exception:
    // THROW(ex);
    mov r0, r1
c0d00c70:	4608      	mov	r0, r1
    bl os_longjmp
c0d00c72:	f7ff fe21 	bl	c0d008b8 <os_longjmp>
	...

c0d00c78 <get_api_level>:
#include <string.h>

unsigned int SVC_Call(unsigned int syscall_id, void *parameters);
unsigned int SVC_cx_call(unsigned int syscall_id, unsigned int * parameters);

unsigned int get_api_level(void) {
c0d00c78:	b580      	push	{r7, lr}
c0d00c7a:	b084      	sub	sp, #16
c0d00c7c:	2000      	movs	r0, #0
  unsigned int parameters [2+1];
  parameters[0] = 0;
  parameters[1] = 0;
c0d00c7e:	9002      	str	r0, [sp, #8]
  parameters[0] = 0;
c0d00c80:	9001      	str	r0, [sp, #4]
c0d00c82:	4803      	ldr	r0, [pc, #12]	; (c0d00c90 <get_api_level+0x18>)
c0d00c84:	a901      	add	r1, sp, #4
  return SVC_Call(SYSCALL_get_api_level_ID_IN, parameters);
c0d00c86:	f7ff ffef 	bl	c0d00c68 <SVC_Call>
c0d00c8a:	b004      	add	sp, #16
c0d00c8c:	bd80      	pop	{r7, pc}
c0d00c8e:	46c0      	nop			; (mov r8, r8)
c0d00c90:	60000138 	.word	0x60000138

c0d00c94 <os_lib_call>:
  SVC_Call(SYSCALL_os_ux_result_ID_IN, parameters);
  return;
}
#endif // !defined(APP_UX)

void os_lib_call ( unsigned int * call_parameters ) {
c0d00c94:	b580      	push	{r7, lr}
c0d00c96:	b084      	sub	sp, #16
c0d00c98:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)call_parameters;
  parameters[1] = 0;
c0d00c9a:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)call_parameters;
c0d00c9c:	9001      	str	r0, [sp, #4]
c0d00c9e:	4803      	ldr	r0, [pc, #12]	; (c0d00cac <os_lib_call+0x18>)
c0d00ca0:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_lib_call_ID_IN, parameters);
c0d00ca2:	f7ff ffe1 	bl	c0d00c68 <SVC_Call>
  return;
}
c0d00ca6:	b004      	add	sp, #16
c0d00ca8:	bd80      	pop	{r7, pc}
c0d00caa:	46c0      	nop			; (mov r8, r8)
c0d00cac:	6000670d 	.word	0x6000670d

c0d00cb0 <os_lib_end>:

void os_lib_end ( void ) {
c0d00cb0:	b580      	push	{r7, lr}
c0d00cb2:	b082      	sub	sp, #8
c0d00cb4:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d00cb6:	9001      	str	r0, [sp, #4]
c0d00cb8:	4802      	ldr	r0, [pc, #8]	; (c0d00cc4 <os_lib_end+0x14>)
c0d00cba:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_end_ID_IN, parameters);
c0d00cbc:	f7ff ffd4 	bl	c0d00c68 <SVC_Call>
  return;
}
c0d00cc0:	b002      	add	sp, #8
c0d00cc2:	bd80      	pop	{r7, pc}
c0d00cc4:	6000688d 	.word	0x6000688d

c0d00cc8 <os_sched_exit>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
  return;
}

void os_sched_exit ( bolos_task_status_t exit_code ) {
c0d00cc8:	b580      	push	{r7, lr}
c0d00cca:	b084      	sub	sp, #16
c0d00ccc:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
  parameters[1] = 0;
c0d00cce:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)exit_code;
c0d00cd0:	9001      	str	r0, [sp, #4]
c0d00cd2:	4803      	ldr	r0, [pc, #12]	; (c0d00ce0 <os_sched_exit+0x18>)
c0d00cd4:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d00cd6:	f7ff ffc7 	bl	c0d00c68 <SVC_Call>
  return;
}
c0d00cda:	b004      	add	sp, #16
c0d00cdc:	bd80      	pop	{r7, pc}
c0d00cde:	46c0      	nop			; (mov r8, r8)
c0d00ce0:	60009abe 	.word	0x60009abe

c0d00ce4 <io_seph_send>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
  return;
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) {
c0d00ce4:	b580      	push	{r7, lr}
c0d00ce6:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)length;
c0d00ce8:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)buffer;
c0d00cea:	9000      	str	r0, [sp, #0]
c0d00cec:	4802      	ldr	r0, [pc, #8]	; (c0d00cf8 <io_seph_send+0x14>)
c0d00cee:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d00cf0:	f7ff ffba 	bl	c0d00c68 <SVC_Call>
  return;
}
c0d00cf4:	b004      	add	sp, #16
c0d00cf6:	bd80      	pop	{r7, pc}
c0d00cf8:	60008381 	.word	0x60008381

c0d00cfc <try_context_get>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_nvm_erase_page_ID_IN, parameters);
  return;
}

try_context_t * try_context_get ( void ) {
c0d00cfc:	b580      	push	{r7, lr}
c0d00cfe:	b082      	sub	sp, #8
c0d00d00:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d00d02:	9001      	str	r0, [sp, #4]
c0d00d04:	4802      	ldr	r0, [pc, #8]	; (c0d00d10 <try_context_get+0x14>)
c0d00d06:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d00d08:	f7ff ffae 	bl	c0d00c68 <SVC_Call>
c0d00d0c:	b002      	add	sp, #8
c0d00d0e:	bd80      	pop	{r7, pc}
c0d00d10:	600087b1 	.word	0x600087b1

c0d00d14 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t *context ) {
c0d00d14:	b580      	push	{r7, lr}
c0d00d16:	b084      	sub	sp, #16
c0d00d18:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)context;
  parameters[1] = 0;
c0d00d1a:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)context;
c0d00d1c:	9001      	str	r0, [sp, #4]
c0d00d1e:	4803      	ldr	r0, [pc, #12]	; (c0d00d2c <try_context_set+0x18>)
c0d00d20:	a901      	add	r1, sp, #4
  return (try_context_t *) SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d00d22:	f7ff ffa1 	bl	c0d00c68 <SVC_Call>
c0d00d26:	b004      	add	sp, #16
c0d00d28:	bd80      	pop	{r7, pc}
c0d00d2a:	46c0      	nop			; (mov r8, r8)
c0d00d2c:	60010b06 	.word	0x60010b06

c0d00d30 <__udivsi3>:
c0d00d30:	2900      	cmp	r1, #0
c0d00d32:	d034      	beq.n	c0d00d9e <.udivsi3_skip_div0_test+0x6a>

c0d00d34 <.udivsi3_skip_div0_test>:
c0d00d34:	2301      	movs	r3, #1
c0d00d36:	2200      	movs	r2, #0
c0d00d38:	b410      	push	{r4}
c0d00d3a:	4288      	cmp	r0, r1
c0d00d3c:	d32c      	bcc.n	c0d00d98 <.udivsi3_skip_div0_test+0x64>
c0d00d3e:	2401      	movs	r4, #1
c0d00d40:	0724      	lsls	r4, r4, #28
c0d00d42:	42a1      	cmp	r1, r4
c0d00d44:	d204      	bcs.n	c0d00d50 <.udivsi3_skip_div0_test+0x1c>
c0d00d46:	4281      	cmp	r1, r0
c0d00d48:	d202      	bcs.n	c0d00d50 <.udivsi3_skip_div0_test+0x1c>
c0d00d4a:	0109      	lsls	r1, r1, #4
c0d00d4c:	011b      	lsls	r3, r3, #4
c0d00d4e:	e7f8      	b.n	c0d00d42 <.udivsi3_skip_div0_test+0xe>
c0d00d50:	00e4      	lsls	r4, r4, #3
c0d00d52:	42a1      	cmp	r1, r4
c0d00d54:	d204      	bcs.n	c0d00d60 <.udivsi3_skip_div0_test+0x2c>
c0d00d56:	4281      	cmp	r1, r0
c0d00d58:	d202      	bcs.n	c0d00d60 <.udivsi3_skip_div0_test+0x2c>
c0d00d5a:	0049      	lsls	r1, r1, #1
c0d00d5c:	005b      	lsls	r3, r3, #1
c0d00d5e:	e7f8      	b.n	c0d00d52 <.udivsi3_skip_div0_test+0x1e>
c0d00d60:	4288      	cmp	r0, r1
c0d00d62:	d301      	bcc.n	c0d00d68 <.udivsi3_skip_div0_test+0x34>
c0d00d64:	1a40      	subs	r0, r0, r1
c0d00d66:	431a      	orrs	r2, r3
c0d00d68:	084c      	lsrs	r4, r1, #1
c0d00d6a:	42a0      	cmp	r0, r4
c0d00d6c:	d302      	bcc.n	c0d00d74 <.udivsi3_skip_div0_test+0x40>
c0d00d6e:	1b00      	subs	r0, r0, r4
c0d00d70:	085c      	lsrs	r4, r3, #1
c0d00d72:	4322      	orrs	r2, r4
c0d00d74:	088c      	lsrs	r4, r1, #2
c0d00d76:	42a0      	cmp	r0, r4
c0d00d78:	d302      	bcc.n	c0d00d80 <.udivsi3_skip_div0_test+0x4c>
c0d00d7a:	1b00      	subs	r0, r0, r4
c0d00d7c:	089c      	lsrs	r4, r3, #2
c0d00d7e:	4322      	orrs	r2, r4
c0d00d80:	08cc      	lsrs	r4, r1, #3
c0d00d82:	42a0      	cmp	r0, r4
c0d00d84:	d302      	bcc.n	c0d00d8c <.udivsi3_skip_div0_test+0x58>
c0d00d86:	1b00      	subs	r0, r0, r4
c0d00d88:	08dc      	lsrs	r4, r3, #3
c0d00d8a:	4322      	orrs	r2, r4
c0d00d8c:	2800      	cmp	r0, #0
c0d00d8e:	d003      	beq.n	c0d00d98 <.udivsi3_skip_div0_test+0x64>
c0d00d90:	091b      	lsrs	r3, r3, #4
c0d00d92:	d001      	beq.n	c0d00d98 <.udivsi3_skip_div0_test+0x64>
c0d00d94:	0909      	lsrs	r1, r1, #4
c0d00d96:	e7e3      	b.n	c0d00d60 <.udivsi3_skip_div0_test+0x2c>
c0d00d98:	0010      	movs	r0, r2
c0d00d9a:	bc10      	pop	{r4}
c0d00d9c:	4770      	bx	lr
c0d00d9e:	b501      	push	{r0, lr}
c0d00da0:	2000      	movs	r0, #0
c0d00da2:	f000 f80b 	bl	c0d00dbc <__aeabi_idiv0>
c0d00da6:	bd02      	pop	{r1, pc}

c0d00da8 <__aeabi_uidivmod>:
c0d00da8:	2900      	cmp	r1, #0
c0d00daa:	d0f8      	beq.n	c0d00d9e <.udivsi3_skip_div0_test+0x6a>
c0d00dac:	b503      	push	{r0, r1, lr}
c0d00dae:	f7ff ffc1 	bl	c0d00d34 <.udivsi3_skip_div0_test>
c0d00db2:	bc0e      	pop	{r1, r2, r3}
c0d00db4:	4342      	muls	r2, r0
c0d00db6:	1a89      	subs	r1, r1, r2
c0d00db8:	4718      	bx	r3
c0d00dba:	46c0      	nop			; (mov r8, r8)

c0d00dbc <__aeabi_idiv0>:
c0d00dbc:	4770      	bx	lr
c0d00dbe:	46c0      	nop			; (mov r8, r8)

c0d00dc0 <__aeabi_lmul>:
c0d00dc0:	b5f7      	push	{r0, r1, r2, r4, r5, r6, r7, lr}
c0d00dc2:	9301      	str	r3, [sp, #4]
c0d00dc4:	b283      	uxth	r3, r0
c0d00dc6:	469c      	mov	ip, r3
c0d00dc8:	0006      	movs	r6, r0
c0d00dca:	0c03      	lsrs	r3, r0, #16
c0d00dcc:	4660      	mov	r0, ip
c0d00dce:	000d      	movs	r5, r1
c0d00dd0:	4661      	mov	r1, ip
c0d00dd2:	b297      	uxth	r7, r2
c0d00dd4:	4378      	muls	r0, r7
c0d00dd6:	0c14      	lsrs	r4, r2, #16
c0d00dd8:	435f      	muls	r7, r3
c0d00dda:	4363      	muls	r3, r4
c0d00ddc:	434c      	muls	r4, r1
c0d00dde:	0c01      	lsrs	r1, r0, #16
c0d00de0:	468c      	mov	ip, r1
c0d00de2:	19e4      	adds	r4, r4, r7
c0d00de4:	4464      	add	r4, ip
c0d00de6:	42a7      	cmp	r7, r4
c0d00de8:	d902      	bls.n	c0d00df0 <__aeabi_lmul+0x30>
c0d00dea:	2180      	movs	r1, #128	; 0x80
c0d00dec:	0249      	lsls	r1, r1, #9
c0d00dee:	185b      	adds	r3, r3, r1
c0d00df0:	9901      	ldr	r1, [sp, #4]
c0d00df2:	436a      	muls	r2, r5
c0d00df4:	4371      	muls	r1, r6
c0d00df6:	0c27      	lsrs	r7, r4, #16
c0d00df8:	18fb      	adds	r3, r7, r3
c0d00dfa:	0424      	lsls	r4, r4, #16
c0d00dfc:	18c9      	adds	r1, r1, r3
c0d00dfe:	b280      	uxth	r0, r0
c0d00e00:	1820      	adds	r0, r4, r0
c0d00e02:	1889      	adds	r1, r1, r2
c0d00e04:	b003      	add	sp, #12
c0d00e06:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00e08 <__aeabi_memclr>:
c0d00e08:	b510      	push	{r4, lr}
c0d00e0a:	2200      	movs	r2, #0
c0d00e0c:	f000 f80a 	bl	c0d00e24 <__aeabi_memset>
c0d00e10:	bd10      	pop	{r4, pc}
c0d00e12:	46c0      	nop			; (mov r8, r8)

c0d00e14 <__aeabi_memcpy>:
c0d00e14:	b510      	push	{r4, lr}
c0d00e16:	f000 f831 	bl	c0d00e7c <memcpy>
c0d00e1a:	bd10      	pop	{r4, pc}

c0d00e1c <__aeabi_memmove>:
c0d00e1c:	b510      	push	{r4, lr}
c0d00e1e:	f000 f87f 	bl	c0d00f20 <memmove>
c0d00e22:	bd10      	pop	{r4, pc}

c0d00e24 <__aeabi_memset>:
c0d00e24:	000b      	movs	r3, r1
c0d00e26:	b510      	push	{r4, lr}
c0d00e28:	0011      	movs	r1, r2
c0d00e2a:	001a      	movs	r2, r3
c0d00e2c:	f000 f8ce 	bl	c0d00fcc <memset>
c0d00e30:	bd10      	pop	{r4, pc}
c0d00e32:	46c0      	nop			; (mov r8, r8)

c0d00e34 <memcmp>:
c0d00e34:	b530      	push	{r4, r5, lr}
c0d00e36:	2a03      	cmp	r2, #3
c0d00e38:	d90c      	bls.n	c0d00e54 <memcmp+0x20>
c0d00e3a:	0003      	movs	r3, r0
c0d00e3c:	430b      	orrs	r3, r1
c0d00e3e:	079b      	lsls	r3, r3, #30
c0d00e40:	d119      	bne.n	c0d00e76 <memcmp+0x42>
c0d00e42:	6803      	ldr	r3, [r0, #0]
c0d00e44:	680c      	ldr	r4, [r1, #0]
c0d00e46:	42a3      	cmp	r3, r4
c0d00e48:	d115      	bne.n	c0d00e76 <memcmp+0x42>
c0d00e4a:	3a04      	subs	r2, #4
c0d00e4c:	3004      	adds	r0, #4
c0d00e4e:	3104      	adds	r1, #4
c0d00e50:	2a03      	cmp	r2, #3
c0d00e52:	d8f6      	bhi.n	c0d00e42 <memcmp+0xe>
c0d00e54:	1e55      	subs	r5, r2, #1
c0d00e56:	2a00      	cmp	r2, #0
c0d00e58:	d00b      	beq.n	c0d00e72 <memcmp+0x3e>
c0d00e5a:	2300      	movs	r3, #0
c0d00e5c:	e003      	b.n	c0d00e66 <memcmp+0x32>
c0d00e5e:	1c5a      	adds	r2, r3, #1
c0d00e60:	429d      	cmp	r5, r3
c0d00e62:	d006      	beq.n	c0d00e72 <memcmp+0x3e>
c0d00e64:	0013      	movs	r3, r2
c0d00e66:	5cc2      	ldrb	r2, [r0, r3]
c0d00e68:	5ccc      	ldrb	r4, [r1, r3]
c0d00e6a:	42a2      	cmp	r2, r4
c0d00e6c:	d0f7      	beq.n	c0d00e5e <memcmp+0x2a>
c0d00e6e:	1b10      	subs	r0, r2, r4
c0d00e70:	e000      	b.n	c0d00e74 <memcmp+0x40>
c0d00e72:	2000      	movs	r0, #0
c0d00e74:	bd30      	pop	{r4, r5, pc}
c0d00e76:	1e55      	subs	r5, r2, #1
c0d00e78:	e7ef      	b.n	c0d00e5a <memcmp+0x26>
c0d00e7a:	46c0      	nop			; (mov r8, r8)

c0d00e7c <memcpy>:
c0d00e7c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e7e:	46c6      	mov	lr, r8
c0d00e80:	b500      	push	{lr}
c0d00e82:	2a0f      	cmp	r2, #15
c0d00e84:	d941      	bls.n	c0d00f0a <memcpy+0x8e>
c0d00e86:	2703      	movs	r7, #3
c0d00e88:	000d      	movs	r5, r1
c0d00e8a:	003e      	movs	r6, r7
c0d00e8c:	4305      	orrs	r5, r0
c0d00e8e:	000c      	movs	r4, r1
c0d00e90:	0003      	movs	r3, r0
c0d00e92:	402e      	ands	r6, r5
c0d00e94:	422f      	tst	r7, r5
c0d00e96:	d13d      	bne.n	c0d00f14 <memcpy+0x98>
c0d00e98:	0015      	movs	r5, r2
c0d00e9a:	3d10      	subs	r5, #16
c0d00e9c:	092d      	lsrs	r5, r5, #4
c0d00e9e:	46a8      	mov	r8, r5
c0d00ea0:	012d      	lsls	r5, r5, #4
c0d00ea2:	46ac      	mov	ip, r5
c0d00ea4:	4484      	add	ip, r0
c0d00ea6:	6827      	ldr	r7, [r4, #0]
c0d00ea8:	001d      	movs	r5, r3
c0d00eaa:	601f      	str	r7, [r3, #0]
c0d00eac:	6867      	ldr	r7, [r4, #4]
c0d00eae:	605f      	str	r7, [r3, #4]
c0d00eb0:	68a7      	ldr	r7, [r4, #8]
c0d00eb2:	609f      	str	r7, [r3, #8]
c0d00eb4:	68e7      	ldr	r7, [r4, #12]
c0d00eb6:	3410      	adds	r4, #16
c0d00eb8:	60df      	str	r7, [r3, #12]
c0d00eba:	3310      	adds	r3, #16
c0d00ebc:	4565      	cmp	r5, ip
c0d00ebe:	d1f2      	bne.n	c0d00ea6 <memcpy+0x2a>
c0d00ec0:	4645      	mov	r5, r8
c0d00ec2:	230f      	movs	r3, #15
c0d00ec4:	240c      	movs	r4, #12
c0d00ec6:	3501      	adds	r5, #1
c0d00ec8:	012d      	lsls	r5, r5, #4
c0d00eca:	1949      	adds	r1, r1, r5
c0d00ecc:	4013      	ands	r3, r2
c0d00ece:	1945      	adds	r5, r0, r5
c0d00ed0:	4214      	tst	r4, r2
c0d00ed2:	d022      	beq.n	c0d00f1a <memcpy+0x9e>
c0d00ed4:	598c      	ldr	r4, [r1, r6]
c0d00ed6:	51ac      	str	r4, [r5, r6]
c0d00ed8:	3604      	adds	r6, #4
c0d00eda:	1b9c      	subs	r4, r3, r6
c0d00edc:	2c03      	cmp	r4, #3
c0d00ede:	d8f9      	bhi.n	c0d00ed4 <memcpy+0x58>
c0d00ee0:	3b04      	subs	r3, #4
c0d00ee2:	089b      	lsrs	r3, r3, #2
c0d00ee4:	3301      	adds	r3, #1
c0d00ee6:	009b      	lsls	r3, r3, #2
c0d00ee8:	18ed      	adds	r5, r5, r3
c0d00eea:	18c9      	adds	r1, r1, r3
c0d00eec:	2303      	movs	r3, #3
c0d00eee:	401a      	ands	r2, r3
c0d00ef0:	1e56      	subs	r6, r2, #1
c0d00ef2:	2a00      	cmp	r2, #0
c0d00ef4:	d006      	beq.n	c0d00f04 <memcpy+0x88>
c0d00ef6:	2300      	movs	r3, #0
c0d00ef8:	5ccc      	ldrb	r4, [r1, r3]
c0d00efa:	001a      	movs	r2, r3
c0d00efc:	54ec      	strb	r4, [r5, r3]
c0d00efe:	3301      	adds	r3, #1
c0d00f00:	4296      	cmp	r6, r2
c0d00f02:	d1f9      	bne.n	c0d00ef8 <memcpy+0x7c>
c0d00f04:	bc80      	pop	{r7}
c0d00f06:	46b8      	mov	r8, r7
c0d00f08:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f0a:	0005      	movs	r5, r0
c0d00f0c:	1e56      	subs	r6, r2, #1
c0d00f0e:	2a00      	cmp	r2, #0
c0d00f10:	d1f1      	bne.n	c0d00ef6 <memcpy+0x7a>
c0d00f12:	e7f7      	b.n	c0d00f04 <memcpy+0x88>
c0d00f14:	0005      	movs	r5, r0
c0d00f16:	1e56      	subs	r6, r2, #1
c0d00f18:	e7ed      	b.n	c0d00ef6 <memcpy+0x7a>
c0d00f1a:	001a      	movs	r2, r3
c0d00f1c:	e7f6      	b.n	c0d00f0c <memcpy+0x90>
c0d00f1e:	46c0      	nop			; (mov r8, r8)

c0d00f20 <memmove>:
c0d00f20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f22:	4288      	cmp	r0, r1
c0d00f24:	d90a      	bls.n	c0d00f3c <memmove+0x1c>
c0d00f26:	188b      	adds	r3, r1, r2
c0d00f28:	4298      	cmp	r0, r3
c0d00f2a:	d207      	bcs.n	c0d00f3c <memmove+0x1c>
c0d00f2c:	1e53      	subs	r3, r2, #1
c0d00f2e:	2a00      	cmp	r2, #0
c0d00f30:	d003      	beq.n	c0d00f3a <memmove+0x1a>
c0d00f32:	5cca      	ldrb	r2, [r1, r3]
c0d00f34:	54c2      	strb	r2, [r0, r3]
c0d00f36:	3b01      	subs	r3, #1
c0d00f38:	d2fb      	bcs.n	c0d00f32 <memmove+0x12>
c0d00f3a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f3c:	2a0f      	cmp	r2, #15
c0d00f3e:	d80b      	bhi.n	c0d00f58 <memmove+0x38>
c0d00f40:	0005      	movs	r5, r0
c0d00f42:	1e56      	subs	r6, r2, #1
c0d00f44:	2a00      	cmp	r2, #0
c0d00f46:	d0f8      	beq.n	c0d00f3a <memmove+0x1a>
c0d00f48:	2300      	movs	r3, #0
c0d00f4a:	5ccc      	ldrb	r4, [r1, r3]
c0d00f4c:	001a      	movs	r2, r3
c0d00f4e:	54ec      	strb	r4, [r5, r3]
c0d00f50:	3301      	adds	r3, #1
c0d00f52:	4296      	cmp	r6, r2
c0d00f54:	d1f9      	bne.n	c0d00f4a <memmove+0x2a>
c0d00f56:	e7f0      	b.n	c0d00f3a <memmove+0x1a>
c0d00f58:	2703      	movs	r7, #3
c0d00f5a:	000d      	movs	r5, r1
c0d00f5c:	003e      	movs	r6, r7
c0d00f5e:	4305      	orrs	r5, r0
c0d00f60:	000c      	movs	r4, r1
c0d00f62:	0003      	movs	r3, r0
c0d00f64:	402e      	ands	r6, r5
c0d00f66:	422f      	tst	r7, r5
c0d00f68:	d12b      	bne.n	c0d00fc2 <memmove+0xa2>
c0d00f6a:	0015      	movs	r5, r2
c0d00f6c:	3d10      	subs	r5, #16
c0d00f6e:	092d      	lsrs	r5, r5, #4
c0d00f70:	46ac      	mov	ip, r5
c0d00f72:	012f      	lsls	r7, r5, #4
c0d00f74:	183f      	adds	r7, r7, r0
c0d00f76:	6825      	ldr	r5, [r4, #0]
c0d00f78:	601d      	str	r5, [r3, #0]
c0d00f7a:	6865      	ldr	r5, [r4, #4]
c0d00f7c:	605d      	str	r5, [r3, #4]
c0d00f7e:	68a5      	ldr	r5, [r4, #8]
c0d00f80:	609d      	str	r5, [r3, #8]
c0d00f82:	68e5      	ldr	r5, [r4, #12]
c0d00f84:	3410      	adds	r4, #16
c0d00f86:	60dd      	str	r5, [r3, #12]
c0d00f88:	001d      	movs	r5, r3
c0d00f8a:	3310      	adds	r3, #16
c0d00f8c:	42bd      	cmp	r5, r7
c0d00f8e:	d1f2      	bne.n	c0d00f76 <memmove+0x56>
c0d00f90:	4665      	mov	r5, ip
c0d00f92:	230f      	movs	r3, #15
c0d00f94:	240c      	movs	r4, #12
c0d00f96:	3501      	adds	r5, #1
c0d00f98:	012d      	lsls	r5, r5, #4
c0d00f9a:	1949      	adds	r1, r1, r5
c0d00f9c:	4013      	ands	r3, r2
c0d00f9e:	1945      	adds	r5, r0, r5
c0d00fa0:	4214      	tst	r4, r2
c0d00fa2:	d011      	beq.n	c0d00fc8 <memmove+0xa8>
c0d00fa4:	598c      	ldr	r4, [r1, r6]
c0d00fa6:	51ac      	str	r4, [r5, r6]
c0d00fa8:	3604      	adds	r6, #4
c0d00faa:	1b9c      	subs	r4, r3, r6
c0d00fac:	2c03      	cmp	r4, #3
c0d00fae:	d8f9      	bhi.n	c0d00fa4 <memmove+0x84>
c0d00fb0:	3b04      	subs	r3, #4
c0d00fb2:	089b      	lsrs	r3, r3, #2
c0d00fb4:	3301      	adds	r3, #1
c0d00fb6:	009b      	lsls	r3, r3, #2
c0d00fb8:	18ed      	adds	r5, r5, r3
c0d00fba:	18c9      	adds	r1, r1, r3
c0d00fbc:	2303      	movs	r3, #3
c0d00fbe:	401a      	ands	r2, r3
c0d00fc0:	e7bf      	b.n	c0d00f42 <memmove+0x22>
c0d00fc2:	0005      	movs	r5, r0
c0d00fc4:	1e56      	subs	r6, r2, #1
c0d00fc6:	e7bf      	b.n	c0d00f48 <memmove+0x28>
c0d00fc8:	001a      	movs	r2, r3
c0d00fca:	e7ba      	b.n	c0d00f42 <memmove+0x22>

c0d00fcc <memset>:
c0d00fcc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00fce:	0005      	movs	r5, r0
c0d00fd0:	0783      	lsls	r3, r0, #30
c0d00fd2:	d049      	beq.n	c0d01068 <memset+0x9c>
c0d00fd4:	1e54      	subs	r4, r2, #1
c0d00fd6:	2a00      	cmp	r2, #0
c0d00fd8:	d045      	beq.n	c0d01066 <memset+0x9a>
c0d00fda:	0003      	movs	r3, r0
c0d00fdc:	2603      	movs	r6, #3
c0d00fde:	b2ca      	uxtb	r2, r1
c0d00fe0:	e002      	b.n	c0d00fe8 <memset+0x1c>
c0d00fe2:	3501      	adds	r5, #1
c0d00fe4:	3c01      	subs	r4, #1
c0d00fe6:	d33e      	bcc.n	c0d01066 <memset+0x9a>
c0d00fe8:	3301      	adds	r3, #1
c0d00fea:	702a      	strb	r2, [r5, #0]
c0d00fec:	4233      	tst	r3, r6
c0d00fee:	d1f8      	bne.n	c0d00fe2 <memset+0x16>
c0d00ff0:	2c03      	cmp	r4, #3
c0d00ff2:	d930      	bls.n	c0d01056 <memset+0x8a>
c0d00ff4:	22ff      	movs	r2, #255	; 0xff
c0d00ff6:	400a      	ands	r2, r1
c0d00ff8:	0215      	lsls	r5, r2, #8
c0d00ffa:	4315      	orrs	r5, r2
c0d00ffc:	042a      	lsls	r2, r5, #16
c0d00ffe:	4315      	orrs	r5, r2
c0d01000:	2c0f      	cmp	r4, #15
c0d01002:	d934      	bls.n	c0d0106e <memset+0xa2>
c0d01004:	0027      	movs	r7, r4
c0d01006:	3f10      	subs	r7, #16
c0d01008:	093f      	lsrs	r7, r7, #4
c0d0100a:	013e      	lsls	r6, r7, #4
c0d0100c:	46b4      	mov	ip, r6
c0d0100e:	001e      	movs	r6, r3
c0d01010:	001a      	movs	r2, r3
c0d01012:	3610      	adds	r6, #16
c0d01014:	4466      	add	r6, ip
c0d01016:	6015      	str	r5, [r2, #0]
c0d01018:	6055      	str	r5, [r2, #4]
c0d0101a:	6095      	str	r5, [r2, #8]
c0d0101c:	60d5      	str	r5, [r2, #12]
c0d0101e:	3210      	adds	r2, #16
c0d01020:	42b2      	cmp	r2, r6
c0d01022:	d1f8      	bne.n	c0d01016 <memset+0x4a>
c0d01024:	3701      	adds	r7, #1
c0d01026:	013f      	lsls	r7, r7, #4
c0d01028:	19db      	adds	r3, r3, r7
c0d0102a:	270f      	movs	r7, #15
c0d0102c:	220c      	movs	r2, #12
c0d0102e:	4027      	ands	r7, r4
c0d01030:	4022      	ands	r2, r4
c0d01032:	003c      	movs	r4, r7
c0d01034:	2a00      	cmp	r2, #0
c0d01036:	d00e      	beq.n	c0d01056 <memset+0x8a>
c0d01038:	1f3e      	subs	r6, r7, #4
c0d0103a:	08b6      	lsrs	r6, r6, #2
c0d0103c:	00b4      	lsls	r4, r6, #2
c0d0103e:	46a4      	mov	ip, r4
c0d01040:	001a      	movs	r2, r3
c0d01042:	1d1c      	adds	r4, r3, #4
c0d01044:	4464      	add	r4, ip
c0d01046:	c220      	stmia	r2!, {r5}
c0d01048:	42a2      	cmp	r2, r4
c0d0104a:	d1fc      	bne.n	c0d01046 <memset+0x7a>
c0d0104c:	2403      	movs	r4, #3
c0d0104e:	3601      	adds	r6, #1
c0d01050:	00b6      	lsls	r6, r6, #2
c0d01052:	199b      	adds	r3, r3, r6
c0d01054:	403c      	ands	r4, r7
c0d01056:	2c00      	cmp	r4, #0
c0d01058:	d005      	beq.n	c0d01066 <memset+0x9a>
c0d0105a:	b2c9      	uxtb	r1, r1
c0d0105c:	191c      	adds	r4, r3, r4
c0d0105e:	7019      	strb	r1, [r3, #0]
c0d01060:	3301      	adds	r3, #1
c0d01062:	429c      	cmp	r4, r3
c0d01064:	d1fb      	bne.n	c0d0105e <memset+0x92>
c0d01066:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01068:	0003      	movs	r3, r0
c0d0106a:	0014      	movs	r4, r2
c0d0106c:	e7c0      	b.n	c0d00ff0 <memset+0x24>
c0d0106e:	0027      	movs	r7, r4
c0d01070:	e7e2      	b.n	c0d01038 <memset+0x6c>
c0d01072:	46c0      	nop			; (mov r8, r8)

c0d01074 <setjmp>:
c0d01074:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d01076:	4641      	mov	r1, r8
c0d01078:	464a      	mov	r2, r9
c0d0107a:	4653      	mov	r3, sl
c0d0107c:	465c      	mov	r4, fp
c0d0107e:	466d      	mov	r5, sp
c0d01080:	4676      	mov	r6, lr
c0d01082:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d01084:	3828      	subs	r0, #40	; 0x28
c0d01086:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d01088:	2000      	movs	r0, #0
c0d0108a:	4770      	bx	lr

c0d0108c <longjmp>:
c0d0108c:	3010      	adds	r0, #16
c0d0108e:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d01090:	4690      	mov	r8, r2
c0d01092:	4699      	mov	r9, r3
c0d01094:	46a2      	mov	sl, r4
c0d01096:	46ab      	mov	fp, r5
c0d01098:	46b5      	mov	sp, r6
c0d0109a:	c808      	ldmia	r0!, {r3}
c0d0109c:	3828      	subs	r0, #40	; 0x28
c0d0109e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d010a0:	0008      	movs	r0, r1
c0d010a2:	d100      	bne.n	c0d010a6 <longjmp+0x1a>
c0d010a4:	2001      	movs	r0, #1
c0d010a6:	4718      	bx	r3

c0d010a8 <strlcpy>:
c0d010a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d010aa:	0005      	movs	r5, r0
c0d010ac:	2a00      	cmp	r2, #0
c0d010ae:	d013      	beq.n	c0d010d8 <strlcpy+0x30>
c0d010b0:	1e50      	subs	r0, r2, #1
c0d010b2:	2a01      	cmp	r2, #1
c0d010b4:	d019      	beq.n	c0d010ea <strlcpy+0x42>
c0d010b6:	2300      	movs	r3, #0
c0d010b8:	1c4f      	adds	r7, r1, #1
c0d010ba:	1c6e      	adds	r6, r5, #1
c0d010bc:	e002      	b.n	c0d010c4 <strlcpy+0x1c>
c0d010be:	3301      	adds	r3, #1
c0d010c0:	4298      	cmp	r0, r3
c0d010c2:	d016      	beq.n	c0d010f2 <strlcpy+0x4a>
c0d010c4:	18f4      	adds	r4, r6, r3
c0d010c6:	46a4      	mov	ip, r4
c0d010c8:	5ccc      	ldrb	r4, [r1, r3]
c0d010ca:	18fa      	adds	r2, r7, r3
c0d010cc:	54ec      	strb	r4, [r5, r3]
c0d010ce:	2c00      	cmp	r4, #0
c0d010d0:	d1f5      	bne.n	c0d010be <strlcpy+0x16>
c0d010d2:	1a50      	subs	r0, r2, r1
c0d010d4:	3801      	subs	r0, #1
c0d010d6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d010d8:	000a      	movs	r2, r1
c0d010da:	0013      	movs	r3, r2
c0d010dc:	3301      	adds	r3, #1
c0d010de:	1e5c      	subs	r4, r3, #1
c0d010e0:	7824      	ldrb	r4, [r4, #0]
c0d010e2:	001a      	movs	r2, r3
c0d010e4:	2c00      	cmp	r4, #0
c0d010e6:	d1f9      	bne.n	c0d010dc <strlcpy+0x34>
c0d010e8:	e7f3      	b.n	c0d010d2 <strlcpy+0x2a>
c0d010ea:	000a      	movs	r2, r1
c0d010ec:	2300      	movs	r3, #0
c0d010ee:	702b      	strb	r3, [r5, #0]
c0d010f0:	e7f3      	b.n	c0d010da <strlcpy+0x32>
c0d010f2:	4665      	mov	r5, ip
c0d010f4:	e7fa      	b.n	c0d010ec <strlcpy+0x44>
c0d010f6:	46c0      	nop			; (mov r8, r8)

c0d010f8 <strnlen>:
c0d010f8:	b510      	push	{r4, lr}
c0d010fa:	0003      	movs	r3, r0
c0d010fc:	1844      	adds	r4, r0, r1
c0d010fe:	2900      	cmp	r1, #0
c0d01100:	d103      	bne.n	c0d0110a <strnlen+0x12>
c0d01102:	e009      	b.n	c0d01118 <strnlen+0x20>
c0d01104:	3301      	adds	r3, #1
c0d01106:	429c      	cmp	r4, r3
c0d01108:	d004      	beq.n	c0d01114 <strnlen+0x1c>
c0d0110a:	781a      	ldrb	r2, [r3, #0]
c0d0110c:	2a00      	cmp	r2, #0
c0d0110e:	d1f9      	bne.n	c0d01104 <strnlen+0xc>
c0d01110:	1a18      	subs	r0, r3, r0
c0d01112:	bd10      	pop	{r4, pc}
c0d01114:	1a20      	subs	r0, r4, r0
c0d01116:	e7fc      	b.n	c0d01112 <strnlen+0x1a>
c0d01118:	2000      	movs	r0, #0
c0d0111a:	e7fa      	b.n	c0d01112 <strnlen+0x1a>

c0d0111c <COWSWAP_DEPOSIT_SELECTOR>:
c0d0111c:	e3d0 b00d                                   ....

c0d01120 <COWSWAP_SELECTORS>:
c0d01120:	111c c0d0                                   ....

c0d01124 <PLUGIN_ETH_ADDRESS>:
c0d01124:	eeee eeee eeee eeee eeee eeee eeee eeee     ................
c0d01134:	eeee eeee 7830                               ....0x.

c0d0113b <HEXDIGITS>:
c0d0113b:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef
c0d0114b:	4500 5252 524f 3000 5300 7465 6974 676e     .ERROR.0.Setting
c0d0115b:	6120 6464 6572 7373 7320 6e65 2074 6f74      address sent to
c0d0116b:	203a 5300 7465 6974 676e 6120 6464 6572     : .Setting addre
c0d0117b:	7373 7220 6365 6965 6576 2064 6f74 203a     ss received to: 
c0d0118b:	4300 6e6f 6574 7478 6e20 746f 7620 6c61     .Context not val
c0d0119b:	6469 000a 3025 7832 4d00 7369 6973 676e     id..%02x.Missing
c0d011ab:	7320 6c65 6365 6f74 4972 646e 7865 000a      selectorIndex..
c0d011bb:	6c50 6775 6e69 7020 6f72 6976 6564 7020     Plugin provide p
c0d011cb:	7261 6d61 7465 7265 203a 6f00 6666 6573     arameter: .offse
c0d011db:	3a74 2520 2c64 6320 6568 6b63 6f70 6e69     t: %d, checkpoin
c0d011eb:	3a74 2520 2c64 7020 7261 6d61 7465 7265     t: %d, parameter
c0d011fb:	664f 7366 7465 203a 6425 000a 6553 656c     Offset: %d..Sele
c0d0120b:	7463 726f 4920 646e 7865 2520 2064 6f6e     ctor Index %d no
c0d0121b:	2074 7573 7070 726f 6574 0a64 5000 7261     t supported..Par
c0d0122b:	6d61 6e20 746f 7320 7075 6f70 7472 6465     am not supported
c0d0123b:	000a 6c50 6775 6e69 7020 6f72 6976 6564     ..Plugin provide
c0d0124b:	7420 6b6f 6e65 2073 203a 7830 7025 202c      tokens : 0x%p, 
c0d0125b:	7830 7025 000a 6f43 2057 7753 7061 4400     0x%p..CoW Swap.D
c0d0126b:	7065 736f 7469 5300 6c65 6365 6f74 2072     eposit.Selector 
c0d0127b:	6e49 6564 2078 253a 2064 6f6e 2074 7573     Index :%d not su
c0d0128b:	7070 726f 6574 0a64 5200 6365 6965 6576     pported..Receive
c0d0129b:	2064 6e61 6920 766e 6c61 6469 7320 7263     d an invalid scr
c0d012ab:	6565 496e 646e 7865 2520 0a64 4100 4f4d     eenIndex %d..AMO
c0d012bb:	4e55 2054 4553 544e 3a31 2520 0a73 5300     UNT SENT1: %s..S
c0d012cb:	6e65 0064 6e55 6168 646e 656c 2064 6573     end.Unhandled se
c0d012db:	656c 7463 726f 4920 646e 7865 203a 6425     lector Index: %d
c0d012eb:	000a 4d41 554f 544e 5320 4e45 3a54 2520     ..AMOUNT SENT: %
c0d012fb:	0a73 4800 6e61 6c64 6e69 2067 656d 7373     s..Handling mess
c0d0130b:	6761 2065 6425 000a 4c53 3149 2520 0a64     age %d..SLI1 %d.
c0d0131b:	5300 494c 2032 6425 000a 4c53 3349 2520     .SLI2 %d..SLI3 %
c0d0132b:	0a64 5300 494c 2034 6425 000a 4c53 3549     d..SLI4 %d..SLI5
c0d0133b:	2520 0a64 5300 494c 2036 6425 000a 6e55      %d..SLI6 %d..Un
c0d0134b:	6168 646e 656c 2064 656d 7373 6761 2065     handled message 
c0d0135b:	6425 000a 7445 6568 6572 6d75 4500 6378     %d..Ethereum.Exc
c0d0136b:	7065 6974 6e6f 3020 2578 2078 6163 6775     eption 0x%x caug
c0d0137b:	7468 000a 7865 6563 7470 6f69 5b6e 6425     ht..exception[%d
c0d0138b:	3a5d 4c20 3d52 7830 3025 5838 000a          ]: LR=0x%08X..

c0d01399 <g_pcHex>:
c0d01399:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef

c0d013a9 <g_pcHex_cap>:
c0d013a9:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF

c0d013b9 <NULL_ETH_ADDRESS>:
	...

c0d013d0 <_etext>:
	...
