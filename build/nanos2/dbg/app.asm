
build/nanos2/bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0de0000 <main>:
    libcall_params[1] = 0x100;
    libcall_params[2] = RUN_APPLICATION;
    os_lib_call((unsigned int *) &libcall_params);
}

__attribute__((section(".boot"))) int main(int arg0) {
c0de0000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de0002:	b08f      	sub	sp, #60	; 0x3c
c0de0004:	4605      	mov	r5, r0
    // exit critical section
    __asm volatile("cpsie i");
c0de0006:	b662      	cpsie	i

    // ensure exception will work as planned
    os_boot();
c0de0008:	f000 fc5e 	bl	c0de08c8 <os_boot>
c0de000c:	466c      	mov	r4, sp

    BEGIN_TRY {
        TRY {
c0de000e:	4620      	mov	r0, r4
c0de0010:	f000 fee8 	bl	c0de0de4 <setjmp>
c0de0014:	b287      	uxth	r7, r0
c0de0016:	f8ad 002c 	strh.w	r0, [sp, #44]	; 0x2c
c0de001a:	b1d7      	cbz	r7, c0de0052 <main+0x52>
                    dispatch_plugin_calls(args[0], (void *) args[1]);
                }
                os_lib_end();
            }
        }
        CATCH_OTHER(e) {
c0de001c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0de001e:	2100      	movs	r1, #0
c0de0020:	463e      	mov	r6, r7
c0de0022:	f8ad 102c 	strh.w	r1, [sp, #44]	; 0x2c
c0de0026:	f000 fe83 	bl	c0de0d30 <try_context_set>
c0de002a:	f246 5002 	movw	r0, #25858	; 0x6502
            switch (e) {
c0de002e:	4287      	cmp	r7, r0
c0de0030:	d001      	beq.n	c0de0036 <main+0x36>
c0de0032:	2f07      	cmp	r7, #7
c0de0034:	d107      	bne.n	c0de0046 <main+0x46>
    switch (args[0]) {
c0de0036:	6828      	ldr	r0, [r5, #0]
c0de0038:	f5b0 7f83 	cmp.w	r0, #262	; 0x106
c0de003c:	d103      	bne.n	c0de0046 <main+0x46>
            ((ethQueryContractUI_t *) args[1])->result = ETH_PLUGIN_RESULT_ERROR;
c0de003e:	6868      	ldr	r0, [r5, #4]
c0de0040:	2100      	movs	r1, #0
c0de0042:	f880 1034 	strb.w	r1, [r0, #52]	; 0x34
                    handle_query_ui_exception((unsigned int *) arg0);
                    break;
                default:
                    break;
            }
            PRINTF("Exception 0x%x caught\n", e);
c0de0046:	481d      	ldr	r0, [pc, #116]	; (c0de00bc <main+0xbc>)
c0de0048:	4631      	mov	r1, r6
c0de004a:	4478      	add	r0, pc
c0de004c:	f000 fc64 	bl	c0de0918 <mcu_usb_printf>
c0de0050:	e012      	b.n	c0de0078 <main+0x78>
c0de0052:	4668      	mov	r0, sp
        TRY {
c0de0054:	f000 fe6c 	bl	c0de0d30 <try_context_set>
c0de0058:	900a      	str	r0, [sp, #40]	; 0x28
// get API level
SYSCALL unsigned int get_api_level(void);

#ifndef HAVE_BOLOS
static inline void check_api_level(unsigned int apiLevel) {
  if (apiLevel < get_api_level()) {
c0de005a:	f000 fe22 	bl	c0de0ca2 <get_api_level>
c0de005e:	280d      	cmp	r0, #13
c0de0060:	d227      	bcs.n	c0de00b2 <main+0xb2>
            if (!arg0) {
c0de0062:	b1c5      	cbz	r5, c0de0096 <main+0x96>
                if (args[0] != ETH_PLUGIN_CHECK_PRESENCE) {
c0de0064:	6828      	ldr	r0, [r5, #0]
c0de0066:	f240 11ff 	movw	r1, #511	; 0x1ff
c0de006a:	4288      	cmp	r0, r1
c0de006c:	d002      	beq.n	c0de0074 <main+0x74>
                    dispatch_plugin_calls(args[0], (void *) args[1]);
c0de006e:	6869      	ldr	r1, [r5, #4]
c0de0070:	f000 fbb2 	bl	c0de07d8 <dispatch_plugin_calls>
                os_lib_end();
c0de0074:	f000 fe2e 	bl	c0de0cd4 <os_lib_end>
        }
        FINALLY {
c0de0078:	f000 fe50 	bl	c0de0d1c <try_context_get>
c0de007c:	42a0      	cmp	r0, r4
c0de007e:	d102      	bne.n	c0de0086 <main+0x86>
c0de0080:	980a      	ldr	r0, [sp, #40]	; 0x28
c0de0082:	f000 fe55 	bl	c0de0d30 <try_context_set>
            // Call `os_lib_end`, go back to the ethereum app.
            os_lib_end();
c0de0086:	f000 fe25 	bl	c0de0cd4 <os_lib_end>
        }
    }
    END_TRY;
c0de008a:	f8bd 002c 	ldrh.w	r0, [sp, #44]	; 0x2c
c0de008e:	b970      	cbnz	r0, c0de00ae <main+0xae>
c0de0090:	2000      	movs	r0, #0

    return 0;
}
c0de0092:	b00f      	add	sp, #60	; 0x3c
c0de0094:	bdf0      	pop	{r4, r5, r6, r7, pc}
    libcall_params[0] = (unsigned int) "Ethereum";
c0de0096:	4808      	ldr	r0, [pc, #32]	; (c0de00b8 <main+0xb8>)
c0de0098:	4478      	add	r0, pc
c0de009a:	900c      	str	r0, [sp, #48]	; 0x30
c0de009c:	f44f 7080 	mov.w	r0, #256	; 0x100
    libcall_params[1] = 0x100;
c0de00a0:	900d      	str	r0, [sp, #52]	; 0x34
c0de00a2:	2001      	movs	r0, #1
    libcall_params[2] = RUN_APPLICATION;
c0de00a4:	900e      	str	r0, [sp, #56]	; 0x38
c0de00a6:	a80c      	add	r0, sp, #48	; 0x30
    os_lib_call((unsigned int *) &libcall_params);
c0de00a8:	f000 fe06 	bl	c0de0cb8 <os_lib_call>
c0de00ac:	e7f0      	b.n	c0de0090 <main+0x90>
    END_TRY;
c0de00ae:	f000 fc0f 	bl	c0de08d0 <os_longjmp>
c0de00b2:	20ff      	movs	r0, #255	; 0xff
    os_sched_exit(-1);
c0de00b4:	f000 fe18 	bl	c0de0ce8 <os_sched_exit>
c0de00b8:	00000e27 	.word	0x00000e27
c0de00bc:	00000e9e 	.word	0x00000e9e

c0de00c0 <adjustDecimals>:

bool adjustDecimals(const char *src,
                    size_t srcLength,
                    char *target,
                    size_t targetLength,
                    uint8_t decimals) {
c0de00c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de00c2:	b081      	sub	sp, #4
c0de00c4:	4617      	mov	r7, r2
c0de00c6:	460e      	mov	r6, r1
    uint32_t startOffset;
    uint32_t lastZeroOffset = 0;
    uint32_t offset = 0;
    if ((srcLength == 1) && (*src == '0')) {
c0de00c8:	2901      	cmp	r1, #1
c0de00ca:	4605      	mov	r5, r0
c0de00cc:	d10a      	bne.n	c0de00e4 <adjustDecimals+0x24>
c0de00ce:	7828      	ldrb	r0, [r5, #0]
c0de00d0:	2830      	cmp	r0, #48	; 0x30
c0de00d2:	d107      	bne.n	c0de00e4 <adjustDecimals+0x24>
        if (targetLength < 2) {
c0de00d4:	2b02      	cmp	r3, #2
c0de00d6:	f04f 0000 	mov.w	r0, #0
c0de00da:	d363      	bcc.n	c0de01a4 <adjustDecimals+0xe4>
c0de00dc:	2130      	movs	r1, #48	; 0x30
            return false;
        }
        target[0] = '0';
c0de00de:	7039      	strb	r1, [r7, #0]
        target[1] = '\0';
c0de00e0:	7078      	strb	r0, [r7, #1]
c0de00e2:	e05e      	b.n	c0de01a2 <adjustDecimals+0xe2>
c0de00e4:	9906      	ldr	r1, [sp, #24]
        return true;
    }
    if (srcLength <= decimals) {
c0de00e6:	42b1      	cmp	r1, r6
c0de00e8:	d223      	bcs.n	c0de0132 <adjustDecimals+0x72>
        }
        target[offset] = '\0';
    } else {
        uint32_t sourceOffset = 0;
        uint32_t delta = srcLength - decimals;
        if (targetLength < srcLength + 1 + 1) {
c0de00ea:	1cb0      	adds	r0, r6, #2
c0de00ec:	4298      	cmp	r0, r3
c0de00ee:	d823      	bhi.n	c0de0138 <adjustDecimals+0x78>
c0de00f0:	ebb6 0c01 	subs.w	ip, r6, r1
            return false;
        }
        while (offset < delta) {
c0de00f4:	d008      	beq.n	c0de0108 <adjustDecimals+0x48>
c0de00f6:	4628      	mov	r0, r5
c0de00f8:	4663      	mov	r3, ip
c0de00fa:	463c      	mov	r4, r7
            target[offset++] = src[sourceOffset++];
c0de00fc:	f810 2b01 	ldrb.w	r2, [r0], #1
        while (offset < delta) {
c0de0100:	3b01      	subs	r3, #1
            target[offset++] = src[sourceOffset++];
c0de0102:	f804 2b01 	strb.w	r2, [r4], #1
        while (offset < delta) {
c0de0106:	d1f9      	bne.n	c0de00fc <adjustDecimals+0x3c>
        }
        if (decimals != 0) {
c0de0108:	2900      	cmp	r1, #0
c0de010a:	bf0f      	iteee	eq
c0de010c:	4660      	moveq	r0, ip
            target[offset++] = '.';
c0de010e:	f10c 0001 	addne.w	r0, ip, #1
c0de0112:	222e      	movne	r2, #46	; 0x2e
c0de0114:	f807 200c 	strbne.w	r2, [r7, ip]
        }
        startOffset = offset;
        while (sourceOffset < srcLength) {
c0de0118:	45b4      	cmp	ip, r6
c0de011a:	d228      	bcs.n	c0de016e <adjustDecimals+0xae>
c0de011c:	eb05 020c 	add.w	r2, r5, ip
c0de0120:	183e      	adds	r6, r7, r0
c0de0122:	2300      	movs	r3, #0
            target[offset++] = src[sourceOffset++];
c0de0124:	5cd5      	ldrb	r5, [r2, r3]
c0de0126:	54f5      	strb	r5, [r6, r3]
        while (sourceOffset < srcLength) {
c0de0128:	3301      	adds	r3, #1
c0de012a:	4299      	cmp	r1, r3
c0de012c:	d1fa      	bne.n	c0de0124 <adjustDecimals+0x64>
c0de012e:	18c1      	adds	r1, r0, r3
c0de0130:	e01e      	b.n	c0de0170 <adjustDecimals+0xb0>
        if (targetLength < srcLength + 1 + 2 + delta) {
c0de0132:	1cc8      	adds	r0, r1, #3
c0de0134:	4298      	cmp	r0, r3
c0de0136:	d901      	bls.n	c0de013c <adjustDecimals+0x7c>
c0de0138:	2000      	movs	r0, #0
c0de013a:	e033      	b.n	c0de01a4 <adjustDecimals+0xe4>
c0de013c:	2030      	movs	r0, #48	; 0x30
c0de013e:	1b8c      	subs	r4, r1, r6
        target[offset++] = '0';
c0de0140:	7038      	strb	r0, [r7, #0]
c0de0142:	f04f 002e 	mov.w	r0, #46	; 0x2e
        target[offset++] = '.';
c0de0146:	7078      	strb	r0, [r7, #1]
        for (uint32_t i = 0; i < delta; i++) {
c0de0148:	d006      	beq.n	c0de0158 <adjustDecimals+0x98>
c0de014a:	1cb8      	adds	r0, r7, #2
            target[offset++] = '0';
c0de014c:	4621      	mov	r1, r4
c0de014e:	2230      	movs	r2, #48	; 0x30
c0de0150:	f000 fe03 	bl	c0de0d5a <__aeabi_memset>
        for (uint32_t i = 0; i < delta; i++) {
c0de0154:	1ca0      	adds	r0, r4, #2
c0de0156:	e000      	b.n	c0de015a <adjustDecimals+0x9a>
c0de0158:	2002      	movs	r0, #2
        for (uint32_t i = 0; i < srcLength; i++) {
c0de015a:	b146      	cbz	r6, c0de016e <adjustDecimals+0xae>
c0de015c:	183a      	adds	r2, r7, r0
c0de015e:	2100      	movs	r1, #0
            target[offset++] = src[i];
c0de0160:	5c6b      	ldrb	r3, [r5, r1]
c0de0162:	5453      	strb	r3, [r2, r1]
        for (uint32_t i = 0; i < srcLength; i++) {
c0de0164:	3101      	adds	r1, #1
c0de0166:	428e      	cmp	r6, r1
c0de0168:	d1fa      	bne.n	c0de0160 <adjustDecimals+0xa0>
c0de016a:	4401      	add	r1, r0
c0de016c:	e000      	b.n	c0de0170 <adjustDecimals+0xb0>
c0de016e:	4601      	mov	r1, r0
c0de0170:	2300      	movs	r3, #0
        }
        target[offset] = '\0';
    }
    for (uint32_t i = startOffset; i < offset; i++) {
c0de0172:	4288      	cmp	r0, r1
c0de0174:	547b      	strb	r3, [r7, r1]
c0de0176:	d214      	bcs.n	c0de01a2 <adjustDecimals+0xe2>
c0de0178:	2200      	movs	r2, #0
c0de017a:	bf00      	nop
        if (target[i] == '0') {
c0de017c:	5c3e      	ldrb	r6, [r7, r0]
c0de017e:	2a00      	cmp	r2, #0
c0de0180:	bf08      	it	eq
c0de0182:	4602      	moveq	r2, r0
c0de0184:	2e30      	cmp	r6, #48	; 0x30
    for (uint32_t i = startOffset; i < offset; i++) {
c0de0186:	f100 0001 	add.w	r0, r0, #1
        if (target[i] == '0') {
c0de018a:	bf18      	it	ne
c0de018c:	461a      	movne	r2, r3
    for (uint32_t i = startOffset; i < offset; i++) {
c0de018e:	4281      	cmp	r1, r0
c0de0190:	d1f4      	bne.n	c0de017c <adjustDecimals+0xbc>
            }
        } else {
            lastZeroOffset = 0;
        }
    }
    if (lastZeroOffset != 0) {
c0de0192:	b132      	cbz	r2, c0de01a2 <adjustDecimals+0xe2>
        target[lastZeroOffset] = '\0';
        if (target[lastZeroOffset - 1] == '.') {
c0de0194:	1e50      	subs	r0, r2, #1
c0de0196:	5c3b      	ldrb	r3, [r7, r0]
c0de0198:	2100      	movs	r1, #0
c0de019a:	2b2e      	cmp	r3, #46	; 0x2e
        target[lastZeroOffset] = '\0';
c0de019c:	54b9      	strb	r1, [r7, r2]
            target[lastZeroOffset - 1] = '\0';
c0de019e:	bf08      	it	eq
c0de01a0:	5439      	strbeq	r1, [r7, r0]
c0de01a2:	2001      	movs	r0, #1
        }
    }
    return true;
}
c0de01a4:	b001      	add	sp, #4
c0de01a6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0de01a8 <uint256_to_decimal>:

bool uint256_to_decimal(const uint8_t *value, size_t value_len, char *out, size_t out_len) {
    if (value_len > INT256_LENGTH) {
c0de01a8:	2920      	cmp	r1, #32
c0de01aa:	bf84      	itt	hi
c0de01ac:	2000      	movhi	r0, #0
        out[pos] = '0' + carry;
    }
    memmove(out, out + pos, out_len - pos);
    out[out_len - pos] = 0;
    return true;
}
c0de01ae:	4770      	bxhi	lr
c0de01b0:	e92d 45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
c0de01b4:	b089      	sub	sp, #36	; 0x24
c0de01b6:	ae01      	add	r6, sp, #4
c0de01b8:	460f      	mov	r7, r1
c0de01ba:	4605      	mov	r5, r0
    uint16_t n[16] = {0};
c0de01bc:	4630      	mov	r0, r6
c0de01be:	2120      	movs	r1, #32
c0de01c0:	4698      	mov	r8, r3
c0de01c2:	4692      	mov	sl, r2
c0de01c4:	f000 fdc2 	bl	c0de0d4c <__aeabi_memclr>
    memcpy((uint8_t *) n + INT256_LENGTH - value_len, value, value_len);
c0de01c8:	1bf0      	subs	r0, r6, r7
c0de01ca:	3020      	adds	r0, #32
c0de01cc:	4629      	mov	r1, r5
c0de01ce:	463a      	mov	r2, r7
c0de01d0:	f000 fdbf 	bl	c0de0d52 <__aeabi_memcpy>
} extraInfo_t;

static __attribute__((no_instrument_function)) inline int allzeroes(void *buf, size_t n) {
    uint8_t *p = (uint8_t *) buf;
    for (size_t i = 0; i < n; ++i) {
        if (p[i]) {
c0de01d4:	f89d 0004 	ldrb.w	r0, [sp, #4]
c0de01d8:	b960      	cbnz	r0, c0de01f4 <uint256_to_decimal+0x4c>
    for (size_t i = 0; i < n; ++i) {
c0de01da:	1c70      	adds	r0, r6, #1
c0de01dc:	2200      	movs	r2, #0
c0de01de:	bf00      	nop
c0de01e0:	4611      	mov	r1, r2
c0de01e2:	2a1f      	cmp	r2, #31
c0de01e4:	d004      	beq.n	c0de01f0 <uint256_to_decimal+0x48>
        if (p[i]) {
c0de01e6:	5c42      	ldrb	r2, [r0, r1]
c0de01e8:	2a00      	cmp	r2, #0
c0de01ea:	f101 0201 	add.w	r2, r1, #1
c0de01ee:	d0f7      	beq.n	c0de01e0 <uint256_to_decimal+0x38>
    if (allzeroes(n, INT256_LENGTH)) {
c0de01f0:	291f      	cmp	r1, #31
c0de01f2:	d241      	bcs.n	c0de0278 <uint256_to_decimal+0xd0>
c0de01f4:	2000      	movs	r0, #0
c0de01f6:	bf00      	nop
        n[i] = __builtin_bswap16(*p++);
c0de01f8:	f836 1010 	ldrh.w	r1, [r6, r0, lsl #1]
c0de01fc:	ba09      	rev	r1, r1
c0de01fe:	0c09      	lsrs	r1, r1, #16
c0de0200:	f826 1010 	strh.w	r1, [r6, r0, lsl #1]
    for (int i = 0; i < 16; i++) {
c0de0204:	3001      	adds	r0, #1
c0de0206:	2810      	cmp	r0, #16
c0de0208:	d1f6      	bne.n	c0de01f8 <uint256_to_decimal+0x50>
c0de020a:	4923      	ldr	r1, [pc, #140]	; (c0de0298 <uint256_to_decimal+0xf0>)
    while (!allzeroes(n, sizeof(n))) {
c0de020c:	1c70      	adds	r0, r6, #1
c0de020e:	4642      	mov	r2, r8
c0de0210:	f89d 3004 	ldrb.w	r3, [sp, #4]
c0de0214:	b953      	cbnz	r3, c0de022c <uint256_to_decimal+0x84>
c0de0216:	2700      	movs	r7, #0
c0de0218:	463b      	mov	r3, r7
    for (size_t i = 0; i < n; ++i) {
c0de021a:	2f1f      	cmp	r7, #31
c0de021c:	d004      	beq.n	c0de0228 <uint256_to_decimal+0x80>
        if (p[i]) {
c0de021e:	5cc7      	ldrb	r7, [r0, r3]
c0de0220:	2f00      	cmp	r7, #0
c0de0222:	f103 0701 	add.w	r7, r3, #1
c0de0226:	d0f7      	beq.n	c0de0218 <uint256_to_decimal+0x70>
c0de0228:	2b1e      	cmp	r3, #30
c0de022a:	d819      	bhi.n	c0de0260 <uint256_to_decimal+0xb8>
        if (pos == 0) {
c0de022c:	b33a      	cbz	r2, c0de027e <uint256_to_decimal+0xd6>
c0de022e:	2300      	movs	r3, #0
c0de0230:	2700      	movs	r7, #0
c0de0232:	bf00      	nop
            int rem = ((carry << 16) | n[i]) % 10;
c0de0234:	f836 5013 	ldrh.w	r5, [r6, r3, lsl #1]
c0de0238:	ea45 4707 	orr.w	r7, r5, r7, lsl #16
            n[i] = ((carry << 16) | n[i]) / 10;
c0de023c:	fba7 5401 	umull	r5, r4, r7, r1
c0de0240:	08e5      	lsrs	r5, r4, #3
c0de0242:	eb05 0485 	add.w	r4, r5, r5, lsl #2
c0de0246:	f826 5013 	strh.w	r5, [r6, r3, lsl #1]
        for (int i = 0; i < 16; i++) {
c0de024a:	3301      	adds	r3, #1
c0de024c:	2b10      	cmp	r3, #16
c0de024e:	eba7 0744 	sub.w	r7, r7, r4, lsl #1
c0de0252:	d1ef      	bne.n	c0de0234 <uint256_to_decimal+0x8c>
        pos -= 1;
c0de0254:	3a01      	subs	r2, #1
        out[pos] = '0' + carry;
c0de0256:	f047 0330 	orr.w	r3, r7, #48	; 0x30
c0de025a:	f80a 3002 	strb.w	r3, [sl, r2]
c0de025e:	e7d7      	b.n	c0de0210 <uint256_to_decimal+0x68>
    memmove(out, out + pos, out_len - pos);
c0de0260:	eba8 0502 	sub.w	r5, r8, r2
c0de0264:	eb0a 0102 	add.w	r1, sl, r2
c0de0268:	4650      	mov	r0, sl
c0de026a:	462a      	mov	r2, r5
c0de026c:	f000 fd73 	bl	c0de0d56 <__aeabi_memmove>
c0de0270:	2000      	movs	r0, #0
    out[out_len - pos] = 0;
c0de0272:	f80a 0005 	strb.w	r0, [sl, r5]
c0de0276:	e00a      	b.n	c0de028e <uint256_to_decimal+0xe6>
        if (out_len < 2) {
c0de0278:	f1b8 0f02 	cmp.w	r8, #2
c0de027c:	d201      	bcs.n	c0de0282 <uint256_to_decimal+0xda>
c0de027e:	2000      	movs	r0, #0
c0de0280:	e006      	b.n	c0de0290 <uint256_to_decimal+0xe8>
        strlcpy(out, "0", out_len);
c0de0282:	4906      	ldr	r1, [pc, #24]	; (c0de029c <uint256_to_decimal+0xf4>)
c0de0284:	4650      	mov	r0, sl
c0de0286:	4479      	add	r1, pc
c0de0288:	4642      	mov	r2, r8
c0de028a:	f000 fdb9 	bl	c0de0e00 <strlcpy>
c0de028e:	2001      	movs	r0, #1
c0de0290:	b009      	add	sp, #36	; 0x24
c0de0292:	e8bd 85f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, pc}
c0de0296:	bf00      	nop
c0de0298:	cccccccd 	.word	0xcccccccd
c0de029c:	00000c42 	.word	0x00000c42

c0de02a0 <amountToString>:
void amountToString(const uint8_t *amount,
                    uint8_t amount_size,
                    uint8_t decimals,
                    const char *ticker,
                    char *out_buffer,
                    size_t out_buffer_size) {
c0de02a0:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de02a4:	b09a      	sub	sp, #104	; 0x68
c0de02a6:	ac01      	add	r4, sp, #4
c0de02a8:	460e      	mov	r6, r1
c0de02aa:	4607      	mov	r7, r0
    char tmp_buffer[100] = {0};
c0de02ac:	4620      	mov	r0, r4
c0de02ae:	2164      	movs	r1, #100	; 0x64
c0de02b0:	461d      	mov	r5, r3
c0de02b2:	4690      	mov	r8, r2
c0de02b4:	f000 fd4a 	bl	c0de0d4c <__aeabi_memclr>

    if (uint256_to_decimal(amount, amount_size, tmp_buffer, sizeof(tmp_buffer)) == false) {
c0de02b8:	4638      	mov	r0, r7
c0de02ba:	4631      	mov	r1, r6
c0de02bc:	4622      	mov	r2, r4
c0de02be:	2364      	movs	r3, #100	; 0x64
c0de02c0:	f7ff ff72 	bl	c0de01a8 <uint256_to_decimal>
c0de02c4:	b340      	cbz	r0, c0de0318 <amountToString+0x78>
c0de02c6:	f10d 0a04 	add.w	sl, sp, #4
c0de02ca:	e9dd b722 	ldrd	fp, r7, [sp, #136]	; 0x88
        THROW(EXCEPTION_OVERFLOW);
    }

    uint8_t amount_len = strnlen(tmp_buffer, sizeof(tmp_buffer));
c0de02ce:	4650      	mov	r0, sl
c0de02d0:	2164      	movs	r1, #100	; 0x64
c0de02d2:	f000 fdaa 	bl	c0de0e2a <strnlen>
c0de02d6:	4604      	mov	r4, r0
    uint8_t ticker_len = strnlen(ticker, MAX_TICKER_LEN);
c0de02d8:	4628      	mov	r0, r5
c0de02da:	210c      	movs	r1, #12
c0de02dc:	f000 fda5 	bl	c0de0e2a <strnlen>

    memcpy(out_buffer, ticker, MIN(out_buffer_size, ticker_len));
c0de02e0:	b2c6      	uxtb	r6, r0
c0de02e2:	4632      	mov	r2, r6
c0de02e4:	4658      	mov	r0, fp
c0de02e6:	4629      	mov	r1, r5
c0de02e8:	42be      	cmp	r6, r7
c0de02ea:	bf88      	it	hi
c0de02ec:	463a      	movhi	r2, r7
c0de02ee:	f000 fd30 	bl	c0de0d52 <__aeabi_memcpy>

    if (adjustDecimals(tmp_buffer,
                       amount_len,
                       out_buffer + ticker_len,
                       out_buffer_size - ticker_len - 1,
c0de02f2:	43f0      	mvns	r0, r6
                       amount_len,
c0de02f4:	b2e1      	uxtb	r1, r4
                       out_buffer + ticker_len,
c0de02f6:	eb0b 0206 	add.w	r2, fp, r6
                       out_buffer_size - ticker_len - 1,
c0de02fa:	19c3      	adds	r3, r0, r7
    if (adjustDecimals(tmp_buffer,
c0de02fc:	4650      	mov	r0, sl
c0de02fe:	f8cd 8000 	str.w	r8, [sp]
c0de0302:	f7ff fedd 	bl	c0de00c0 <adjustDecimals>
c0de0306:	b138      	cbz	r0, c0de0318 <amountToString+0x78>
                       decimals) == false) {
        THROW(EXCEPTION_OVERFLOW);
    }

    out_buffer[out_buffer_size - 1] = '\0';
c0de0308:	eb07 000b 	add.w	r0, r7, fp
c0de030c:	2100      	movs	r1, #0
c0de030e:	f800 1c01 	strb.w	r1, [r0, #-1]
}
c0de0312:	b01a      	add	sp, #104	; 0x68
c0de0314:	e8bd 8df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, pc}
c0de0318:	2007      	movs	r0, #7
c0de031a:	f000 fad9 	bl	c0de08d0 <os_longjmp>
	...

c0de0320 <handle_finalize>:
static void received_network_token(cowswap_parameters_t *context) {
    context->decimals_received = WEI_TO_ETHER;
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
}

void handle_finalize(void *parameters) {
c0de0320:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    ethPluginFinalize_t *msg = (ethPluginFinalize_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0de0324:	6887      	ldr	r7, [r0, #8]
c0de0326:	4680      	mov	r8, r0
    
    if (context->valid) {
c0de0328:	f897 0086 	ldrb.w	r0, [r7, #134]	; 0x86
c0de032c:	b330      	cbz	r0, c0de037c <handle_finalize+0x5c>
c0de032e:	2002      	movs	r0, #2
        msg->numScreens = 2;
c0de0330:	f888 001d 	strb.w	r0, [r8, #29]
        if (!ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
c0de0334:	4936      	ldr	r1, [pc, #216]	; (c0de0410 <handle_finalize+0xf0>)
c0de0336:	f107 0540 	add.w	r5, r7, #64	; 0x40
c0de033a:	4479      	add	r1, pc
c0de033c:	4628      	mov	r0, r5
c0de033e:	2214      	movs	r2, #20
c0de0340:	f000 fd10 	bl	c0de0d64 <memcmp>
c0de0344:	b300      	cbz	r0, c0de0388 <handle_finalize+0x68>
c0de0346:	4933      	ldr	r1, [pc, #204]	; (c0de0414 <handle_finalize+0xf4>)
c0de0348:	4628      	mov	r0, r5
c0de034a:	4479      	add	r1, pc
c0de034c:	2214      	movs	r2, #20
c0de034e:	f000 fd09 	bl	c0de0d64 <memcmp>
c0de0352:	b1c8      	cbz	r0, c0de0388 <handle_finalize+0x68>
void handle_query_contract_id(void *parameters);

static inline void printf_hex_array(const char *title __attribute__((unused)),
                                    size_t len __attribute__((unused)),
                                    const uint8_t *data __attribute__((unused))) {
    PRINTF(title);
c0de0354:	4830      	ldr	r0, [pc, #192]	; (c0de0418 <handle_finalize+0xf8>)
c0de0356:	4478      	add	r0, pc
c0de0358:	f000 fade 	bl	c0de0918 <mcu_usb_printf>
c0de035c:	4e2f      	ldr	r6, [pc, #188]	; (c0de041c <handle_finalize+0xfc>)
c0de035e:	2400      	movs	r4, #0
c0de0360:	447e      	add	r6, pc
c0de0362:	bf00      	nop
    for (size_t i = 0; i < len; ++i) {
        PRINTF("%02x", data[i]);
c0de0364:	5d29      	ldrb	r1, [r5, r4]
c0de0366:	4630      	mov	r0, r6
c0de0368:	f000 fad6 	bl	c0de0918 <mcu_usb_printf>
    for (size_t i = 0; i < len; ++i) {
c0de036c:	3401      	adds	r4, #1
c0de036e:	2c14      	cmp	r4, #20
c0de0370:	d1f8      	bne.n	c0de0364 <handle_finalize+0x44>
    };
    PRINTF("\n");
c0de0372:	482b      	ldr	r0, [pc, #172]	; (c0de0420 <handle_finalize+0x100>)
c0de0374:	4478      	add	r0, pc
c0de0376:	f000 facf 	bl	c0de0918 <mcu_usb_printf>
c0de037a:	e00f      	b.n	c0de039c <handle_finalize+0x7c>
        }

        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;
    } else {
        PRINTF("Context not valid\n");
c0de037c:	482e      	ldr	r0, [pc, #184]	; (c0de0438 <handle_finalize+0x118>)
c0de037e:	4478      	add	r0, pc
c0de0380:	f000 faca 	bl	c0de0918 <mcu_usb_printf>
c0de0384:	2006      	movs	r0, #6
c0de0386:	e03f      	b.n	c0de0408 <handle_finalize+0xe8>
    context->tokens_found |= TOKEN_SENT_FOUND;
c0de0388:	f897 1085 	ldrb.w	r1, [r7, #133]	; 0x85
c0de038c:	2012      	movs	r0, #18
    context->decimals_sent = WEI_TO_ETHER;
c0de038e:	f887 0087 	strb.w	r0, [r7, #135]	; 0x87
    context->tokens_found |= TOKEN_SENT_FOUND;
c0de0392:	f041 0001 	orr.w	r0, r1, #1
c0de0396:	2500      	movs	r5, #0
c0de0398:	f887 0085 	strb.w	r0, [r7, #133]	; 0x85
c0de039c:	f8c8 500c 	str.w	r5, [r8, #12]
        if (!ADDRESS_IS_NETWORK_TOKEN(context->contract_address_received)) {
c0de03a0:	4920      	ldr	r1, [pc, #128]	; (c0de0424 <handle_finalize+0x104>)
c0de03a2:	f107 0554 	add.w	r5, r7, #84	; 0x54
c0de03a6:	4479      	add	r1, pc
c0de03a8:	4628      	mov	r0, r5
c0de03aa:	2214      	movs	r2, #20
c0de03ac:	f000 fcda 	bl	c0de0d64 <memcmp>
c0de03b0:	b1d0      	cbz	r0, c0de03e8 <handle_finalize+0xc8>
c0de03b2:	491d      	ldr	r1, [pc, #116]	; (c0de0428 <handle_finalize+0x108>)
c0de03b4:	4628      	mov	r0, r5
c0de03b6:	4479      	add	r1, pc
c0de03b8:	2214      	movs	r2, #20
c0de03ba:	f000 fcd3 	bl	c0de0d64 <memcmp>
c0de03be:	b198      	cbz	r0, c0de03e8 <handle_finalize+0xc8>
    PRINTF(title);
c0de03c0:	481a      	ldr	r0, [pc, #104]	; (c0de042c <handle_finalize+0x10c>)
c0de03c2:	4478      	add	r0, pc
c0de03c4:	f000 faa8 	bl	c0de0918 <mcu_usb_printf>
c0de03c8:	4e19      	ldr	r6, [pc, #100]	; (c0de0430 <handle_finalize+0x110>)
c0de03ca:	2400      	movs	r4, #0
c0de03cc:	447e      	add	r6, pc
c0de03ce:	bf00      	nop
        PRINTF("%02x", data[i]);
c0de03d0:	5d29      	ldrb	r1, [r5, r4]
c0de03d2:	4630      	mov	r0, r6
c0de03d4:	f000 faa0 	bl	c0de0918 <mcu_usb_printf>
    for (size_t i = 0; i < len; ++i) {
c0de03d8:	3401      	adds	r4, #1
c0de03da:	2c14      	cmp	r4, #20
c0de03dc:	d1f8      	bne.n	c0de03d0 <handle_finalize+0xb0>
    PRINTF("\n");
c0de03de:	4815      	ldr	r0, [pc, #84]	; (c0de0434 <handle_finalize+0x114>)
c0de03e0:	4478      	add	r0, pc
c0de03e2:	f000 fa99 	bl	c0de0918 <mcu_usb_printf>
c0de03e6:	e009      	b.n	c0de03fc <handle_finalize+0xdc>
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
c0de03e8:	f897 1085 	ldrb.w	r1, [r7, #133]	; 0x85
c0de03ec:	2012      	movs	r0, #18
    context->decimals_received = WEI_TO_ETHER;
c0de03ee:	f887 0088 	strb.w	r0, [r7, #136]	; 0x88
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
c0de03f2:	f041 0002 	orr.w	r0, r1, #2
c0de03f6:	2500      	movs	r5, #0
c0de03f8:	f887 0085 	strb.w	r0, [r7, #133]	; 0x85
c0de03fc:	2002      	movs	r0, #2
c0de03fe:	f8c8 5010 	str.w	r5, [r8, #16]
        msg->uiType = ETH_UI_TYPE_GENERIC;
c0de0402:	f888 001c 	strb.w	r0, [r8, #28]
c0de0406:	2004      	movs	r0, #4
c0de0408:	f888 001e 	strb.w	r0, [r8, #30]
        msg->result = ETH_PLUGIN_RESULT_FALLBACK;
    }
}
c0de040c:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
c0de0410:	00000b0e 	.word	0x00000b0e
c0de0414:	00000d80 	.word	0x00000d80
c0de0418:	00000c70 	.word	0x00000c70
c0de041c:	00000b51 	.word	0x00000b51
c0de0420:	00000c72 	.word	0x00000c72
c0de0424:	00000aa2 	.word	0x00000aa2
c0de0428:	00000d14 	.word	0x00000d14
c0de042c:	00000b08 	.word	0x00000b08
c0de0430:	00000ae5 	.word	0x00000ae5
c0de0434:	00000c06 	.word	0x00000c06
c0de0438:	00000bc4 	.word	0x00000bc4

c0de043c <handle_init_contract>:
#include "cowswap_plugin.h"

// Called once to init.
void handle_init_contract(void *parameters) {
c0de043c:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
c0de0440:	4604      	mov	r4, r0
    ethPluginInitContract_t *msg = (ethPluginInitContract_t *) parameters;
    PRINTF("int %s\n", msg->interfaceVersion);
c0de0442:	7801      	ldrb	r1, [r0, #0]
c0de0444:	4828      	ldr	r0, [pc, #160]	; (c0de04e8 <handle_init_contract+0xac>)
c0de0446:	4478      	add	r0, pc
c0de0448:	f000 fa66 	bl	c0de0918 <mcu_usb_printf>
    if (msg->interfaceVersion != ETH_PLUGIN_INTERFACE_VERSION_LATEST) {
c0de044c:	7820      	ldrb	r0, [r4, #0]
c0de044e:	2805      	cmp	r0, #5
c0de0450:	d141      	bne.n	c0de04d6 <handle_init_contract+0x9a>
        msg->result = ETH_PLUGIN_RESULT_UNAVAILABLE;
        return;
    }
    PRINTF("l %s\n", msg->pluginContextLength);
c0de0452:	6921      	ldr	r1, [r4, #16]
c0de0454:	4825      	ldr	r0, [pc, #148]	; (c0de04ec <handle_init_contract+0xb0>)
c0de0456:	4478      	add	r0, pc
c0de0458:	f000 fa5e 	bl	c0de0918 <mcu_usb_printf>
    if (msg->pluginContextLength < sizeof(cowswap_parameters_t)) {
c0de045c:	6920      	ldr	r0, [r4, #16]
c0de045e:	288c      	cmp	r0, #140	; 0x8c
c0de0460:	d337      	bcc.n	c0de04d2 <handle_init_contract+0x96>
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0de0462:	f8d4 800c 	ldr.w	r8, [r4, #12]
    memset(context, 0, sizeof(*context));
c0de0466:	218c      	movs	r1, #140	; 0x8c
c0de0468:	4640      	mov	r0, r8
c0de046a:	f000 fc6f 	bl	c0de0d4c <__aeabi_memclr>
c0de046e:	4920      	ldr	r1, [pc, #128]	; (c0de04f0 <handle_init_contract+0xb4>)
c0de0470:	2001      	movs	r0, #1
c0de0472:	4479      	add	r1, pc
c0de0474:	680e      	ldr	r6, [r1, #0]
c0de0476:	2100      	movs	r1, #0
    context->valid = 1;
c0de0478:	f888 0086 	strb.w	r0, [r8, #134]	; 0x86

    // Determine a function to call
    size_t i;
    for (i = 0; i < NUM_COWSWAP_SELECTORS; i++) {
c0de047c:	07c0      	lsls	r0, r0, #31
c0de047e:	460f      	mov	r7, r1
c0de0480:	d01e      	beq.n	c0de04c0 <handle_init_contract+0x84>
        if (memcmp((uint8_t *) PIC(COWSWAP_SELECTORS[i]), msg->selector, SELECTOR_SIZE) == 0) {
c0de0482:	4630      	mov	r0, r6
c0de0484:	f000 fbe8 	bl	c0de0c58 <pic>
c0de0488:	7802      	ldrb	r2, [r0, #0]
c0de048a:	7883      	ldrb	r3, [r0, #2]
c0de048c:	78c5      	ldrb	r5, [r0, #3]
c0de048e:	7840      	ldrb	r0, [r0, #1]
c0de0490:	6961      	ldr	r1, [r4, #20]
c0de0492:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
c0de0496:	ea42 2000 	orr.w	r0, r2, r0, lsl #8
c0de049a:	ea40 4003 	orr.w	r0, r0, r3, lsl #16
c0de049e:	780a      	ldrb	r2, [r1, #0]
c0de04a0:	788b      	ldrb	r3, [r1, #2]
c0de04a2:	78cd      	ldrb	r5, [r1, #3]
c0de04a4:	7849      	ldrb	r1, [r1, #1]
c0de04a6:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
c0de04aa:	ea42 2101 	orr.w	r1, r2, r1, lsl #8
c0de04ae:	ea41 4203 	orr.w	r2, r1, r3, lsl #16
c0de04b2:	2101      	movs	r1, #1
c0de04b4:	4290      	cmp	r0, r2
c0de04b6:	f04f 0000 	mov.w	r0, #0
c0de04ba:	d1df      	bne.n	c0de047c <handle_init_contract+0x40>
            context->selectorIndex = i;
c0de04bc:	f888 0089 	strb.w	r0, [r8, #137]	; 0x89
            break;
        }
    }

    if (i == NUM_COWSWAP_SELECTORS) {
c0de04c0:	07f8      	lsls	r0, r7, #31
c0de04c2:	d106      	bne.n	c0de04d2 <handle_init_contract+0x96>
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    // Set `next_param` to be the first field we expect to parse.
    switch (context->selectorIndex) {
c0de04c4:	f898 0089 	ldrb.w	r0, [r8, #137]	; 0x89
c0de04c8:	b148      	cbz	r0, c0de04de <handle_init_contract+0xa2>
        PRINTF("switch0 %d\n", context->selectorIndex);
        case DEPOSIT:
            context->next_param = NONE;
            break;
        default:
            PRINTF("Missing selectorIndex\n");
c0de04ca:	480a      	ldr	r0, [pc, #40]	; (c0de04f4 <handle_init_contract+0xb8>)
c0de04cc:	4478      	add	r0, pc
c0de04ce:	f000 fa23 	bl	c0de0918 <mcu_usb_printf>
c0de04d2:	2000      	movs	r0, #0
c0de04d4:	e000      	b.n	c0de04d8 <handle_init_contract+0x9c>
c0de04d6:	2001      	movs	r0, #1
c0de04d8:	7060      	strb	r0, [r4, #1]
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
}
c0de04da:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
c0de04de:	2002      	movs	r0, #2
            context->next_param = NONE;
c0de04e0:	f888 0084 	strb.w	r0, [r8, #132]	; 0x84
c0de04e4:	2004      	movs	r0, #4
c0de04e6:	e7f7      	b.n	c0de04d8 <handle_init_contract+0x9c>
c0de04e8:	00000bce 	.word	0x00000bce
c0de04ec:	00000b8a 	.word	0x00000b8a
c0de04f0:	000009d2 	.word	0x000009d2
c0de04f4:	00000acd 	.word	0x00000acd

c0de04f8 <handle_provide_parameter>:
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
c0de04f8:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
c0de04fc:	4604      	mov	r4, r0
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0de04fe:	e9d0 8702 	ldrd	r8, r7, [r0, #8]
    PRINTF(title);
c0de0502:	4827      	ldr	r0, [pc, #156]	; (c0de05a0 <handle_provide_parameter+0xa8>)
c0de0504:	4478      	add	r0, pc
c0de0506:	f000 fa07 	bl	c0de0918 <mcu_usb_printf>
c0de050a:	4e26      	ldr	r6, [pc, #152]	; (c0de05a4 <handle_provide_parameter+0xac>)
c0de050c:	2500      	movs	r5, #0
c0de050e:	447e      	add	r6, pc
        PRINTF("%02x", data[i]);
c0de0510:	5d79      	ldrb	r1, [r7, r5]
c0de0512:	4630      	mov	r0, r6
c0de0514:	f000 fa00 	bl	c0de0918 <mcu_usb_printf>
    for (size_t i = 0; i < len; ++i) {
c0de0518:	3501      	adds	r5, #1
c0de051a:	2d20      	cmp	r5, #32
c0de051c:	d1f8      	bne.n	c0de0510 <handle_provide_parameter+0x18>
    PRINTF("\n");
c0de051e:	4822      	ldr	r0, [pc, #136]	; (c0de05a8 <handle_provide_parameter+0xb0>)
c0de0520:	4478      	add	r0, pc
c0de0522:	f000 f9f9 	bl	c0de0918 <mcu_usb_printf>
    printf_hex_array("Plugin provide parameter: ", PARAMETER_LENGTH, msg->parameter);

    msg->result = ETH_PLUGIN_RESULT_OK;

// If not used remove from here
    if (context->skip) {
c0de0526:	f898 008b 	ldrb.w	r0, [r8, #139]	; 0x8b
c0de052a:	2104      	movs	r1, #4
    msg->result = ETH_PLUGIN_RESULT_OK;
c0de052c:	7521      	strb	r1, [r4, #20]
    if (context->skip) {
c0de052e:	b120      	cbz	r0, c0de053a <handle_provide_parameter+0x42>
        // Skip this step, and don't forget to decrease skipping counter.
        context->skip--;
c0de0530:	3801      	subs	r0, #1
c0de0532:	f888 008b 	strb.w	r0, [r8, #139]	; 0x8b
                PRINTF("Selector Index %d not supported\n", context->selectorIndex);
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
        }
    }
c0de0536:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
        if ((context->offset) && msg->parameterOffset != context->checkpoint + context->offset) {
c0de053a:	f8b8 1080 	ldrh.w	r1, [r8, #128]	; 0x80
c0de053e:	b129      	cbz	r1, c0de054c <handle_provide_parameter+0x54>
c0de0540:	f8b8 2082 	ldrh.w	r2, [r8, #130]	; 0x82
c0de0544:	6923      	ldr	r3, [r4, #16]
c0de0546:	1850      	adds	r0, r2, r1
c0de0548:	4283      	cmp	r3, r0
c0de054a:	d10c      	bne.n	c0de0566 <handle_provide_parameter+0x6e>
        switch (context->selectorIndex) {
c0de054c:	f898 1089 	ldrb.w	r1, [r8, #137]	; 0x89
c0de0550:	2500      	movs	r5, #0
        context->offset = 0;
c0de0552:	f8a8 5080 	strh.w	r5, [r8, #128]	; 0x80
        switch (context->selectorIndex) {
c0de0556:	b161      	cbz	r1, c0de0572 <handle_provide_parameter+0x7a>
                PRINTF("Selector Index %d not supported\n", context->selectorIndex);
c0de0558:	4815      	ldr	r0, [pc, #84]	; (c0de05b0 <handle_provide_parameter+0xb8>)
c0de055a:	4478      	add	r0, pc
c0de055c:	f000 f9dc 	bl	c0de0918 <mcu_usb_printf>
                msg->result = ETH_PLUGIN_RESULT_ERROR;
c0de0560:	7525      	strb	r5, [r4, #20]
c0de0562:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
            PRINTF("offset: %d, checkpoint: %d, parameterOffset: %d\n",
c0de0566:	4813      	ldr	r0, [pc, #76]	; (c0de05b4 <handle_provide_parameter+0xbc>)
c0de0568:	4478      	add	r0, pc
c0de056a:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
c0de056e:	f000 b9d3 	b.w	c0de0918 <mcu_usb_printf>
    switch (context->next_param) {
c0de0572:	f898 0084 	ldrb.w	r0, [r8, #132]	; 0x84
c0de0576:	2802      	cmp	r0, #2
c0de0578:	d10a      	bne.n	c0de0590 <handle_provide_parameter+0x98>
    memcpy(context->amount_sent, msg->pluginSharedRO->txContent->value.value , msg->pluginSharedRO->txContent->value.length);
c0de057a:	6860      	ldr	r0, [r4, #4]
c0de057c:	6800      	ldr	r0, [r0, #0]
c0de057e:	f890 2062 	ldrb.w	r2, [r0, #98]	; 0x62
c0de0582:	f100 0142 	add.w	r1, r0, #66	; 0x42
c0de0586:	4640      	mov	r0, r8
c0de0588:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
c0de058c:	f000 bbe1 	b.w	c0de0d52 <__aeabi_memcpy>
            PRINTF("Param not supported\n");
c0de0590:	4806      	ldr	r0, [pc, #24]	; (c0de05ac <handle_provide_parameter+0xb4>)
c0de0592:	4478      	add	r0, pc
c0de0594:	f000 f9c0 	bl	c0de0918 <mcu_usb_printf>
c0de0598:	2000      	movs	r0, #0
            msg->result = ETH_PLUGIN_RESULT_ERROR;
c0de059a:	7520      	strb	r0, [r4, #20]
c0de059c:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
c0de05a0:	00000ae4 	.word	0x00000ae4
c0de05a4:	000009a3 	.word	0x000009a3
c0de05a8:	00000ac6 	.word	0x00000ac6
c0de05ac:	00000901 	.word	0x00000901
c0de05b0:	00000b0b 	.word	0x00000b0b
c0de05b4:	00000997 	.word	0x00000997

c0de05b8 <handle_provide_token>:
static void received_network_token(cowswap_parameters_t *context) {
    context->decimals_received = WEI_TO_ETHER;
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
}

void handle_provide_token(void *parameters) {
c0de05b8:	b570      	push	{r4, r5, r6, lr}
c0de05ba:	4604      	mov	r4, r0
    ethPluginProvideInfo_t *msg = (ethPluginProvideInfo_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0de05bc:	e9d0 6102 	ldrd	r6, r1, [r0, #8]
    PRINTF("Plugin provide tokens : 0x%p, 0x%p\n", msg->item1, msg->item2);
c0de05c0:	6902      	ldr	r2, [r0, #16]
c0de05c2:	483d      	ldr	r0, [pc, #244]	; (c0de06b8 <handle_provide_token+0x100>)
c0de05c4:	4478      	add	r0, pc
c0de05c6:	f000 f9a7 	bl	c0de0918 <mcu_usb_printf>

    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
c0de05ca:	493c      	ldr	r1, [pc, #240]	; (c0de06bc <handle_provide_token+0x104>)
c0de05cc:	f106 0540 	add.w	r5, r6, #64	; 0x40
c0de05d0:	4479      	add	r1, pc
c0de05d2:	4628      	mov	r0, r5
c0de05d4:	2214      	movs	r2, #20
c0de05d6:	f000 fbc5 	bl	c0de0d64 <memcmp>
c0de05da:	b1c8      	cbz	r0, c0de0610 <handle_provide_token+0x58>
c0de05dc:	4938      	ldr	r1, [pc, #224]	; (c0de06c0 <handle_provide_token+0x108>)
c0de05de:	4628      	mov	r0, r5
c0de05e0:	4479      	add	r1, pc
c0de05e2:	2214      	movs	r2, #20
c0de05e4:	f000 fbbe 	bl	c0de0d64 <memcmp>
c0de05e8:	b190      	cbz	r0, c0de0610 <handle_provide_token+0x58>
        sent_network_token(context);
    } else if (msg->item1 != NULL) {
c0de05ea:	68e0      	ldr	r0, [r4, #12]
c0de05ec:	2800      	cmp	r0, #0
c0de05ee:	d046      	beq.n	c0de067e <handle_provide_token+0xc6>
        context->decimals_sent = msg->item1->token.decimals;
c0de05f0:	f890 2020 	ldrb.w	r2, [r0, #32]
c0de05f4:	f100 0114 	add.w	r1, r0, #20
c0de05f8:	f886 2087 	strb.w	r2, [r6, #135]	; 0x87
        strlcpy(context->ticker_sent,
c0de05fc:	f106 0068 	add.w	r0, r6, #104	; 0x68
c0de0600:	220c      	movs	r2, #12
c0de0602:	f000 fbfd 	bl	c0de0e00 <strlcpy>
                (char *) msg->item1->token.ticker,
                sizeof(context->ticker_sent));
        context->tokens_found |= TOKEN_SENT_FOUND;
c0de0606:	f896 0085 	ldrb.w	r0, [r6, #133]	; 0x85
c0de060a:	f040 0001 	orr.w	r0, r0, #1
c0de060e:	e006      	b.n	c0de061e <handle_provide_token+0x66>
    context->tokens_found |= TOKEN_SENT_FOUND;
c0de0610:	f896 1085 	ldrb.w	r1, [r6, #133]	; 0x85
c0de0614:	2012      	movs	r0, #18
    context->decimals_sent = WEI_TO_ETHER;
c0de0616:	f886 0087 	strb.w	r0, [r6, #135]	; 0x87
    context->tokens_found |= TOKEN_SENT_FOUND;
c0de061a:	f041 0001 	orr.w	r0, r1, #1
c0de061e:	f886 0085 	strb.w	r0, [r6, #133]	; 0x85
        strlcpy(context->ticker_sent, DEFAULT_TICKER, sizeof(context->ticker_sent));
        // // We will need an additional screen to display a warning message.
        msg->additionalScreens++;
    }

    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_received)) {
c0de0622:	4929      	ldr	r1, [pc, #164]	; (c0de06c8 <handle_provide_token+0x110>)
c0de0624:	f106 0554 	add.w	r5, r6, #84	; 0x54
c0de0628:	4479      	add	r1, pc
c0de062a:	4628      	mov	r0, r5
c0de062c:	2214      	movs	r2, #20
c0de062e:	f000 fb99 	bl	c0de0d64 <memcmp>
c0de0632:	b1c0      	cbz	r0, c0de0666 <handle_provide_token+0xae>
c0de0634:	4925      	ldr	r1, [pc, #148]	; (c0de06cc <handle_provide_token+0x114>)
c0de0636:	4628      	mov	r0, r5
c0de0638:	4479      	add	r1, pc
c0de063a:	2214      	movs	r2, #20
c0de063c:	f000 fb92 	bl	c0de0d64 <memcmp>
c0de0640:	b188      	cbz	r0, c0de0666 <handle_provide_token+0xae>
        received_network_token(context);
    } else if (msg->item2 != NULL) {
c0de0642:	6920      	ldr	r0, [r4, #16]
c0de0644:	b348      	cbz	r0, c0de069a <handle_provide_token+0xe2>
        context->decimals_received = msg->item2->token.decimals;
c0de0646:	f890 2020 	ldrb.w	r2, [r0, #32]
c0de064a:	f100 0114 	add.w	r1, r0, #20
c0de064e:	f886 2088 	strb.w	r2, [r6, #136]	; 0x88
        strlcpy(context->ticker_received,
c0de0652:	f106 0074 	add.w	r0, r6, #116	; 0x74
c0de0656:	220c      	movs	r2, #12
c0de0658:	f000 fbd2 	bl	c0de0e00 <strlcpy>
                (char *) msg->item2->token.ticker,
                sizeof(context->ticker_received));
        context->tokens_found |= TOKEN_RECEIVED_FOUND;
c0de065c:	f896 0085 	ldrb.w	r0, [r6, #133]	; 0x85
c0de0660:	f040 0002 	orr.w	r0, r0, #2
c0de0664:	e006      	b.n	c0de0674 <handle_provide_token+0xbc>
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
c0de0666:	f896 1085 	ldrb.w	r1, [r6, #133]	; 0x85
c0de066a:	2012      	movs	r0, #18
    context->decimals_received = WEI_TO_ETHER;
c0de066c:	f886 0088 	strb.w	r0, [r6, #136]	; 0x88
    context->tokens_found |= TOKEN_RECEIVED_FOUND;
c0de0670:	f041 0002 	orr.w	r0, r1, #2
c0de0674:	f886 0085 	strb.w	r0, [r6, #133]	; 0x85
c0de0678:	2004      	movs	r0, #4
        strlcpy(context->ticker_received, DEFAULT_TICKER, sizeof(context->ticker_sent));
        // // We will need an additional screen to display a warning message.
        msg->additionalScreens++;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
c0de067a:	7560      	strb	r0, [r4, #21]
c0de067c:	bd70      	pop	{r4, r5, r6, pc}
c0de067e:	2012      	movs	r0, #18
        context->decimals_sent = DEFAULT_DECIMAL;
c0de0680:	f886 0087 	strb.w	r0, [r6, #135]	; 0x87
        strlcpy(context->ticker_sent, DEFAULT_TICKER, sizeof(context->ticker_sent));
c0de0684:	490f      	ldr	r1, [pc, #60]	; (c0de06c4 <handle_provide_token+0x10c>)
c0de0686:	f106 0068 	add.w	r0, r6, #104	; 0x68
c0de068a:	4479      	add	r1, pc
c0de068c:	220c      	movs	r2, #12
c0de068e:	f000 fbb7 	bl	c0de0e00 <strlcpy>
        msg->additionalScreens++;
c0de0692:	7d20      	ldrb	r0, [r4, #20]
c0de0694:	3001      	adds	r0, #1
c0de0696:	7520      	strb	r0, [r4, #20]
c0de0698:	e7c3      	b.n	c0de0622 <handle_provide_token+0x6a>
c0de069a:	2012      	movs	r0, #18
        context->decimals_received = DEFAULT_DECIMAL;
c0de069c:	f886 0088 	strb.w	r0, [r6, #136]	; 0x88
        strlcpy(context->ticker_received, DEFAULT_TICKER, sizeof(context->ticker_sent));
c0de06a0:	490b      	ldr	r1, [pc, #44]	; (c0de06d0 <handle_provide_token+0x118>)
c0de06a2:	f106 0074 	add.w	r0, r6, #116	; 0x74
c0de06a6:	4479      	add	r1, pc
c0de06a8:	220c      	movs	r2, #12
c0de06aa:	f000 fba9 	bl	c0de0e00 <strlcpy>
        msg->additionalScreens++;
c0de06ae:	7d20      	ldrb	r0, [r4, #20]
c0de06b0:	3001      	adds	r0, #1
c0de06b2:	7520      	strb	r0, [r4, #20]
c0de06b4:	e7e0      	b.n	c0de0678 <handle_provide_token+0xc0>
c0de06b6:	bf00      	nop
c0de06b8:	00000991 	.word	0x00000991
c0de06bc:	00000878 	.word	0x00000878
c0de06c0:	00000aea 	.word	0x00000aea
c0de06c4:	00000992 	.word	0x00000992
c0de06c8:	00000820 	.word	0x00000820
c0de06cc:	00000a92 	.word	0x00000a92
c0de06d0:	00000976 	.word	0x00000976

c0de06d4 <handle_query_contract_id>:
#include "cowswap_plugin.h"

void handle_query_contract_id(void *parameters) {
c0de06d4:	b5b0      	push	{r4, r5, r7, lr}
c0de06d6:	4604      	mov	r4, r0
    ethQueryContractID_t *msg = (ethQueryContractID_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0de06d8:	e9d0 5002 	ldrd	r5, r0, [r0, #8]

    strlcpy(msg->name, PLUGIN_NAME, msg->nameLength);
c0de06dc:	6922      	ldr	r2, [r4, #16]
c0de06de:	490b      	ldr	r1, [pc, #44]	; (c0de070c <handle_query_contract_id+0x38>)
c0de06e0:	4479      	add	r1, pc
c0de06e2:	f000 fb8d 	bl	c0de0e00 <strlcpy>

    switch (context->selectorIndex) {
c0de06e6:	f895 1089 	ldrb.w	r1, [r5, #137]	; 0x89
c0de06ea:	b129      	cbz	r1, c0de06f8 <handle_query_contract_id+0x24>
        case DEPOSIT:
            strlcpy(msg->version, "Deposit", msg->versionLength);
            break;
        default:
            PRINTF("Selector Index :%d not supported\n", context->selectorIndex);
c0de06ec:	4809      	ldr	r0, [pc, #36]	; (c0de0714 <handle_query_contract_id+0x40>)
c0de06ee:	4478      	add	r0, pc
c0de06f0:	f000 f912 	bl	c0de0918 <mcu_usb_printf>
c0de06f4:	2000      	movs	r0, #0
c0de06f6:	e006      	b.n	c0de0706 <handle_query_contract_id+0x32>
            strlcpy(msg->version, "Deposit", msg->versionLength);
c0de06f8:	e9d4 0205 	ldrd	r0, r2, [r4, #20]
c0de06fc:	4904      	ldr	r1, [pc, #16]	; (c0de0710 <handle_query_contract_id+0x3c>)
c0de06fe:	4479      	add	r1, pc
c0de0700:	f000 fb7e 	bl	c0de0e00 <strlcpy>
c0de0704:	2004      	movs	r0, #4
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
c0de0706:	7720      	strb	r0, [r4, #28]
c0de0708:	bdb0      	pop	{r4, r5, r7, pc}
c0de070a:	bf00      	nop
c0de070c:	000007d6 	.word	0x000007d6
c0de0710:	0000095f 	.word	0x0000095f
c0de0714:	0000092f 	.word	0x0000092f

c0de0718 <handle_query_contract_ui>:
            return ERROR;
    }
    return ERROR;
}

void handle_query_contract_ui(void *parameters) {
c0de0718:	b570      	push	{r4, r5, r6, lr}
c0de071a:	b082      	sub	sp, #8
c0de071c:	4604      	mov	r4, r0
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
c0de071e:	69c5      	ldr	r5, [r0, #28]
    memset(msg->title, 0, msg->titleLength);
c0de0720:	6a40      	ldr	r0, [r0, #36]	; 0x24
c0de0722:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0de0724:	f000 fb12 	bl	c0de0d4c <__aeabi_memclr>
    memset(msg->msg, 0, msg->msgLength);
c0de0728:	e9d4 010b 	ldrd	r0, r1, [r4, #44]	; 0x2c
c0de072c:	f000 fb0e 	bl	c0de0d4c <__aeabi_memclr>
    uint8_t index = msg->screenIndex;
c0de0730:	f894 0020 	ldrb.w	r0, [r4, #32]
c0de0734:	2104      	movs	r1, #4
    msg->result = ETH_PLUGIN_RESULT_OK;
c0de0736:	f884 1034 	strb.w	r1, [r4, #52]	; 0x34

    screens_t screen = get_screen(msg, context);
    switch (screen) {
c0de073a:	b118      	cbz	r0, c0de0744 <handle_query_contract_ui+0x2c>
            break;
        case WARN_SCREEN:
            set_warning_ui(msg, context);
            break;
        default:
            PRINTF("Received an invalid screenIndex %d\n", screen);
c0de073c:	4824      	ldr	r0, [pc, #144]	; (c0de07d0 <handle_query_contract_ui+0xb8>)
c0de073e:	2103      	movs	r1, #3
c0de0740:	4478      	add	r0, pc
c0de0742:	e004      	b.n	c0de074e <handle_query_contract_ui+0x36>
    switch (context->selectorIndex) {
c0de0744:	f895 1089 	ldrb.w	r1, [r5, #137]	; 0x89
c0de0748:	b141      	cbz	r1, c0de075c <handle_query_contract_ui+0x44>
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
c0de074a:	4822      	ldr	r0, [pc, #136]	; (c0de07d4 <handle_query_contract_ui+0xbc>)
c0de074c:	4478      	add	r0, pc
c0de074e:	f000 f8e3 	bl	c0de0918 <mcu_usb_printf>
c0de0752:	2000      	movs	r0, #0
c0de0754:	f884 0034 	strb.w	r0, [r4, #52]	; 0x34
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }
}
c0de0758:	b002      	add	sp, #8
c0de075a:	bd70      	pop	{r4, r5, r6, pc}
            strlcpy(msg->title, "Send", msg->titleLength);
c0de075c:	e9d4 0209 	ldrd	r0, r2, [r4, #36]	; 0x24
c0de0760:	4917      	ldr	r1, [pc, #92]	; (c0de07c0 <handle_query_contract_ui+0xa8>)
c0de0762:	4479      	add	r1, pc
c0de0764:	f000 fb4c 	bl	c0de0e00 <strlcpy>
    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
c0de0768:	4916      	ldr	r1, [pc, #88]	; (c0de07c4 <handle_query_contract_ui+0xac>)
c0de076a:	f105 0640 	add.w	r6, r5, #64	; 0x40
c0de076e:	4479      	add	r1, pc
c0de0770:	4630      	mov	r0, r6
c0de0772:	2214      	movs	r2, #20
c0de0774:	f000 faf6 	bl	c0de0d64 <memcmp>
c0de0778:	b130      	cbz	r0, c0de0788 <handle_query_contract_ui+0x70>
c0de077a:	4913      	ldr	r1, [pc, #76]	; (c0de07c8 <handle_query_contract_ui+0xb0>)
c0de077c:	4630      	mov	r0, r6
c0de077e:	4479      	add	r1, pc
c0de0780:	2214      	movs	r2, #20
c0de0782:	f000 faef 	bl	c0de0d64 <memcmp>
c0de0786:	b930      	cbnz	r0, c0de0796 <handle_query_contract_ui+0x7e>
        strlcpy(context->ticker_sent, msg->network_ticker, sizeof(context->ticker_sent));
c0de0788:	f105 0068 	add.w	r0, r5, #104	; 0x68
c0de078c:	f104 0110 	add.w	r1, r4, #16
c0de0790:	220c      	movs	r2, #12
c0de0792:	f000 fb35 	bl	c0de0e00 <strlcpy>
                   msg->msg,
c0de0796:	e9d4 060b 	ldrd	r0, r6, [r4, #44]	; 0x2c
                   context->decimals_sent,
c0de079a:	f895 2087 	ldrb.w	r2, [r5, #135]	; 0x87
                   context->ticker_sent,
c0de079e:	f105 0368 	add.w	r3, r5, #104	; 0x68
    amountToString(context->amount_sent,
c0de07a2:	9000      	str	r0, [sp, #0]
c0de07a4:	4628      	mov	r0, r5
c0de07a6:	2120      	movs	r1, #32
c0de07a8:	9601      	str	r6, [sp, #4]
c0de07aa:	f7ff fd79 	bl	c0de02a0 <amountToString>
    PRINTF("AMOUNT SENT: %s\n", msg->msg);
c0de07ae:	4807      	ldr	r0, [pc, #28]	; (c0de07cc <handle_query_contract_ui+0xb4>)
c0de07b0:	6ae1      	ldr	r1, [r4, #44]	; 0x2c
c0de07b2:	4478      	add	r0, pc
c0de07b4:	b002      	add	sp, #8
c0de07b6:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
c0de07ba:	f000 b8ad 	b.w	c0de0918 <mcu_usb_printf>
c0de07be:	bf00      	nop
c0de07c0:	0000070f 	.word	0x0000070f
c0de07c4:	000006da 	.word	0x000006da
c0de07c8:	0000094c 	.word	0x0000094c
c0de07cc:	00000851 	.word	0x00000851
c0de07d0:	00000946 	.word	0x00000946
c0de07d4:	000008f3 	.word	0x000008f3

c0de07d8 <dispatch_plugin_calls>:
void dispatch_plugin_calls(int message, void *parameters) {
c0de07d8:	b5b0      	push	{r4, r5, r7, lr}
c0de07da:	4605      	mov	r5, r0
    PRINTF("Handling message %d\n", message);
c0de07dc:	4832      	ldr	r0, [pc, #200]	; (c0de08a8 <dispatch_plugin_calls+0xd0>)
c0de07de:	460c      	mov	r4, r1
c0de07e0:	4478      	add	r0, pc
c0de07e2:	4629      	mov	r1, r5
c0de07e4:	f000 f898 	bl	c0de0918 <mcu_usb_printf>
    switch (message) {
c0de07e8:	f5b5 7f82 	cmp.w	r5, #260	; 0x104
c0de07ec:	da15      	bge.n	c0de081a <dispatch_plugin_calls+0x42>
c0de07ee:	f240 1001 	movw	r0, #257	; 0x101
c0de07f2:	4285      	cmp	r5, r0
c0de07f4:	d024      	beq.n	c0de0840 <dispatch_plugin_calls+0x68>
c0de07f6:	f5b5 7f81 	cmp.w	r5, #258	; 0x102
c0de07fa:	d02c      	beq.n	c0de0856 <dispatch_plugin_calls+0x7e>
c0de07fc:	f240 1003 	movw	r0, #259	; 0x103
c0de0800:	4285      	cmp	r5, r0
c0de0802:	d149      	bne.n	c0de0898 <dispatch_plugin_calls+0xc0>
            PRINTF("SLI3 %d\n", message);
c0de0804:	4829      	ldr	r0, [pc, #164]	; (c0de08ac <dispatch_plugin_calls+0xd4>)
c0de0806:	f240 1103 	movw	r1, #259	; 0x103
c0de080a:	4478      	add	r0, pc
c0de080c:	f000 f884 	bl	c0de0918 <mcu_usb_printf>
            handle_finalize(parameters);
c0de0810:	4620      	mov	r0, r4
c0de0812:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de0816:	f7ff bd83 	b.w	c0de0320 <handle_finalize>
    switch (message) {
c0de081a:	d027      	beq.n	c0de086c <dispatch_plugin_calls+0x94>
c0de081c:	f240 1005 	movw	r0, #261	; 0x105
c0de0820:	4285      	cmp	r5, r0
c0de0822:	d02e      	beq.n	c0de0882 <dispatch_plugin_calls+0xaa>
c0de0824:	f5b5 7f83 	cmp.w	r5, #262	; 0x106
c0de0828:	d136      	bne.n	c0de0898 <dispatch_plugin_calls+0xc0>
            PRINTF("SLI6 %d\n", message);
c0de082a:	4821      	ldr	r0, [pc, #132]	; (c0de08b0 <dispatch_plugin_calls+0xd8>)
c0de082c:	f44f 7183 	mov.w	r1, #262	; 0x106
c0de0830:	4478      	add	r0, pc
c0de0832:	f000 f871 	bl	c0de0918 <mcu_usb_printf>
            handle_query_contract_ui(parameters);
c0de0836:	4620      	mov	r0, r4
c0de0838:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de083c:	f7ff bf6c 	b.w	c0de0718 <handle_query_contract_ui>
            PRINTF("SLI1 %d\n", message);
c0de0840:	481c      	ldr	r0, [pc, #112]	; (c0de08b4 <dispatch_plugin_calls+0xdc>)
c0de0842:	f240 1101 	movw	r1, #257	; 0x101
c0de0846:	4478      	add	r0, pc
c0de0848:	f000 f866 	bl	c0de0918 <mcu_usb_printf>
            handle_init_contract(parameters);
c0de084c:	4620      	mov	r0, r4
c0de084e:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de0852:	f7ff bdf3 	b.w	c0de043c <handle_init_contract>
            PRINTF("SLI2 %d\n", message);
c0de0856:	4818      	ldr	r0, [pc, #96]	; (c0de08b8 <dispatch_plugin_calls+0xe0>)
c0de0858:	f44f 7181 	mov.w	r1, #258	; 0x102
c0de085c:	4478      	add	r0, pc
c0de085e:	f000 f85b 	bl	c0de0918 <mcu_usb_printf>
            handle_provide_parameter(parameters);
c0de0862:	4620      	mov	r0, r4
c0de0864:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de0868:	f7ff be46 	b.w	c0de04f8 <handle_provide_parameter>
            PRINTF("SLI4 %d\n", message);
c0de086c:	4813      	ldr	r0, [pc, #76]	; (c0de08bc <dispatch_plugin_calls+0xe4>)
c0de086e:	f44f 7182 	mov.w	r1, #260	; 0x104
c0de0872:	4478      	add	r0, pc
c0de0874:	f000 f850 	bl	c0de0918 <mcu_usb_printf>
            handle_provide_token(parameters);
c0de0878:	4620      	mov	r0, r4
c0de087a:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de087e:	f7ff be9b 	b.w	c0de05b8 <handle_provide_token>
            PRINTF("SLI5 %d\n", message);
c0de0882:	480f      	ldr	r0, [pc, #60]	; (c0de08c0 <dispatch_plugin_calls+0xe8>)
c0de0884:	f240 1105 	movw	r1, #261	; 0x105
c0de0888:	4478      	add	r0, pc
c0de088a:	f000 f845 	bl	c0de0918 <mcu_usb_printf>
            handle_query_contract_id(parameters);
c0de088e:	4620      	mov	r0, r4
c0de0890:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de0894:	f7ff bf1e 	b.w	c0de06d4 <handle_query_contract_id>
            PRINTF("Unhandled message %d\n", message);
c0de0898:	480a      	ldr	r0, [pc, #40]	; (c0de08c4 <dispatch_plugin_calls+0xec>)
c0de089a:	4629      	mov	r1, r5
c0de089c:	4478      	add	r0, pc
c0de089e:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de08a2:	f000 b839 	b.w	c0de0918 <mcu_usb_printf>
c0de08a6:	bf00      	nop
c0de08a8:	0000067c 	.word	0x0000067c
c0de08ac:	0000067e 	.word	0x0000067e
c0de08b0:	00000700 	.word	0x00000700
c0de08b4:	00000662 	.word	0x00000662
c0de08b8:	00000623 	.word	0x00000623
c0de08bc:	000006c7 	.word	0x000006c7
c0de08c0:	000005ee 	.word	0x000005ee
c0de08c4:	00000714 	.word	0x00000714

c0de08c8 <os_boot>:
#ifndef BOLOS_OS_UPGRADER_APP
void os_boot(void) {
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0de08c8:	2000      	movs	r0, #0
c0de08ca:	f000 ba31 	b.w	c0de0d30 <try_context_set>
	...

c0de08d0 <os_longjmp>:
  }
  return xoracc;
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0de08d0:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
c0de08d2:	4672      	mov	r2, lr
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
c0de08d4:	4804      	ldr	r0, [pc, #16]	; (c0de08e8 <os_longjmp+0x18>)
c0de08d6:	4621      	mov	r1, r4
c0de08d8:	4478      	add	r0, pc
c0de08da:	f000 f81d 	bl	c0de0918 <mcu_usb_printf>
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0de08de:	f000 fa1d 	bl	c0de0d1c <try_context_get>
c0de08e2:	4621      	mov	r1, r4
c0de08e4:	f000 fa84 	bl	c0de0df0 <longjmp>
c0de08e8:	000006a1 	.word	0x000006a1

c0de08ec <mcu_usb_prints>:
  return ret;
}
#endif // !defined(APP_UX)

#ifdef HAVE_PRINTF
void mcu_usb_prints(const char* str, unsigned int charcount) {
c0de08ec:	b5b0      	push	{r4, r5, r7, lr}
c0de08ee:	b082      	sub	sp, #8
c0de08f0:	4605      	mov	r5, r0
c0de08f2:	205f      	movs	r0, #95	; 0x5f
  unsigned char buf[4];
#ifdef TARGET_NANOS
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#else
  buf[0] = SEPROXYHAL_TAG_PRINTF;
c0de08f4:	f88d 0004 	strb.w	r0, [sp, #4]
#endif
  buf[1] = charcount >> 8;
c0de08f8:	0a08      	lsrs	r0, r1, #8
c0de08fa:	460c      	mov	r4, r1
c0de08fc:	f88d 0005 	strb.w	r0, [sp, #5]
  buf[2] = charcount;
c0de0900:	f88d 1006 	strb.w	r1, [sp, #6]
c0de0904:	a801      	add	r0, sp, #4
  io_seproxyhal_spi_send(buf, 3);
c0de0906:	2103      	movs	r1, #3
c0de0908:	f000 f9fc 	bl	c0de0d04 <io_seph_send>
  io_seproxyhal_spi_send((const uint8_t *) str, charcount);
c0de090c:	b2a1      	uxth	r1, r4
c0de090e:	4628      	mov	r0, r5
c0de0910:	f000 f9f8 	bl	c0de0d04 <io_seph_send>
}
c0de0914:	b002      	add	sp, #8
c0de0916:	bdb0      	pop	{r4, r5, r7, pc}

c0de0918 <mcu_usb_printf>:
#include "usbd_def.h"
#include "usbd_core.h"

void screen_printf(const char* format, ...) __attribute__ ((weak, alias ("mcu_usb_printf")));

void mcu_usb_printf(const char* format, ...) {
c0de0918:	b083      	sub	sp, #12
c0de091a:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de091e:	b089      	sub	sp, #36	; 0x24
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(format == 0) {
c0de0920:	2800      	cmp	r0, #0
c0de0922:	e9cd 1211 	strd	r1, r2, [sp, #68]	; 0x44
c0de0926:	9313      	str	r3, [sp, #76]	; 0x4c
c0de0928:	f000 8178 	beq.w	c0de0c1c <mcu_usb_printf+0x304>
c0de092c:	4604      	mov	r4, r0
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0de092e:	7800      	ldrb	r0, [r0, #0]
c0de0930:	a911      	add	r1, sp, #68	; 0x44
c0de0932:	2800      	cmp	r0, #0
    va_start(vaArgP, format);
c0de0934:	9103      	str	r1, [sp, #12]
    while(*format)
c0de0936:	f000 8171 	beq.w	c0de0c1c <mcu_usb_printf+0x304>
c0de093a:	bf00      	nop
c0de093c:	2700      	movs	r7, #0
c0de093e:	bf00      	nop
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0de0940:	b130      	cbz	r0, c0de0950 <mcu_usb_printf+0x38>
c0de0942:	2825      	cmp	r0, #37	; 0x25
c0de0944:	d004      	beq.n	c0de0950 <mcu_usb_printf+0x38>
c0de0946:	19e0      	adds	r0, r4, r7
c0de0948:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0de094a:	3701      	adds	r7, #1
c0de094c:	e7f8      	b.n	c0de0940 <mcu_usb_printf+0x28>
c0de094e:	bf00      	nop
        }

        //
        // Write this portion of the string.
        //
        mcu_usb_prints(format, ulIdx);
c0de0950:	4620      	mov	r0, r4
c0de0952:	4639      	mov	r1, r7
c0de0954:	19e5      	adds	r5, r4, r7
c0de0956:	f7ff ffc9 	bl	c0de08ec <mcu_usb_prints>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0de095a:	5de0      	ldrb	r0, [r4, r7]
c0de095c:	2825      	cmp	r0, #37	; 0x25
c0de095e:	d14b      	bne.n	c0de09f8 <mcu_usb_printf+0xe0>
            ulCount = 0;
            cFill = ' ';
            ulStrlen = 0;
            cStrlenSet = 0;
            ulCap = 0;
            ulBase = 10;
c0de0960:	1c6c      	adds	r4, r5, #1
c0de0962:	f04f 0800 	mov.w	r8, #0
c0de0966:	2220      	movs	r2, #32
c0de0968:	f04f 0a00 	mov.w	sl, #0
c0de096c:	2000      	movs	r0, #0
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0de096e:	3401      	adds	r4, #1
c0de0970:	f814 1c01 	ldrb.w	r1, [r4, #-1]
c0de0974:	3401      	adds	r4, #1
c0de0976:	292d      	cmp	r1, #45	; 0x2d
c0de0978:	dc12      	bgt.n	c0de09a0 <mcu_usb_printf+0x88>
c0de097a:	f04f 0000 	mov.w	r0, #0
c0de097e:	d0f7      	beq.n	c0de0970 <mcu_usb_printf+0x58>
c0de0980:	2925      	cmp	r1, #37	; 0x25
c0de0982:	d076      	beq.n	c0de0a72 <mcu_usb_printf+0x15a>
c0de0984:	292a      	cmp	r1, #42	; 0x2a
c0de0986:	f040 80fa 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
                  goto error;
                }

                case '*':
                {
                  if (*format == 's' ) {
c0de098a:	4623      	mov	r3, r4
c0de098c:	f813 0d01 	ldrb.w	r0, [r3, #-1]!
c0de0990:	2873      	cmp	r0, #115	; 0x73
c0de0992:	f040 80f4 	bne.w	c0de0b7e <mcu_usb_printf+0x266>

                    ulStrlen = va_arg(vaArgP, unsigned long);
c0de0996:	9903      	ldr	r1, [sp, #12]
c0de0998:	2002      	movs	r0, #2
c0de099a:	461c      	mov	r4, r3
c0de099c:	e026      	b.n	c0de09ec <mcu_usb_printf+0xd4>
c0de099e:	bf00      	nop
            switch(*format++)
c0de09a0:	2947      	cmp	r1, #71	; 0x47
c0de09a2:	dc2b      	bgt.n	c0de09fc <mcu_usb_printf+0xe4>
c0de09a4:	f1a1 0330 	sub.w	r3, r1, #48	; 0x30
c0de09a8:	2b0a      	cmp	r3, #10
c0de09aa:	d20d      	bcs.n	c0de09c8 <mcu_usb_printf+0xb0>
                    if((format[-1] == '0') && (ulCount == 0))
c0de09ac:	f081 0330 	eor.w	r3, r1, #48	; 0x30
c0de09b0:	ea53 0308 	orrs.w	r3, r3, r8
                    ulCount *= 10;
c0de09b4:	eb08 0388 	add.w	r3, r8, r8, lsl #2
                    ulCount += format[-1] - '0';
c0de09b8:	eb01 0143 	add.w	r1, r1, r3, lsl #1
                    if((format[-1] == '0') && (ulCount == 0))
c0de09bc:	bf08      	it	eq
c0de09be:	2230      	moveq	r2, #48	; 0x30
                    ulCount += format[-1] - '0';
c0de09c0:	f1a1 0830 	sub.w	r8, r1, #48	; 0x30
                    goto again;
c0de09c4:	3c01      	subs	r4, #1
c0de09c6:	e7d2      	b.n	c0de096e <mcu_usb_printf+0x56>
            switch(*format++)
c0de09c8:	292e      	cmp	r1, #46	; 0x2e
c0de09ca:	f040 80d8 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0de09ce:	f814 0c01 	ldrb.w	r0, [r4, #-1]
c0de09d2:	282a      	cmp	r0, #42	; 0x2a
c0de09d4:	f040 80d3 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
c0de09d8:	7820      	ldrb	r0, [r4, #0]
c0de09da:	2848      	cmp	r0, #72	; 0x48
c0de09dc:	d004      	beq.n	c0de09e8 <mcu_usb_printf+0xd0>
c0de09de:	2873      	cmp	r0, #115	; 0x73
c0de09e0:	d002      	beq.n	c0de09e8 <mcu_usb_printf+0xd0>
c0de09e2:	2868      	cmp	r0, #104	; 0x68
c0de09e4:	f040 80cb 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
                    ulStrlen = va_arg(vaArgP, unsigned long);
c0de09e8:	9903      	ldr	r1, [sp, #12]
c0de09ea:	2001      	movs	r0, #1
c0de09ec:	1d0b      	adds	r3, r1, #4
c0de09ee:	9303      	str	r3, [sp, #12]
c0de09f0:	f8d1 a000 	ldr.w	sl, [r1]
c0de09f4:	e7bb      	b.n	c0de096e <mcu_usb_printf+0x56>
c0de09f6:	bf00      	nop
c0de09f8:	462c      	mov	r4, r5
c0de09fa:	e0cf      	b.n	c0de0b9c <mcu_usb_printf+0x284>
            switch(*format++)
c0de09fc:	2967      	cmp	r1, #103	; 0x67
c0de09fe:	dd08      	ble.n	c0de0a12 <mcu_usb_printf+0xfa>
c0de0a00:	2972      	cmp	r1, #114	; 0x72
c0de0a02:	dd11      	ble.n	c0de0a28 <mcu_usb_printf+0x110>
c0de0a04:	2973      	cmp	r1, #115	; 0x73
c0de0a06:	d036      	beq.n	c0de0a76 <mcu_usb_printf+0x15e>
c0de0a08:	2975      	cmp	r1, #117	; 0x75
c0de0a0a:	d039      	beq.n	c0de0a80 <mcu_usb_printf+0x168>
c0de0a0c:	2978      	cmp	r1, #120	; 0x78
c0de0a0e:	d011      	beq.n	c0de0a34 <mcu_usb_printf+0x11c>
c0de0a10:	e0b5      	b.n	c0de0b7e <mcu_usb_printf+0x266>
c0de0a12:	2962      	cmp	r1, #98	; 0x62
c0de0a14:	dc18      	bgt.n	c0de0a48 <mcu_usb_printf+0x130>
c0de0a16:	2948      	cmp	r1, #72	; 0x48
c0de0a18:	f000 809e 	beq.w	c0de0b58 <mcu_usb_printf+0x240>
c0de0a1c:	2958      	cmp	r1, #88	; 0x58
c0de0a1e:	f040 80ae 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
c0de0a22:	f04f 0c01 	mov.w	ip, #1
c0de0a26:	e007      	b.n	c0de0a38 <mcu_usb_printf+0x120>
c0de0a28:	2968      	cmp	r1, #104	; 0x68
c0de0a2a:	f000 8098 	beq.w	c0de0b5e <mcu_usb_printf+0x246>
c0de0a2e:	2970      	cmp	r1, #112	; 0x70
c0de0a30:	f040 80a5 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
c0de0a34:	f04f 0c00 	mov.w	ip, #0
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a38:	9803      	ldr	r0, [sp, #12]
c0de0a3a:	2710      	movs	r7, #16
c0de0a3c:	1d01      	adds	r1, r0, #4
c0de0a3e:	9103      	str	r1, [sp, #12]
c0de0a40:	6806      	ldr	r6, [r0, #0]
c0de0a42:	2001      	movs	r0, #1
c0de0a44:	9608      	str	r6, [sp, #32]
c0de0a46:	e024      	b.n	c0de0a92 <mcu_usb_printf+0x17a>
            switch(*format++)
c0de0a48:	2963      	cmp	r1, #99	; 0x63
c0de0a4a:	f000 809c 	beq.w	c0de0b86 <mcu_usb_printf+0x26e>
c0de0a4e:	2964      	cmp	r1, #100	; 0x64
c0de0a50:	f040 8095 	bne.w	c0de0b7e <mcu_usb_printf+0x266>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a54:	9803      	ldr	r0, [sp, #12]
c0de0a56:	1d01      	adds	r1, r0, #4
c0de0a58:	9103      	str	r1, [sp, #12]
c0de0a5a:	6806      	ldr	r6, [r0, #0]
                    if((long)ulValue < 0)
c0de0a5c:	f1b6 3fff 	cmp.w	r6, #4294967295	; 0xffffffff
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a60:	9608      	str	r6, [sp, #32]
c0de0a62:	dc12      	bgt.n	c0de0a8a <mcu_usb_printf+0x172>
                        ulValue = -(long)ulValue;
c0de0a64:	4276      	negs	r6, r6
c0de0a66:	9608      	str	r6, [sp, #32]
c0de0a68:	2000      	movs	r0, #0
c0de0a6a:	270a      	movs	r7, #10
            ulCap = 0;
c0de0a6c:	f04f 0c00 	mov.w	ip, #0
c0de0a70:	e00f      	b.n	c0de0a92 <mcu_usb_printf+0x17a>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    mcu_usb_prints(format - 1, 1);
c0de0a72:	1ea0      	subs	r0, r4, #2
c0de0a74:	e08d      	b.n	c0de0b92 <mcu_usb_printf+0x27a>
c0de0a76:	496d      	ldr	r1, [pc, #436]	; (c0de0c2c <mcu_usb_printf+0x314>)
c0de0a78:	4479      	add	r1, pc
c0de0a7a:	468c      	mov	ip, r1
c0de0a7c:	2100      	movs	r1, #0
c0de0a7e:	e072      	b.n	c0de0b66 <mcu_usb_printf+0x24e>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a80:	9803      	ldr	r0, [sp, #12]
c0de0a82:	1d01      	adds	r1, r0, #4
c0de0a84:	9103      	str	r1, [sp, #12]
c0de0a86:	6806      	ldr	r6, [r0, #0]
c0de0a88:	9608      	str	r6, [sp, #32]
c0de0a8a:	f04f 0c00 	mov.w	ip, #0
c0de0a8e:	2001      	movs	r0, #1
c0de0a90:	270a      	movs	r7, #10
                        (((ulIdx * ulBase) <= ulValue) &&
c0de0a92:	42b7      	cmp	r7, r6
c0de0a94:	d902      	bls.n	c0de0a9c <mcu_usb_printf+0x184>
c0de0a96:	f04f 0b01 	mov.w	fp, #1
c0de0a9a:	e010      	b.n	c0de0abe <mcu_usb_printf+0x1a6>
                    for(ulIdx = 1;
c0de0a9c:	f1a8 0301 	sub.w	r3, r8, #1
c0de0aa0:	4639      	mov	r1, r7
c0de0aa2:	bf00      	nop
c0de0aa4:	468b      	mov	fp, r1
                        (((ulIdx * ulBase) <= ulValue) &&
c0de0aa6:	fba7 1501 	umull	r1, r5, r7, r1
c0de0aaa:	2d00      	cmp	r5, #0
c0de0aac:	bf18      	it	ne
c0de0aae:	2501      	movne	r5, #1
c0de0ab0:	42b1      	cmp	r1, r6
c0de0ab2:	4698      	mov	r8, r3
c0de0ab4:	d803      	bhi.n	c0de0abe <mcu_usb_printf+0x1a6>
                    for(ulIdx = 1;
c0de0ab6:	2d00      	cmp	r5, #0
c0de0ab8:	f1a8 0301 	sub.w	r3, r8, #1
c0de0abc:	d0f2      	beq.n	c0de0aa4 <mcu_usb_printf+0x18c>
                    if(ulNeg && (cFill == '0'))
c0de0abe:	b118      	cbz	r0, c0de0ac8 <mcu_usb_printf+0x1b0>
c0de0ac0:	2500      	movs	r5, #0
c0de0ac2:	f04f 0a01 	mov.w	sl, #1
c0de0ac6:	e00c      	b.n	c0de0ae2 <mcu_usb_printf+0x1ca>
c0de0ac8:	b2d1      	uxtb	r1, r2
c0de0aca:	2930      	cmp	r1, #48	; 0x30
c0de0acc:	d106      	bne.n	c0de0adc <mcu_usb_printf+0x1c4>
                        pcBuf[ulPos++] = '-';
c0de0ace:	212d      	movs	r1, #45	; 0x2d
c0de0ad0:	f04f 0a01 	mov.w	sl, #1
c0de0ad4:	2501      	movs	r5, #1
c0de0ad6:	f88d 1010 	strb.w	r1, [sp, #16]
c0de0ada:	e002      	b.n	c0de0ae2 <mcu_usb_printf+0x1ca>
c0de0adc:	f04f 0a00 	mov.w	sl, #0
c0de0ae0:	2500      	movs	r5, #0
c0de0ae2:	f080 0001 	eor.w	r0, r0, #1
c0de0ae6:	eba8 0100 	sub.w	r1, r8, r0
                    if((ulCount > 1) && (ulCount < 16))
c0de0aea:	1e8b      	subs	r3, r1, #2
c0de0aec:	2b0d      	cmp	r3, #13
c0de0aee:	d811      	bhi.n	c0de0b14 <mcu_usb_printf+0x1fc>
c0de0af0:	3901      	subs	r1, #1
c0de0af2:	d00f      	beq.n	c0de0b14 <mcu_usb_printf+0x1fc>
c0de0af4:	4240      	negs	r0, r0
                        for(ulCount--; ulCount; ulCount--)
c0de0af6:	9001      	str	r0, [sp, #4]
c0de0af8:	a804      	add	r0, sp, #16
c0de0afa:	4428      	add	r0, r5
                            pcBuf[ulPos++] = cFill;
c0de0afc:	b2d2      	uxtb	r2, r2
c0de0afe:	f8cd c008 	str.w	ip, [sp, #8]
c0de0b02:	f000 f92a 	bl	c0de0d5a <__aeabi_memset>
                        for(ulCount--; ulCount; ulCount--)
c0de0b06:	9901      	ldr	r1, [sp, #4]
c0de0b08:	eb05 0008 	add.w	r0, r5, r8
c0de0b0c:	f8dd c008 	ldr.w	ip, [sp, #8]
c0de0b10:	4408      	add	r0, r1
c0de0b12:	1e45      	subs	r5, r0, #1
                    if(ulNeg)
c0de0b14:	f1ba 0f00 	cmp.w	sl, #0
c0de0b18:	a804      	add	r0, sp, #16
                        pcBuf[ulPos++] = '-';
c0de0b1a:	bf02      	ittt	eq
c0de0b1c:	212d      	moveq	r1, #45	; 0x2d
c0de0b1e:	5541      	strbeq	r1, [r0, r5]
c0de0b20:	3501      	addeq	r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0de0b22:	f1bb 0f00 	cmp.w	fp, #0
c0de0b26:	d015      	beq.n	c0de0b54 <mcu_usb_printf+0x23c>
c0de0b28:	4945      	ldr	r1, [pc, #276]	; (c0de0c40 <mcu_usb_printf+0x328>)
c0de0b2a:	4b46      	ldr	r3, [pc, #280]	; (c0de0c44 <mcu_usb_printf+0x32c>)
c0de0b2c:	4479      	add	r1, pc
c0de0b2e:	447b      	add	r3, pc
c0de0b30:	f1bc 0f00 	cmp.w	ip, #0
c0de0b34:	bf08      	it	eq
c0de0b36:	460b      	moveq	r3, r1
c0de0b38:	fbb6 f1fb 	udiv	r1, r6, fp
c0de0b3c:	455f      	cmp	r7, fp
c0de0b3e:	fbb1 f2f7 	udiv	r2, r1, r7
c0de0b42:	fbbb fbf7 	udiv	fp, fp, r7
c0de0b46:	fb02 1117 	mls	r1, r2, r7, r1
c0de0b4a:	5c59      	ldrb	r1, [r3, r1]
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0de0b4c:	5541      	strb	r1, [r0, r5]
c0de0b4e:	f105 0501 	add.w	r5, r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0de0b52:	d9f1      	bls.n	c0de0b38 <mcu_usb_printf+0x220>
                    mcu_usb_prints(pcBuf, ulPos);
c0de0b54:	4629      	mov	r1, r5
c0de0b56:	e01d      	b.n	c0de0b94 <mcu_usb_printf+0x27c>
c0de0b58:	4935      	ldr	r1, [pc, #212]	; (c0de0c30 <mcu_usb_printf+0x318>)
c0de0b5a:	4479      	add	r1, pc
c0de0b5c:	e001      	b.n	c0de0b62 <mcu_usb_printf+0x24a>
c0de0b5e:	4935      	ldr	r1, [pc, #212]	; (c0de0c34 <mcu_usb_printf+0x31c>)
c0de0b60:	4479      	add	r1, pc
c0de0b62:	468c      	mov	ip, r1
c0de0b64:	2101      	movs	r1, #1
                    pcStr = va_arg(vaArgP, char *);
c0de0b66:	9a03      	ldr	r2, [sp, #12]
                    switch(cStrlenSet) {
c0de0b68:	b2c0      	uxtb	r0, r0
                    pcStr = va_arg(vaArgP, char *);
c0de0b6a:	1d13      	adds	r3, r2, #4
c0de0b6c:	9303      	str	r3, [sp, #12]
c0de0b6e:	6816      	ldr	r6, [r2, #0]
                    switch(cStrlenSet) {
c0de0b70:	b1c0      	cbz	r0, c0de0ba4 <mcu_usb_printf+0x28c>
c0de0b72:	2801      	cmp	r0, #1
c0de0b74:	d020      	beq.n	c0de0bb8 <mcu_usb_printf+0x2a0>
c0de0b76:	2802      	cmp	r0, #2
c0de0b78:	d11d      	bne.n	c0de0bb6 <mcu_usb_printf+0x29e>
                        if (pcStr[0] == '\0') {
c0de0b7a:	7830      	ldrb	r0, [r6, #0]
c0de0b7c:	b3c0      	cbz	r0, c0de0bf0 <mcu_usb_printf+0x2d8>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    mcu_usb_prints("ERROR", 5);
c0de0b7e:	482a      	ldr	r0, [pc, #168]	; (c0de0c28 <mcu_usb_printf+0x310>)
c0de0b80:	2105      	movs	r1, #5
c0de0b82:	4478      	add	r0, pc
c0de0b84:	e006      	b.n	c0de0b94 <mcu_usb_printf+0x27c>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0b86:	9803      	ldr	r0, [sp, #12]
c0de0b88:	1d01      	adds	r1, r0, #4
c0de0b8a:	9103      	str	r1, [sp, #12]
c0de0b8c:	6800      	ldr	r0, [r0, #0]
c0de0b8e:	9008      	str	r0, [sp, #32]
                    mcu_usb_prints((char *)&ulValue, 1);
c0de0b90:	a808      	add	r0, sp, #32
c0de0b92:	2101      	movs	r1, #1
c0de0b94:	f7ff feaa 	bl	c0de08ec <mcu_usb_prints>
    while(*format)
c0de0b98:	f814 0d01 	ldrb.w	r0, [r4, #-1]!
c0de0b9c:	2800      	cmp	r0, #0
c0de0b9e:	f47f aecd 	bne.w	c0de093c <mcu_usb_printf+0x24>
c0de0ba2:	e03b      	b.n	c0de0c1c <mcu_usb_printf+0x304>
c0de0ba4:	2000      	movs	r0, #0
c0de0ba6:	bf00      	nop
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0de0ba8:	5c32      	ldrb	r2, [r6, r0]
c0de0baa:	3001      	adds	r0, #1
c0de0bac:	2a00      	cmp	r2, #0
c0de0bae:	d1fb      	bne.n	c0de0ba8 <mcu_usb_printf+0x290>
                    switch(ulBase) {
c0de0bb0:	f1a0 0a01 	sub.w	sl, r0, #1
c0de0bb4:	e000      	b.n	c0de0bb8 <mcu_usb_printf+0x2a0>
c0de0bb6:	46ba      	mov	sl, r7
c0de0bb8:	b1a9      	cbz	r1, c0de0be6 <mcu_usb_printf+0x2ce>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0de0bba:	f1ba 0f00 	cmp.w	sl, #0
c0de0bbe:	4665      	mov	r5, ip
c0de0bc0:	d0ea      	beq.n	c0de0b98 <mcu_usb_printf+0x280>
c0de0bc2:	bf00      	nop
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0de0bc4:	f816 0b01 	ldrb.w	r0, [r6], #1
c0de0bc8:	2101      	movs	r1, #1
                          nibble2 = pcStr[ulCount]&0xF;
c0de0bca:	f000 070f 	and.w	r7, r0, #15
c0de0bce:	eb05 1010 	add.w	r0, r5, r0, lsr #4
c0de0bd2:	f7ff fe8b 	bl	c0de08ec <mcu_usb_prints>
c0de0bd6:	19e8      	adds	r0, r5, r7
c0de0bd8:	2101      	movs	r1, #1
c0de0bda:	f7ff fe87 	bl	c0de08ec <mcu_usb_prints>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0de0bde:	f1ba 0a01 	subs.w	sl, sl, #1
c0de0be2:	d1ef      	bne.n	c0de0bc4 <mcu_usb_printf+0x2ac>
c0de0be4:	e7d8      	b.n	c0de0b98 <mcu_usb_printf+0x280>
                        mcu_usb_prints(pcStr, ulIdx);
c0de0be6:	4630      	mov	r0, r6
c0de0be8:	4651      	mov	r1, sl
c0de0bea:	f7ff fe7f 	bl	c0de08ec <mcu_usb_prints>
c0de0bee:	e009      	b.n	c0de0c04 <mcu_usb_printf+0x2ec>
                          do {
c0de0bf0:	f10a 0501 	add.w	r5, sl, #1
                            mcu_usb_prints(" ", 1);
c0de0bf4:	4810      	ldr	r0, [pc, #64]	; (c0de0c38 <mcu_usb_printf+0x320>)
c0de0bf6:	2101      	movs	r1, #1
c0de0bf8:	4478      	add	r0, pc
c0de0bfa:	f7ff fe77 	bl	c0de08ec <mcu_usb_prints>
                          } while(ulStrlen-- > 0);
c0de0bfe:	3d01      	subs	r5, #1
c0de0c00:	d1f8      	bne.n	c0de0bf4 <mcu_usb_printf+0x2dc>
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0de0c02:	46ba      	mov	sl, r7
                    if(ulCount > ulIdx)
c0de0c04:	45d0      	cmp	r8, sl
c0de0c06:	d9c7      	bls.n	c0de0b98 <mcu_usb_printf+0x280>
                        while(ulCount--)
c0de0c08:	ebaa 0508 	sub.w	r5, sl, r8
                            mcu_usb_prints(" ", 1);
c0de0c0c:	480b      	ldr	r0, [pc, #44]	; (c0de0c3c <mcu_usb_printf+0x324>)
c0de0c0e:	2101      	movs	r1, #1
c0de0c10:	4478      	add	r0, pc
c0de0c12:	f7ff fe6b 	bl	c0de08ec <mcu_usb_prints>
                        while(ulCount--)
c0de0c16:	3501      	adds	r5, #1
c0de0c18:	d3f8      	bcc.n	c0de0c0c <mcu_usb_printf+0x2f4>
c0de0c1a:	e7bd      	b.n	c0de0b98 <mcu_usb_printf+0x280>

    //
    // End the varargs processing.
    //
    va_end(vaArgP);
}
c0de0c1c:	b009      	add	sp, #36	; 0x24
c0de0c1e:	e8bd 4df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de0c22:	b003      	add	sp, #12
c0de0c24:	4770      	bx	lr
c0de0c26:	bf00      	nop
c0de0c28:	00000411 	.word	0x00000411
c0de0c2c:	00000632 	.word	0x00000632
c0de0c30:	00000560 	.word	0x00000560
c0de0c34:	0000054a 	.word	0x0000054a
c0de0c38:	00000299 	.word	0x00000299
c0de0c3c:	00000281 	.word	0x00000281
c0de0c40:	0000057e 	.word	0x0000057e
c0de0c44:	0000058c 	.word	0x0000058c

c0de0c48 <pic_internal>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
__attribute__((naked,no_instrument_function)) void *pic_internal(void *link_address)
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");
c0de0c48:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");
c0de0c4a:	4902      	ldr	r1, [pc, #8]	; (c0de0c54 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");
c0de0c4c:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");
c0de0c4e:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");
c0de0c50:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0de0c52:	4770      	bx	lr
c0de0c54:	c0de0c49 	.word	0xc0de0c49

c0de0c58 <pic>:

void *pic(void *link_address) {
  void *n, *en;

  // check if in the LINKED TEXT zone
  __asm volatile("ldr %0, =_nvram":"=r"(n));
c0de0c58:	490a      	ldr	r1, [pc, #40]	; (c0de0c84 <pic+0x2c>)
  __asm volatile("ldr %0, =_envram":"=r"(en));
  if (link_address >= n && link_address <= en) {
c0de0c5a:	4281      	cmp	r1, r0
  __asm volatile("ldr %0, =_envram":"=r"(en));
c0de0c5c:	490a      	ldr	r1, [pc, #40]	; (c0de0c88 <pic+0x30>)
  if (link_address >= n && link_address <= en) {
c0de0c5e:	d806      	bhi.n	c0de0c6e <pic+0x16>
c0de0c60:	4281      	cmp	r1, r0
c0de0c62:	d304      	bcc.n	c0de0c6e <pic+0x16>
c0de0c64:	b580      	push	{r7, lr}
    link_address = pic_internal(link_address);
c0de0c66:	f7ff ffef 	bl	c0de0c48 <pic_internal>
c0de0c6a:	e8bd 4080 	ldmia.w	sp!, {r7, lr}
  }

  // check if in the LINKED RAM zone
  __asm volatile("ldr %0, =_bss":"=r"(n));
c0de0c6e:	4907      	ldr	r1, [pc, #28]	; (c0de0c8c <pic+0x34>)
  __asm volatile("ldr %0, =_estack":"=r"(en));
  if (link_address >= n && link_address <= en) {
c0de0c70:	4288      	cmp	r0, r1
  __asm volatile("ldr %0, =_estack":"=r"(en));
c0de0c72:	4a07      	ldr	r2, [pc, #28]	; (c0de0c90 <pic+0x38>)
  if (link_address >= n && link_address <= en) {
c0de0c74:	d305      	bcc.n	c0de0c82 <pic+0x2a>
c0de0c76:	4290      	cmp	r0, r2
    __asm volatile("mov %0, r9":"=r"(en));
    // deref into the RAM therefore add the RAM offset from R9
    link_address = (char *)link_address - (char *)n + (char *)en;
  }

  return link_address;
c0de0c78:	bf88      	it	hi
c0de0c7a:	4770      	bxhi	lr
    link_address = (char *)link_address - (char *)n + (char *)en;
c0de0c7c:	1a40      	subs	r0, r0, r1
    __asm volatile("mov %0, r9":"=r"(en));
c0de0c7e:	464a      	mov	r2, r9
    link_address = (char *)link_address - (char *)n + (char *)en;
c0de0c80:	4410      	add	r0, r2
  return link_address;
c0de0c82:	4770      	bx	lr
c0de0c84:	c0de0000 	.word	0xc0de0000
c0de0c88:	c0de1200 	.word	0xc0de1200
c0de0c8c:	da7a0000 	.word	0xda7a0000
c0de0c90:	da7a7800 	.word	0xda7a7800

c0de0c94 <SVC_Call>:
.thumb
.thumb_func
.global SVC_Call

SVC_Call:
    svc 1
c0de0c94:	df01      	svc	1
    cmp r1, #0
c0de0c96:	2900      	cmp	r1, #0
    bne exception
c0de0c98:	d100      	bne.n	c0de0c9c <exception>
    bx lr
c0de0c9a:	4770      	bx	lr

c0de0c9c <exception>:
exception:
    // THROW(ex);
    mov r0, r1
c0de0c9c:	4608      	mov	r0, r1
    bl os_longjmp
c0de0c9e:	f7ff fe17 	bl	c0de08d0 <os_longjmp>

c0de0ca2 <get_api_level>:
#include <string.h>

unsigned int SVC_Call(unsigned int syscall_id, void *parameters);
unsigned int SVC_cx_call(unsigned int syscall_id, unsigned int * parameters);

unsigned int get_api_level(void) {
c0de0ca2:	b580      	push	{r7, lr}
c0de0ca4:	b082      	sub	sp, #8
c0de0ca6:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[0] = 0;
c0de0ca8:	e9cd 0000 	strd	r0, r0, [sp]
c0de0cac:	4669      	mov	r1, sp
  parameters[1] = 0;
  return SVC_Call(SYSCALL_get_api_level_ID, parameters);
c0de0cae:	2001      	movs	r0, #1
c0de0cb0:	f7ff fff0 	bl	c0de0c94 <SVC_Call>
c0de0cb4:	b002      	add	sp, #8
c0de0cb6:	bd80      	pop	{r7, pc}

c0de0cb8 <os_lib_call>:
  SVC_Call(SYSCALL_os_ux_result_ID, parameters);
  return;
}
#endif // !defined(APP_UX)

void os_lib_call ( unsigned int * call_parameters ) {
c0de0cb8:	b580      	push	{r7, lr}
c0de0cba:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)call_parameters;
c0de0cbc:	9000      	str	r0, [sp, #0]
c0de0cbe:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0cc0:	9001      	str	r0, [sp, #4]
c0de0cc2:	4803      	ldr	r0, [pc, #12]	; (c0de0cd0 <os_lib_call+0x18>)
c0de0cc4:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_call_ID, parameters);
c0de0cc6:	f7ff ffe5 	bl	c0de0c94 <SVC_Call>
  return;
}
c0de0cca:	b002      	add	sp, #8
c0de0ccc:	bd80      	pop	{r7, pc}
c0de0cce:	bf00      	nop
c0de0cd0:	01000067 	.word	0x01000067

c0de0cd4 <os_lib_end>:

void os_lib_end ( void ) {
c0de0cd4:	b580      	push	{r7, lr}
c0de0cd6:	b082      	sub	sp, #8
c0de0cd8:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[1] = 0;
c0de0cda:	9001      	str	r0, [sp, #4]
c0de0cdc:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_end_ID, parameters);
c0de0cde:	2068      	movs	r0, #104	; 0x68
c0de0ce0:	f7ff ffd8 	bl	c0de0c94 <SVC_Call>
  return;
}
c0de0ce4:	b002      	add	sp, #8
c0de0ce6:	bd80      	pop	{r7, pc}

c0de0ce8 <os_sched_exit>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_exec_ID, parameters);
  return;
}

void __attribute__((noreturn)) os_sched_exit ( bolos_task_status_t exit_code ) {
c0de0ce8:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)exit_code;
c0de0cea:	9000      	str	r0, [sp, #0]
c0de0cec:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0cee:	9001      	str	r0, [sp, #4]
c0de0cf0:	4803      	ldr	r0, [pc, #12]	; (c0de0d00 <os_sched_exit+0x18>)
c0de0cf2:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_sched_exit_ID, parameters);
c0de0cf4:	f7ff ffce 	bl	c0de0c94 <SVC_Call>

  // The os_sched_exit syscall should never return. Just in case, prevent the
  // device from freezing (because of the following infinite loop) thanks to an
  // undefined instruction.
  asm volatile ("udf #255");
c0de0cf8:	deff      	udf	#255	; 0xff
c0de0cfa:	bf00      	nop

  // remove the warning caused by -Winvalid-noreturn
  while (1) {
c0de0cfc:	e7fe      	b.n	c0de0cfc <os_sched_exit+0x14>
c0de0cfe:	bf00      	nop
c0de0d00:	0100009a 	.word	0x0100009a

c0de0d04 <io_seph_send>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_kill_ID, parameters);
  return;
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) {
c0de0d04:	b580      	push	{r7, lr}
c0de0d06:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)buffer;
c0de0d08:	e9cd 0100 	strd	r0, r1, [sp]
c0de0d0c:	4802      	ldr	r0, [pc, #8]	; (c0de0d18 <io_seph_send+0x14>)
c0de0d0e:	4669      	mov	r1, sp
  parameters[1] = (unsigned int)length;
  SVC_Call(SYSCALL_io_seph_send_ID, parameters);
c0de0d10:	f7ff ffc0 	bl	c0de0c94 <SVC_Call>
  return;
}
c0de0d14:	b002      	add	sp, #8
c0de0d16:	bd80      	pop	{r7, pc}
c0de0d18:	02000083 	.word	0x02000083

c0de0d1c <try_context_get>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_nvm_erase_page_ID, parameters);
  return;
}

try_context_t * try_context_get ( void ) {
c0de0d1c:	b580      	push	{r7, lr}
c0de0d1e:	b082      	sub	sp, #8
c0de0d20:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[1] = 0;
c0de0d22:	9001      	str	r0, [sp, #4]
c0de0d24:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_get_ID, parameters);
c0de0d26:	2087      	movs	r0, #135	; 0x87
c0de0d28:	f7ff ffb4 	bl	c0de0c94 <SVC_Call>
c0de0d2c:	b002      	add	sp, #8
c0de0d2e:	bd80      	pop	{r7, pc}

c0de0d30 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t *context ) {
c0de0d30:	b580      	push	{r7, lr}
c0de0d32:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)context;
c0de0d34:	9000      	str	r0, [sp, #0]
c0de0d36:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0d38:	9001      	str	r0, [sp, #4]
c0de0d3a:	4803      	ldr	r0, [pc, #12]	; (c0de0d48 <try_context_set+0x18>)
c0de0d3c:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_set_ID, parameters);
c0de0d3e:	f7ff ffa9 	bl	c0de0c94 <SVC_Call>
c0de0d42:	b002      	add	sp, #8
c0de0d44:	bd80      	pop	{r7, pc}
c0de0d46:	bf00      	nop
c0de0d48:	0100010b 	.word	0x0100010b

c0de0d4c <__aeabi_memclr>:
c0de0d4c:	2200      	movs	r2, #0
c0de0d4e:	f000 b804 	b.w	c0de0d5a <__aeabi_memset>

c0de0d52 <__aeabi_memcpy>:
c0de0d52:	f000 b817 	b.w	c0de0d84 <memcpy>

c0de0d56 <__aeabi_memmove>:
c0de0d56:	f000 b822 	b.w	c0de0d9e <memmove>

c0de0d5a <__aeabi_memset>:
c0de0d5a:	4613      	mov	r3, r2
c0de0d5c:	460a      	mov	r2, r1
c0de0d5e:	4619      	mov	r1, r3
c0de0d60:	f000 b837 	b.w	c0de0dd2 <memset>

c0de0d64 <memcmp>:
c0de0d64:	3901      	subs	r1, #1
c0de0d66:	4402      	add	r2, r0
c0de0d68:	b510      	push	{r4, lr}
c0de0d6a:	4290      	cmp	r0, r2
c0de0d6c:	d101      	bne.n	c0de0d72 <memcmp+0xe>
c0de0d6e:	2000      	movs	r0, #0
c0de0d70:	e005      	b.n	c0de0d7e <memcmp+0x1a>
c0de0d72:	7803      	ldrb	r3, [r0, #0]
c0de0d74:	f811 4f01 	ldrb.w	r4, [r1, #1]!
c0de0d78:	42a3      	cmp	r3, r4
c0de0d7a:	d001      	beq.n	c0de0d80 <memcmp+0x1c>
c0de0d7c:	1b18      	subs	r0, r3, r4
c0de0d7e:	bd10      	pop	{r4, pc}
c0de0d80:	3001      	adds	r0, #1
c0de0d82:	e7f2      	b.n	c0de0d6a <memcmp+0x6>

c0de0d84 <memcpy>:
c0de0d84:	440a      	add	r2, r1
c0de0d86:	1e43      	subs	r3, r0, #1
c0de0d88:	4291      	cmp	r1, r2
c0de0d8a:	d100      	bne.n	c0de0d8e <memcpy+0xa>
c0de0d8c:	4770      	bx	lr
c0de0d8e:	b510      	push	{r4, lr}
c0de0d90:	f811 4b01 	ldrb.w	r4, [r1], #1
c0de0d94:	4291      	cmp	r1, r2
c0de0d96:	f803 4f01 	strb.w	r4, [r3, #1]!
c0de0d9a:	d1f9      	bne.n	c0de0d90 <memcpy+0xc>
c0de0d9c:	bd10      	pop	{r4, pc}

c0de0d9e <memmove>:
c0de0d9e:	4288      	cmp	r0, r1
c0de0da0:	b510      	push	{r4, lr}
c0de0da2:	eb01 0402 	add.w	r4, r1, r2
c0de0da6:	d902      	bls.n	c0de0dae <memmove+0x10>
c0de0da8:	4284      	cmp	r4, r0
c0de0daa:	4623      	mov	r3, r4
c0de0dac:	d807      	bhi.n	c0de0dbe <memmove+0x20>
c0de0dae:	1e43      	subs	r3, r0, #1
c0de0db0:	42a1      	cmp	r1, r4
c0de0db2:	d008      	beq.n	c0de0dc6 <memmove+0x28>
c0de0db4:	f811 2b01 	ldrb.w	r2, [r1], #1
c0de0db8:	f803 2f01 	strb.w	r2, [r3, #1]!
c0de0dbc:	e7f8      	b.n	c0de0db0 <memmove+0x12>
c0de0dbe:	4402      	add	r2, r0
c0de0dc0:	4601      	mov	r1, r0
c0de0dc2:	428a      	cmp	r2, r1
c0de0dc4:	d100      	bne.n	c0de0dc8 <memmove+0x2a>
c0de0dc6:	bd10      	pop	{r4, pc}
c0de0dc8:	f813 4d01 	ldrb.w	r4, [r3, #-1]!
c0de0dcc:	f802 4d01 	strb.w	r4, [r2, #-1]!
c0de0dd0:	e7f7      	b.n	c0de0dc2 <memmove+0x24>

c0de0dd2 <memset>:
c0de0dd2:	4402      	add	r2, r0
c0de0dd4:	4603      	mov	r3, r0
c0de0dd6:	4293      	cmp	r3, r2
c0de0dd8:	d100      	bne.n	c0de0ddc <memset+0xa>
c0de0dda:	4770      	bx	lr
c0de0ddc:	f803 1b01 	strb.w	r1, [r3], #1
c0de0de0:	e7f9      	b.n	c0de0dd6 <memset+0x4>
	...

c0de0de4 <setjmp>:
c0de0de4:	46ec      	mov	ip, sp
c0de0de6:	e8a0 5ff0 	stmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
c0de0dea:	f04f 0000 	mov.w	r0, #0
c0de0dee:	4770      	bx	lr

c0de0df0 <longjmp>:
c0de0df0:	e8b0 5ff0 	ldmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
c0de0df4:	46e5      	mov	sp, ip
c0de0df6:	0008      	movs	r0, r1
c0de0df8:	bf08      	it	eq
c0de0dfa:	2001      	moveq	r0, #1
c0de0dfc:	4770      	bx	lr
c0de0dfe:	bf00      	nop

c0de0e00 <strlcpy>:
c0de0e00:	460b      	mov	r3, r1
c0de0e02:	b510      	push	{r4, lr}
c0de0e04:	b162      	cbz	r2, c0de0e20 <strlcpy+0x20>
c0de0e06:	3a01      	subs	r2, #1
c0de0e08:	d008      	beq.n	c0de0e1c <strlcpy+0x1c>
c0de0e0a:	f813 4b01 	ldrb.w	r4, [r3], #1
c0de0e0e:	f800 4b01 	strb.w	r4, [r0], #1
c0de0e12:	2c00      	cmp	r4, #0
c0de0e14:	d1f7      	bne.n	c0de0e06 <strlcpy+0x6>
c0de0e16:	1a58      	subs	r0, r3, r1
c0de0e18:	3801      	subs	r0, #1
c0de0e1a:	bd10      	pop	{r4, pc}
c0de0e1c:	2200      	movs	r2, #0
c0de0e1e:	7002      	strb	r2, [r0, #0]
c0de0e20:	f813 2b01 	ldrb.w	r2, [r3], #1
c0de0e24:	2a00      	cmp	r2, #0
c0de0e26:	d1fb      	bne.n	c0de0e20 <strlcpy+0x20>
c0de0e28:	e7f5      	b.n	c0de0e16 <strlcpy+0x16>

c0de0e2a <strnlen>:
c0de0e2a:	4602      	mov	r2, r0
c0de0e2c:	4401      	add	r1, r0
c0de0e2e:	b510      	push	{r4, lr}
c0de0e30:	428a      	cmp	r2, r1
c0de0e32:	4613      	mov	r3, r2
c0de0e34:	d003      	beq.n	c0de0e3e <strnlen+0x14>
c0de0e36:	781c      	ldrb	r4, [r3, #0]
c0de0e38:	3201      	adds	r2, #1
c0de0e3a:	2c00      	cmp	r4, #0
c0de0e3c:	d1f8      	bne.n	c0de0e30 <strnlen+0x6>
c0de0e3e:	1a18      	subs	r0, r3, r0
c0de0e40:	bd10      	pop	{r4, pc}

c0de0e42 <COWSWAP_DEPOSIT_SELECTOR>:
c0de0e42:	e3d0 b00d 0000                              ......

c0de0e48 <COWSWAP_SELECTORS>:
c0de0e48:	0e42 c0de                                   B...

c0de0e4c <PLUGIN_ETH_ADDRESS>:
c0de0e4c:	eeee eeee eeee eeee eeee eeee eeee eeee     ................
c0de0e5c:	eeee eeee 6148 646e 696c 676e 6d20 7365     ....Handling mes
c0de0e6c:	6173 6567 2520 0a64 5300 6e65 0064 4c53     sage %d..Send.SL
c0de0e7c:	3549 2520 0a64 5300 494c 2032 6425 000a     I5 %d..SLI2 %d..
c0de0e8c:	4c53 3349 2520 0a64 2000 5000 7261 6d61     SLI3 %d.. .Param
c0de0e9c:	6e20 746f 7320 7075 6f70 7472 6465 000a      not supported..
c0de0eac:	4c53 3149 2520 0a64 2500 3230 0078 6f43     SLI1 %d..%02x.Co
c0de0ebc:	2057 7753 7061 4500 6874 7265 7565 006d     W Swap.Ethereum.
c0de0ecc:	0030 6553 7474 6e69 2067 6461 7264 7365     0.Setting addres
c0de0edc:	2073 6572 6563 7669 6465 7420 3a6f 0020     s received to: .
c0de0eec:	7845 6563 7470 6f69 206e 7830 7825 6320     Exception 0x%x c
c0de0efc:	7561 6867 0a74 6f00 6666 6573 3a74 2520     aught..offset: %
c0de0f0c:	2c64 6320 6568 6b63 6f70 6e69 3a74 2520     d, checkpoint: %
c0de0f1c:	2c64 7020 7261 6d61 7465 7265 664f 7366     d, parameterOffs
c0de0f2c:	7465 203a 6425 000a 4c53 3649 2520 0a64     et: %d..SLI6 %d.
c0de0f3c:	5300 494c 2034 6425 000a 6f43 746e 7865     .SLI4 %d..Contex
c0de0f4c:	2074 6f6e 2074 6176 696c 0a64 5000 756c     t not valid..Plu
c0de0f5c:	6967 206e 7270 766f 6469 2065 6f74 656b     gin provide toke
c0de0f6c:	736e 3a20 3020 2578 2c70 3020 2578 0a70     ns : 0x%p, 0x%p.
c0de0f7c:	6500 6378 7065 6974 6e6f 255b 5d64 203a     .exception[%d]: 
c0de0f8c:	524c 303d 2578 3830 0a58 4500 5252 524f     LR=0x%08X..ERROR
c0de0f9c:	4d00 7369 6973 676e 7320 6c65 6365 6f74     .Missing selecto
c0de0fac:	4972 646e 7865 000a 6e55 6168 646e 656c     rIndex..Unhandle
c0de0fbc:	2064 656d 7373 6761 2065 6425 000a 6553     d message %d..Se
c0de0fcc:	7474 6e69 2067 6461 7264 7365 2073 6573     tting address se
c0de0fdc:	746e 7420 3a6f 0020 206c 7325 000a 000a     nt to: .l %s....
c0de0fec:	6c50 6775 6e69 7020 6f72 6976 6564 7020     Plugin provide p
c0de0ffc:	7261 6d61 7465 7265 203a 4100 4f4d 4e55     arameter: .AMOUN
c0de100c:	2054 4553 544e 203a 7325 000a 6e69 2074     T SENT: %s..int 
c0de101c:	7325 000a 5300 6c65 6365 6f74 2072 6e49     %s...Selector In
c0de102c:	6564 2078 253a 2064 6f6e 2074 7573 7070     dex :%d not supp
c0de103c:	726f 6574 0a64 5500 686e 6e61 6c64 6465     orted..Unhandled
c0de104c:	7320 6c65 6365 6f74 2072 6e49 6564 3a78      selector Index:
c0de105c:	2520 0a64 4400 7065 736f 7469 5300 6c65      %d..Deposit.Sel
c0de106c:	6365 6f74 2072 6e49 6564 2078 6425 6e20     ector Index %d n
c0de107c:	746f 7320 7075 6f70 7472 6465 000a 6552     ot supported..Re
c0de108c:	6563 7669 6465 6120 206e 6e69 6176 696c     ceived an invali
c0de109c:	2064 6373 6572 6e65 6e49 6564 2078 6425     d screenIndex %d
c0de10ac:	000a                                        ..

c0de10ae <g_pcHex>:
c0de10ae:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef

c0de10be <g_pcHex_cap>:
c0de10be:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF

c0de10ce <NULL_ETH_ADDRESS>:
	...

c0de10e4 <_etext>:
	...
