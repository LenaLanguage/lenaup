	.file	"lenaup.c"
 # GNU C17 (Rev6, Built by MSYS2 project) version 13.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 13.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -municode -m64 -mtune=generic -march=nocona -O3 -std=c17
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Hello World!\0"
	.text
	.p2align 4
	.globl	up
	.def	up;	.scl	2;	.type	32;	.endef
	.seh_proc	up
up:
	subq	$40, %rsp	 #,
	.seh_stackalloc	40
	.seh_endprologue
 # src\lenaup.c:5:     llibs_init();
	call	llibs_init	 #
 # src\lenaup.c:6:     lcout(X("Hello World!"));
	leaq	.LC0(%rip), %rcx	 #, tmp85
	call	lcout	 #
 # src\lenaup.c:8: }
	xorl	%eax, %eax	 #
	addq	$40, %rsp	 #,
	ret	
	.seh_endproc
	.ident	"GCC: (Rev6, Built by MSYS2 project) 13.2.0"
	.def	llibs_init;	.scl	2;	.type	32;	.endef
	.def	lcout;	.scl	2;	.type	32;	.endef
