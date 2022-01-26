.data
argument: .word 10
i:.word 1
j:.word 1
k:.word 2
str1: .string "th number in the Fibonacci sequence is "

.text
main:
    lw    a0, argument
	lw	  t0,i
	lw	  t1,j
    lw    t3,k
    jal   ra, fib


    li    a0,10
    ecall


fib:
    addi   a0,a0,-1
    add		t2,t0,t1
    mv    t0,t1
    mv    t1,t2
    bne   a0,t3,fib
    beq   a0,t3,printResult


printResult:
    
    lw    a1,argument
    li    a0,1
    ecall
  
    la    a1,str1
    li    a0,4
    ecall

    mv    a1,t2
    li    a0,1
    ecall

    ret