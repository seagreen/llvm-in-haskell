	.text
	.file	"<string>"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$fmt, %edi
	movl	$hello, %esi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	fmt,@object             # @fmt
	.section	.rodata.str1.1,"aMS",@progbits,1
	.globl	fmt
fmt:
	.asciz	"%s\n"
	.size	fmt, 4

	.type	hello,@object           # @hello
	.globl	hello
hello:
	.asciz	"hello world"
	.size	hello, 12


	.section	".note.GNU-stack","",@progbits
