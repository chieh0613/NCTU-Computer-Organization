.data
n:.word 10						
str1:.string "Array: "					
str2:.string "Sorted: "				
space:.string " "
endl:.string "\n"					
array:.word 5,3,6,7,31,23,43,12,45,1		


.text
main:
		lw a5,n						
		la s5, array						
		jal ra,initialArray 				
		la a1,endl							
		li a0,4
		ecall
		la a1,str2							
		li a0,4
		ecall
		la a1,endl							
		li a0,4
		ecall 
		lw a5,n							
		jal ra,sort		


		#exit program
		li       a0, 10
		ecall
		ret

initialArray:
#{5,3,6,7,31,23,43,12,45,1};
		
		la a1,str1							
		li a0,4
		ecall
		la a1,endl							
		li a0,4
		ecall
		beq zero,zero,print0 			
		ret


swap:
		mv    s6,s4
		slli  s6,s6,2
		add   s6,s5,s6
		lw    t4,0(s6)
		lw    t5,4(s6)
		sw    t5,0(s6)
		sw    t4,4(s6)
		ret
		
sort:
		li    s3,0 #i=0
		beq   zero,zero,loop1

loop1: 
		bge   s3,a5,print0 #if i>n
		addi  s4,s3,,-1 #j=i-1
		beq   zero,zero,loop2
		
loop2: 
		blt   s4,zero,exit2 #if j<0
		slli  t0,s4,2  #s4=j,t0=j+1
		add   t0,s5,t0 
		lw    t1,0(t0) #t1=a[0]
		lw    t2,4(t0) #t2=a[1]
		ble   t1,t2,exit2 #if a[j]<a[j+1]
		mv    t3,ra  
		jal   ra,swap
		mv    ra,t3
		addi  s4,s4,-1  #j--
		beq   zero,zero,loop2	
		
print0:
		mv s7,zero
		beq zero,zero,print
		
print:
		add s8,s5,s7	#s7=k
		lw a1,0(s8)
		li a0,1
		ecall
		la a1,space
		li a0,4
		ecall
		addi s7,s7,4
		addi a5,a5,-1
		bne a5,zero,print 
		ret

		
exit2:
		addi s3,s3,1 #i++
		beq   zero,zero,loop1
		
		

		