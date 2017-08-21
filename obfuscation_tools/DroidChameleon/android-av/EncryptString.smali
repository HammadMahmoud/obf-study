.class public Lcom/EncryptString;
.super Ljava/lang/Object;
.source "EncryptString.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyCaesar(Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    .prologue
    .line 26
    const/4 v0, -0x1

    invoke-static {p0, v0}, Lcom/EncryptString;->applyCaesar(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static applyCaesar(Ljava/lang/String;I)Ljava/lang/String;
    .registers 6

    .prologue
    .line 6
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    .line 7
    const/4 v0, 0x0

    :goto_5
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_26

    .line 9
    aget-char v1, v2, v0

    .line 10
    const/16 v3, 0x20

    if-lt v1, v3, :cond_23

    const/16 v3, 0x7f

    if-gt v1, v3, :cond_23

    .line 14
    add-int/lit8 v1, v1, -0x20

    .line 15
    add-int/2addr v1, p1

    rem-int/lit8 v1, v1, 0x60

    .line 16
    if-gez v1, :cond_1e

    .line 17
    add-int/lit8 v1, v1, 0x60

    .line 18
    :cond_1e
    add-int/lit8 v1, v1, 0x20

    int-to-char v1, v1

    aput-char v1, v2, v0

    .line 7
    :cond_23
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 21
    :cond_26
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/lang/String;-><init>([C)V

    return-object v0
.end method

.method public static main([Ljava/lang/String;)V
    .registers 3

    .prologue
    .line 30
    const-string v0, "hello world!"

    .line 31
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 32
    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/EncryptString;->applyCaesar(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 33
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 34
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-static {v0}, Lcom/EncryptString;->applyCaesar(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 35
    return-void
.end method
