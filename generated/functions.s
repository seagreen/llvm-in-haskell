	.text
	.file	"<string>"
	.globl	double                  # -- Begin function double
	.p2align	4, 0x90
	.type	double,@function
double:                                 # @double
	.cfi_startproc
# %bb.0:
	leaq	(%rdi,%rdi), %rax
	retq
.Lfunc_end0:
	.size	double, .Lfunc_end0-double
	.cfi_endproc
                                        # -- End function
	.globl	plus_one                # -- Begin function plus_one
	.p2align	4, 0x90
	.type	plus_one,@function
plus_one:                               # @plus_one
	.cfi_startproc
# %bb.0:
	leaq	1(%rdi), %rax
	retq
.Lfunc_end1:
	.size	plus_one, .Lfunc_end1-plus_one
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$2, %edi
	callq	double
	movq	%rax, %rdi
	callq	plus_one
	movq	%rax, %rcx
	movl	$fmt, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	fmt,@object             # @fmt
	.section	.rodata.str1.1,"aMS",@progbits,1
	.globl	fmt
fmt:
	.asciz	"%d\n"
	.size	fmt, 4


	.section	".note.GNU-stack","",@progbits
