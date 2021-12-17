.data
	string1: .asciiz  "Enter 4 integers for A,B,C,D respectively:”\n"
	string2: .asciiz  "f= "
	string3: .asciiz "\ng= "
	fp0: .float 0.0
	fp1: .float 0.1
	fp2: .float 0.2
	fp3: .float 0.3
	fp4: .float 0.4
	
.text
    
	li $v0, 4		#print the string1
	la $a0, string1
	syscall
	
	li $v0, 5		#read First int A
	syscall
	move $s0, $v0		#Stored in S0 

	li $v0, 5		#read next int B
	syscall
	move $s1, $v0		#Stored in S1
    
	li $v0, 5		#read next int C
	syscall
	move $s2, $v0		#Stored in S2
    
	li $v0, 5		#read next int D
	syscall
	move $s3, $v0		#Stored in S3
	
	move $t0, $s0		#Calculate A^4
	move $t1, $s0
	jal IntMultiply
	move $t0, $t2
	jal IntMultiply
	move $t0, $t2
	jal IntMultiply
	move $s4, $t2		#value A^4 stored in $s4
	
	move $t0, $s1		#Calculate B^3
	move $t1, $s1
	jal IntMultiply
	move $t0, $t2
	jal IntMultiply
	move $s5, $t2		#value B^3 stored in $s5
	
	move $t0, $s2		#Calculate C^2
	move $t1, $s2
	jal IntMultiply
	move $s6, $t2		#value C^2 stored in $s6
	
	move $t1, $s4
	l.s $f1, fp1
	jal FPMultiply		#Calculates .1 x A^4 
	l.s $f9, fp0
	add.s $f3, $f2, $f9	#Stored in F3 
	
	move $t1, $s5
	l.s $f1, fp2
	jal FPMultiply		#Calculates .2 x B^3
	add.s $f4, $f2, $f9	#Stored in F4
	
	move $t1, $s6
	l.s $f1, fp3
	jal FPMultiply		#Calculates .3 x C^2
	add.s $f5, $f2, $f9	#Stored in F5
	
	move $t1, $s3
	l.s $f1, fp4
	jal FPMultiply		#Calculates .4 x D
	add.s $f6, $f2, $f9	#Stored in F6
	
	sub.s $f7, $f3, $f4	#calculates f 
	add.s $f7, $f7, $f5
	sub.s $f7, $f7, $f6
	
	move $t0, $s1		#Calculate AB^2
	move $t1, $s1
	jal IntMultiply
	move $t0, $t2
	move $t1, $s0
	jal IntMultiply
	move $s5, $t2		#value AB^2 stored in $s5
	
	move $t0, $s2		#Calculate C^2D^3
	move $t1, $s2
	jal IntMultiply
	move $t1, $t2
	move $t0, $s3
	jal IntMultiply
	move $t1, $t2
	jal IntMultiply
	move $t1, $t2
	jal IntMultiply
	move $s6, $t2		#value C^2D^3 stored in $s6
	
	move $t1, $s5
	l.s $f1, fp1
	jal FPMultiply		#Calculates .1 x AB^2
	add.s $f4, $f2, $f9	#Stored in F4
	
	move $t1, $s6
	l.s $f1, fp2
	jal FPMultiply		#Calculates .2 x C^2D^3
	add.s $f5, $f2, $f9	#Stored in F5
	
	add.s $f6, $f5, $f4	#Calculates g stores in $f6

	li $v0, 4		#print the string2
	la $a0, string2
	syscall
	
	li $v0, 2
	mov.s $f12, $f7   # print Floating point value 
	syscall
	
	li $v0, 4		#print the string3
	la $a0, string3
	syscall
	
	li $v0, 2
	mov.s $f12, $f6   # print Floating point value 
	syscall
	
End:
	li $v0,10 #end program
	syscall

#call to multiply $t0 x $t1 with the result store in $t2
IntMultiply:
	add $t2, $t0, $zero	#t2 prepares to hold the product by holding the $t0 value
	li $t3, 1		#$T3 checks that the addition occurs $t1-1 times 
RunAgain:
	add $t2, $t2, $t0	#performs addition
	addi $t3, $t3, 1		#increases T3 count
	beq $t3, $t1, Done	#finishes if t3 = t1
	j RunAgain		#runs again if above conditional does not branch
Done:
	jr $ra 			#returns 
	
#call to multiply $f1 x $t1 with result stored in $f2
FPMultiply:
	l.s $f2, fp0	#t2 prepares to hold the product by holding the $t0 value
	li $t3, 0		#$T3 checks that the addition occurs $t1-1 times 
RunAgain1:
	add.s $f2, $f2, $f1	#performs addition
	addi $t3, $t3, 1		#increases T3 count
	beq $t3, $t1, Done1	#finishes if t3 = t1
	j RunAgain1		#runs again if above conditional does not branch
Done1:
	jr $ra 			#returns 
	