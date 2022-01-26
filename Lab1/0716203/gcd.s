.data
argument1: .word 512
argument2: .word 480
i:.word 0
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
     lw    a0, argument1
     lw    a1,argument2
	 lw    t0,i
     jal   ra, gcd


     li    a0,10
     ecall


gcd:
    rem   t1,a0,a1
    mv    a0,a1
    mv    a1,t1
    beq   t1,t0,printResult
    bne   t1,t0,gcd
    
    

printResult:
    lw    t2,argument1
    lw    t3,argument2
    mv    t4,a0    

    la    a1,str1
    li    a0,4
    ecall

    mv    a1,t2
    li    a0,1
    ecall

    la    a1,str2
    li    a0,4
    ecall

    mv    a1,t3
    li    a0,1
    ecall

    la    a1,str3
    li    a0,4
    ecall

    mv    a1,t4
    li    a0,1
    ecall

    ret