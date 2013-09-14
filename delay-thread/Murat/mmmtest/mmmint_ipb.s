	.file	"mmmintseq_org.bc"
	.text
	.globl	Print
	.align	16, 0x90
	.type	Print,@function
Print:                                  # @Print
# BB#0:                                 # %entry
	subl	$44, %esp
	movl	48(%esp), %eax
	movl	%eax, 40(%esp)
	movl	52(%esp), %eax
	movl	%eax, 36(%esp)
	movl	56(%esp), %eax
	movl	%eax, 32(%esp)
	movl	%eax, (%esp)
	movl	$.L.str, 4(%esp)
	call	fopen
	movl	%eax, 20(%esp)
	movl	%eax, 12(%esp)
	movl	$10, 8(%esp)
	movl	$1, 4(%esp)
	movl	$.L.str1, (%esp)
	call	fwrite
	movl	$0, 28(%esp)
	jmp	.LBB1_5
	.align	16, 0x90
.LBB1_1:                                # %bb
                                        #   in Loop: Header=BB1_5 Depth=1
	movl	20(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$5, 8(%esp)
	movl	$1, 4(%esp)
	movl	$.L.str2, (%esp)
	call	fwrite
	movl	$0, 24(%esp)
	jmp	.LBB1_3
	.align	16, 0x90
.LBB1_2:                                # %bb1
                                        #   in Loop: Header=BB1_3 Depth=2
	movl	28(%esp), %eax
	imull	36(%esp), %eax
	addl	24(%esp), %eax
	movl	40(%esp), %ecx
	movl	(%ecx,%eax,4), %eax
	movl	20(%esp), %ecx
	movl	%eax, 8(%esp)
	movl	%ecx, (%esp)
	movl	$.L.str3, 4(%esp)
	call	fprintf
	incl	24(%esp)
.LBB1_3:                                # %bb2
                                        #   Parent Loop BB1_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	36(%esp), %eax
	cmpl	%eax, 24(%esp)
	jl	.LBB1_2
# BB#4:                                 # %bb3
                                        #   in Loop: Header=BB1_5 Depth=1
	movl	20(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$10, (%esp)
	call	fputc
	incl	28(%esp)
.LBB1_5:                                # %bb4
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_3 Depth 2
	movl	36(%esp), %eax
	cmpl	%eax, 28(%esp)
	jl	.LBB1_1
# BB#6:                                 # %return
	addl	$44, %esp
	ret
	.size	Print, .-Print

	.globl	MatMulKernel_T1
	.align	16, 0x90
	.type	MatMulKernel_T1,@function
MatMulKernel_T1:                        # @MatMulKernel_T1
# BB#0:                                 # %entry
	pushl	%ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$36, %esp
	movl	56(%esp), %eax
	movl	%eax, 32(%esp)
	movl	%eax, 12(%esp)
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str4, (%esp)
	call	printf
	movl	$0, 24(%esp)
	jmp	.LBB2_8
	.align	16, 0x90
.LBB2_1:                                # %bb
                                        #   in Loop: Header=BB2_8 Depth=1
	movl	$0, 20(%esp)
	jmp	.LBB2_6
	.align	16, 0x90
.LBB2_2:                                # %bb1
                                        #   in Loop: Header=BB2_6 Depth=2
	movl	$0, 16(%esp)
	jmp	.LBB2_4
	.align	16, 0x90
.LBB2_3:                                # %bb2
                                        #   in Loop: Header=BB2_4 Depth=3
	movl	12(%esp), %eax
	movl	20(%eax), %ecx
	movl	16(%esp), %edx
	movl	%ecx, %esi
	imull	%edx, %esi
	movl	20(%esp), %edi
	addl	%edi, %esi
	imull	24(%esp), %ecx
	addl	%ecx, %edx
	movl	(%eax), %ebx
	movl	4(%eax), %ebp
	movl	(%ebx,%edx,4), %edx
	imull	(%ebp,%esi,4), %edx
	addl	%edi, %ecx
	movl	8(%eax), %eax
	addl	%edx, (%eax,%ecx,4)
	incl	16(%esp)
.LBB2_4:                                # %bb3
                                        #   Parent Loop BB2_8 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	16(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 20(%ecx)
	jg	.LBB2_3
# BB#5:                                 # %bb4
                                        #   in Loop: Header=BB2_6 Depth=2
	incl	20(%esp)
.LBB2_6:                                # %bb5
                                        #   Parent Loop BB2_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_4 Depth 3
	movl	20(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB2_2
# BB#7:                                 # %bb6
                                        #   in Loop: Header=BB2_8 Depth=1
	incl	24(%esp)
.LBB2_8:                                # %bb7
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
                                        #       Child Loop BB2_4 Depth 3
	movl	24(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB2_1
# BB#9:                                 # %bb8
	movl	12(%esp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str5, (%esp)
	call	printf
	movl	28(%esp), %eax
	addl	$36, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	ret
	.size	MatMulKernel_T1, .-MatMulKernel_T1

	.globl	MatMulKernel_T2
	.align	16, 0x90
	.type	MatMulKernel_T2,@function
MatMulKernel_T2:                        # @MatMulKernel_T2
# BB#0:                                 # %entry
	pushl	%ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$36, %esp
	movl	56(%esp), %eax
	movl	%eax, 32(%esp)
	movl	%eax, 12(%esp)
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str4, (%esp)
	call	printf
	movl	$0, 24(%esp)
	jmp	.LBB3_8
	.align	16, 0x90
.LBB3_1:                                # %bb
                                        #   in Loop: Header=BB3_8 Depth=1
	movl	$0, 20(%esp)
	jmp	.LBB3_6
	.align	16, 0x90
.LBB3_2:                                # %bb1
                                        #   in Loop: Header=BB3_6 Depth=2
	movl	$0, 16(%esp)
	jmp	.LBB3_4
	.align	16, 0x90
.LBB3_3:                                # %bb2
                                        #   in Loop: Header=BB3_4 Depth=3
	movl	12(%esp), %eax
	movl	20(%eax), %ecx
	movl	16(%esp), %edx
	movl	%ecx, %esi
	imull	%edx, %esi
	movl	20(%esp), %edi
	addl	%edi, %esi
	imull	24(%esp), %ecx
	addl	%ecx, %edx
	movl	(%eax), %ebx
	movl	4(%eax), %ebp
	movl	(%ebx,%edx,4), %edx
	imull	(%ebp,%esi,4), %edx
	addl	%edi, %ecx
	movl	8(%eax), %eax
	addl	%edx, (%eax,%ecx,4)
	incl	16(%esp)
.LBB3_4:                                # %bb3
                                        #   Parent Loop BB3_8 Depth=1
                                        #     Parent Loop BB3_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	16(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 20(%ecx)
	jg	.LBB3_3
# BB#5:                                 # %bb4
                                        #   in Loop: Header=BB3_6 Depth=2
	incl	20(%esp)
.LBB3_6:                                # %bb5
                                        #   Parent Loop BB3_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_4 Depth 3
	movl	20(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB3_2
# BB#7:                                 # %bb6
                                        #   in Loop: Header=BB3_8 Depth=1
	incl	24(%esp)
.LBB3_8:                                # %bb7
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_6 Depth 2
                                        #       Child Loop BB3_4 Depth 3
	movl	24(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB3_1
# BB#9:                                 # %bb8
	movl	12(%esp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str5, (%esp)
	call	printf
	movl	28(%esp), %eax
	addl	$36, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	ret
	.size	MatMulKernel_T2, .-MatMulKernel_T2

	.globl	MatMulKernel_T3
	.align	16, 0x90
	.type	MatMulKernel_T3,@function
MatMulKernel_T3:                        # @MatMulKernel_T3
# BB#0:                                 # %entry
	pushl	%ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$36, %esp
	movl	56(%esp), %eax
	movl	%eax, 32(%esp)
	movl	%eax, 12(%esp)
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str4, (%esp)
	call	printf
	movl	$0, 24(%esp)
	jmp	.LBB4_8
	.align	16, 0x90
.LBB4_1:                                # %bb
                                        #   in Loop: Header=BB4_8 Depth=1
	movl	$0, 20(%esp)
	jmp	.LBB4_6
	.align	16, 0x90
.LBB4_2:                                # %bb1
                                        #   in Loop: Header=BB4_6 Depth=2
	movl	$0, 16(%esp)
	jmp	.LBB4_4
	.align	16, 0x90
.LBB4_3:                                # %bb2
                                        #   in Loop: Header=BB4_4 Depth=3
	movl	12(%esp), %eax
	movl	20(%eax), %ecx
	movl	16(%esp), %edx
	movl	%ecx, %esi
	imull	%edx, %esi
	movl	20(%esp), %edi
	addl	%edi, %esi
	imull	24(%esp), %ecx
	addl	%ecx, %edx
	movl	(%eax), %ebx
	movl	4(%eax), %ebp
	movl	(%ebx,%edx,4), %edx
	imull	(%ebp,%esi,4), %edx
	addl	%edi, %ecx
	movl	8(%eax), %eax
	addl	%edx, (%eax,%ecx,4)
	incl	16(%esp)
.LBB4_4:                                # %bb3
                                        #   Parent Loop BB4_8 Depth=1
                                        #     Parent Loop BB4_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	16(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 20(%ecx)
	jg	.LBB4_3
# BB#5:                                 # %bb4
                                        #   in Loop: Header=BB4_6 Depth=2
	incl	20(%esp)
.LBB4_6:                                # %bb5
                                        #   Parent Loop BB4_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_4 Depth 3
	movl	20(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB4_2
# BB#7:                                 # %bb6
                                        #   in Loop: Header=BB4_8 Depth=1
	incl	24(%esp)
.LBB4_8:                                # %bb7
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_6 Depth 2
                                        #       Child Loop BB4_4 Depth 3
	movl	24(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB4_1
# BB#9:                                 # %bb8
	movl	12(%esp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str5, (%esp)
	call	printf
	movl	28(%esp), %eax
	addl	$36, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	ret
	.size	MatMulKernel_T3, .-MatMulKernel_T3

	.globl	MatMulKernel_T4
	.align	16, 0x90
	.type	MatMulKernel_T4,@function
MatMulKernel_T4:                        # @MatMulKernel_T4
# BB#0:                                 # %entry
	pushl	%ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$36, %esp
	movl	56(%esp), %eax
	movl	%eax, 32(%esp)
	movl	%eax, 12(%esp)
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str4, (%esp)
	call	printf
	movl	$0, 24(%esp)
	jmp	.LBB5_8
	.align	16, 0x90
.LBB5_1:                                # %bb
                                        #   in Loop: Header=BB5_8 Depth=1
	movl	$0, 20(%esp)
	jmp	.LBB5_6
	.align	16, 0x90
.LBB5_2:                                # %bb1
                                        #   in Loop: Header=BB5_6 Depth=2
	movl	$0, 16(%esp)
	jmp	.LBB5_4
	.align	16, 0x90
.LBB5_3:                                # %bb2
                                        #   in Loop: Header=BB5_4 Depth=3
	movl	12(%esp), %eax
	movl	20(%eax), %ecx
	movl	16(%esp), %edx
	movl	%ecx, %esi
	imull	%edx, %esi
	movl	20(%esp), %edi
	addl	%edi, %esi
	imull	24(%esp), %ecx
	addl	%ecx, %edx
	movl	(%eax), %ebx
	movl	4(%eax), %ebp
	movl	(%ebx,%edx,4), %edx
	imull	(%ebp,%esi,4), %edx
	addl	%edi, %ecx
	movl	8(%eax), %eax
	addl	%edx, (%eax,%ecx,4)
	incl	16(%esp)
.LBB5_4:                                # %bb3
                                        #   Parent Loop BB5_8 Depth=1
                                        #     Parent Loop BB5_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	16(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 20(%ecx)
	jg	.LBB5_3
# BB#5:                                 # %bb4
                                        #   in Loop: Header=BB5_6 Depth=2
	incl	20(%esp)
.LBB5_6:                                # %bb5
                                        #   Parent Loop BB5_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_4 Depth 3
	movl	20(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB5_2
# BB#7:                                 # %bb6
                                        #   in Loop: Header=BB5_8 Depth=1
	incl	24(%esp)
.LBB5_8:                                # %bb7
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_6 Depth 2
                                        #       Child Loop BB5_4 Depth 3
	movl	24(%esp), %eax
	movl	12(%esp), %ecx
	cmpl	%eax, 16(%ecx)
	jg	.LBB5_1
# BB#9:                                 # %bb8
	movl	12(%esp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str5, (%esp)
	call	printf
	movl	28(%esp), %eax
	addl	$36, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	ret
	.size	MatMulKernel_T4, .-MatMulKernel_T4

	.globl	MatMul
	.align	16, 0x90
	.type	MatMul,@function
MatMul:                                 # @MatMul
# BB#0:                                 # %entry
	pushl	%edi
	pushl	%esi
	subl	$196, %esp
	movl	208(%esp), %eax
	movl	%eax, 192(%esp)
	movl	212(%esp), %eax
	movl	%eax, 188(%esp)
	movl	216(%esp), %eax
	movl	%eax, 184(%esp)
	movl	220(%esp), %eax
	movl	%eax, 180(%esp)
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	sarl	%ecx
	movl	%ecx, 172(%esp)
	leal	16(%esp), %esi
	movl	%esi, (%esp)
	call	pthread_attr_init
	movl	%esi, (%esp)
	movl	$0, 4(%esp)
	call	pthread_attr_setdetachstate
	movl	192(%esp), %eax
	movl	%eax, 72(%esp)
	movl	188(%esp), %eax
	movl	%eax, 76(%esp)
	movl	184(%esp), %eax
	movl	%eax, 80(%esp)
	movl	$0, 84(%esp)
	movl	172(%esp), %eax
	movl	%eax, 88(%esp)
	movl	180(%esp), %eax
	movl	%eax, 92(%esp)
	movl	192(%esp), %eax
	movl	%eax, 96(%esp)
	movl	172(%esp), %eax
	shll	$2, %eax
	addl	188(%esp), %eax
	movl	%eax, 100(%esp)
	movl	172(%esp), %eax
	shll	$2, %eax
	addl	184(%esp), %eax
	movl	%eax, 104(%esp)
	movl	$1, 108(%esp)
	movl	172(%esp), %eax
	movl	%eax, 112(%esp)
	movl	180(%esp), %eax
	movl	%eax, 116(%esp)
	movl	172(%esp), %eax
	imull	180(%esp), %eax
	shll	$2, %eax
	addl	192(%esp), %eax
	movl	%eax, 120(%esp)
	movl	188(%esp), %eax
	movl	%eax, 124(%esp)
	movl	172(%esp), %eax
	imull	180(%esp), %eax
	shll	$2, %eax
	addl	184(%esp), %eax
	movl	%eax, 128(%esp)
	movl	$2, 132(%esp)
	movl	172(%esp), %eax
	movl	%eax, 136(%esp)
	movl	180(%esp), %eax
	movl	%eax, 140(%esp)
	movl	172(%esp), %eax
	imull	180(%esp), %eax
	shll	$2, %eax
	addl	192(%esp), %eax
	movl	%eax, 144(%esp)
	movl	172(%esp), %eax
	shll	$2, %eax
	addl	188(%esp), %eax
	movl	%eax, 148(%esp)
	movl	172(%esp), %eax
	movl	%eax, %ecx
	imull	180(%esp), %ecx
	shll	$2, %ecx
	addl	184(%esp), %ecx
	leal	(%ecx,%eax,4), %eax
	movl	%eax, 152(%esp)
	movl	$3, 156(%esp)
	movl	172(%esp), %eax
	movl	%eax, 160(%esp)
	movl	180(%esp), %eax
	movl	%eax, 164(%esp)
	leal	72(%esp), %eax
	movl	%eax, 12(%esp)
	movl	%esi, 4(%esp)
	leal	56(%esp), %eax
	movl	%eax, (%esp)
	movl	$MatMulKernel_T1, 8(%esp)
	call	pthread_create
	movl	56(%esp), %eax
	leal	168(%esp), %edi
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	pthread_join
	leal	96(%esp), %eax
	movl	%eax, 12(%esp)
	movl	%esi, 4(%esp)
	leal	60(%esp), %eax
	movl	%eax, (%esp)
	movl	$MatMulKernel_T2, 8(%esp)
	call	pthread_create
	movl	60(%esp), %eax
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	pthread_join
	leal	120(%esp), %eax
	movl	%eax, 12(%esp)
	movl	%esi, 4(%esp)
	leal	64(%esp), %eax
	movl	%eax, (%esp)
	movl	$MatMulKernel_T3, 8(%esp)
	call	pthread_create
	movl	64(%esp), %eax
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	pthread_join
	leal	144(%esp), %eax
	movl	%eax, 12(%esp)
	movl	%esi, 4(%esp)
	leal	68(%esp), %eax
	movl	%eax, (%esp)
	movl	$MatMulKernel_T4, 8(%esp)
	call	pthread_create
	movl	68(%esp), %eax
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	pthread_join
	addl	$196, %esp
	popl	%esi
	popl	%edi
	ret
	.size	MatMul, .-MatMul

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
# BB#0:                                 # %entry
	pushl	%esi
	subl	$56, %esp
	movl	64(%esp), %eax
	movl	%eax, 52(%esp)
	movl	68(%esp), %eax
	movl	%eax, 48(%esp)
	cmpl	$2, 52(%esp)
	jne	.LBB7_2
# BB#1:                                 # %bb
	movl	48(%esp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	atoi
	movl	%eax, 28(%esp)
	jmp	.LBB7_3
.LBB7_2:                                # %bb1
	movl	$512, 28(%esp)          # imm = 0x200
.LBB7_3:                                # %bb2
	movl	28(%esp), %eax
	imull	%eax, %eax
	movl	%eax, (%esp)
	movl	$4, 4(%esp)
	call	calloc
	movl	%eax, 24(%esp)
	movl	28(%esp), %eax
	imull	%eax, %eax
	movl	%eax, (%esp)
	movl	$4, 4(%esp)
	call	calloc
	movl	%eax, 20(%esp)
	movl	28(%esp), %eax
	imull	%eax, %eax
	movl	%eax, (%esp)
	movl	$4, 4(%esp)
	call	calloc
	movl	%eax, 16(%esp)
	movl	$0, 36(%esp)
	jmp	.LBB7_8
	.align	16, 0x90
.LBB7_4:                                # %bb3
                                        #   in Loop: Header=BB7_8 Depth=1
	movl	$0, 32(%esp)
	jmp	.LBB7_6
	.align	16, 0x90
.LBB7_5:                                # %bb4
                                        #   in Loop: Header=BB7_6 Depth=2
	movl	36(%esp), %esi
	imull	28(%esp), %esi
	addl	32(%esp), %esi
	call	rand
	movl	24(%esp), %ecx
	movl	%eax, (%ecx,%esi,4)
	movl	36(%esp), %eax
	imull	28(%esp), %eax
	movl	32(%esp), %esi
	addl	%eax, %esi
	call	rand
	movl	20(%esp), %ecx
	movl	%eax, (%ecx,%esi,4)
	incl	32(%esp)
.LBB7_6:                                # %bb5
                                        #   Parent Loop BB7_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	28(%esp), %eax
	cmpl	%eax, 32(%esp)
	jl	.LBB7_5
# BB#7:                                 # %bb6
                                        #   in Loop: Header=BB7_8 Depth=1
	incl	36(%esp)
.LBB7_8:                                # %bb7
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_6 Depth 2
	movl	28(%esp), %eax
	cmpl	%eax, 36(%esp)
	jl	.LBB7_4
# BB#9:                                 # %bb8
	movl	24(%esp), %eax
	movl	20(%esp), %ecx
	movl	16(%esp), %edx
	movl	28(%esp), %esi
	movl	%esi, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%ecx, 4(%esp)
	movl	%eax, (%esp)
	call	MatMul
	movl	16(%esp), %eax
	movl	28(%esp), %ecx
	movl	%ecx, 4(%esp)
	movl	%eax, (%esp)
	movl	$.L.str6, 8(%esp)
	call	Print
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	free
	movl	20(%esp), %eax
	movl	%eax, (%esp)
	call	free
	movl	16(%esp), %eax
	movl	%eax, (%esp)
	call	free
	movl	$0, 40(%esp)
	movl	$0, 44(%esp)
	movl	44(%esp), %eax
	addl	$56, %esp
	popl	%esi
	ret
	.size	main, .-main

	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:                                 # @.str
	.asciz	 "w"
	.size	.L.str, 2

	.type	.L.str1,@object
.L.str1:                                # @.str1
	.asciz	 "Matrix C:\n"
	.size	.L.str1, 11

	.type	.L.str2,@object
.L.str2:                                # @.str2
	.asciz	 "     "
	.size	.L.str2, 6

	.type	.L.str3,@object
.L.str3:                                # @.str3
	.asciz	 " %i"
	.size	.L.str3, 4

	.type	.L.str4,@object
	.section	.rodata.str1.16,"aMS",@progbits,1
	.align	4
.L.str4:                                # @.str4
	.asciz	 "<=== Thread %i -> Before Matrix Multiplication ===>\n"
	.size	.L.str4, 53

	.type	.L.str5,@object
	.align	4
.L.str5:                                # @.str5
	.asciz	 "<=== Thread %i -> After  Matrix Multiplication ===>\n"
	.size	.L.str5, 53

	.type	.L.str6,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str6:                                # @.str6
	.asciz	 "mmmthr.txt"
	.size	.L.str6, 11


	.section	.note.GNU-stack,"",@progbits
