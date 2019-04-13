	.text
	.file	"<string>"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %Entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movb	$1, %al
	testb	%al, %al
	jne	.LBB0_2
# %bb.1:                                # %IfEqual
	movl	$4, %esi
	jmp	.LBB0_3
.LBB0_2:                                # %IfUnequal
	movl	$6, %esi
.LBB0_3:                                # %End
	movl	$fmt, %edi
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
	.asciz	"%d\n"
	.size	fmt, 4


	.section	".note.GNU-stack","",@progbits
