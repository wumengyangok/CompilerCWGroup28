; Jasmin Java assembler code that assembles the SimpleFolding example class

.source Type1.j
.class public comp207p/target/SimpleFolding
.super java/lang/Object

.method public <init>()V
	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return
.end method

.method public simple()V
	.limit stack 3

	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc 67
	ldc 12345
    iadd
    ldc 3
    imul
    ldc 3
    idiv
    iconst_3
    imul
    i2f
    ldc 3.0f
    fmul
    ldc 9.0f
    fdiv
    f2i
    invokevirtual java/io/PrintStream/println(I)V
	return
.end method