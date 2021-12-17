.data   
    string1: .asciiz  "ID = \“Print your student ID Here, e.g. R02040608\”\n"
    string2: .asciiz  "\nEnter 4 integers for a,b,c,d respectively: \n"
    string3: .asciiz  "f_ten \n"
    string4: .asciiz  "\nf_two\n"
    string5: .asciiz  "\ng_ten\n"
    string6: .asciiz  "\ng_two\n"
    string7: .asciiz  "\nh quotient\n"
    string8: .asciiz  "\nh remainder\n"
    buffer:  .space 11
    
.text
    
    li $v0, 4		#print the string1
    la $a0, string1
    syscall
    
    
    li $v0,8   #take in string input 
    la $a0, buffer
    li $a1, 11
    move $t0, $a0	#String address stored in $t0
    syscall
    
    li $t1, 0	#use $t1 for the byte number needed to be assessed 

GetFirstInt:
    addi $t1, $t1, 1
    la $a1, ($t0)	#reads character of string at byte 1 (first non letter)
    add $a1, $a1, $t1
    lbu $s0, ($a1)
    beq $s0, 48, GetFirstInt
    addi $s0, $s0, -48  #subtract 48 to turn ASCII representation into decimal

GetSecondInt:
    addi $t1, $t1, 1
    la $a1, ($t0)	#reads character of string at byte 1 (first non letter)
    add $a1, $a1, $t1
    lbu $s1, ($a1)
    beq $s1, 48, GetSecondInt
    addi $s1, $s1, -48

  
 GetThirdInt: 
    addi $t1, $t1, 1
    la $a1, ($t0)	#reads character of string at byte 1 (first non letter)
    add $a1, $a1, $t1
    lbu $s2, ($a1)
    beq $s2, 48, GetThirdInt
    addi $s2, $s2, -48
    
GetFourthInt:
    addi $t1, $t1, 1
    la $a1, ($t0)	#reads character of string at byte 1 (first non letter)
    add $a1, $a1, $t1
    lbu $s3, ($a1)
    beq $s3, 48, GetFourthInt
    addi $s3, $s3, -48
    
    #la $a0, buffer2	#print string back
    #la $t1, ($t0)
    #move $a0, $t1
    #li $v0, 4  	
    #syscall 
    
    li $v0, 4		#print the string2
    la $a0, string2
    syscall
    
    li $v0, 5		#read next int
    syscall
    move $s4, $v0
    
    li $v0, 5		#read next int
    syscall
    move $s5, $v0
    
    li $v0, 5		#read next int
    syscall
    move $s6, $v0
    
    li $v0, 5		#read next int
    syscall
    move $s7, $v0
    
    li $t8, 1
    li $t1, 1
    move $t4, $s4
Loop:			#runs inner loop $s0 times
    beq $s4, $zero, Exit
    beq $s4, $t8, Exit
    li $t2, 1
    beq $t1, $s0, Exit
    addi $t1, $t1, 1  
    move $t5, $t4
        
InnerLoop:		#runs  $s4-1 times 
    addi $t7, $s4, -1
    add $t4, $t4, $t5
    beq $t2, $t7, Loop
    addi $t2, $t2, 1
    j InnerLoop
Exit:
    add $s0, $t4, $zero	 # $s0 now holds a^ x

    
    li $t1, 1
    move $t4, $s5
Loop1:			#runs inner loop $s1 times
    beq $s5, $zero, Exit1
    beq $s5, $t8, Exit1
    li $t2, 1
    beq $t1, $s1, Exit1
    addi $t1, $t1, 1  
    move $t5, $t4
        
InnerLoop1:		#runs  $s5-1 times 
    addi $t7, $s5, -1
    add $t4, $t4, $t5
    beq $t2, $t7, Loop1
    addi $t2, $t2, 1
    j InnerLoop1
Exit1:
    add $s1, $t4, $zero	 # $s1 now holds a^ x

    li $t1, 1
    move $t4, $s6
Loop2:			#runs inner loop $s2 times
    beq $s6, $zero, Exit2
    beq $s6, $t8, Exit2
    li $t2, 1
    beq $t1, $s2, Exit2
    addi $t1, $t1, 1  
    move $t5, $t4
        
InnerLoop2:		#runs  $s6-1 times 
    addi $t7, $s6, -1
    add $t4, $t4, $t5
    beq $t2, $t7, Loop2
    addi $t2, $t2, 1
    j InnerLoop2
Exit2:
    add $s2, $t4, $zero	 # $s2 now holds a^ x
    
    li $t1, 1
    move $t4, $s7
Loop3:			#runs inner loop $s0 times
    beq $s7, $zero, Exit3
    beq $s7, $t8, Exit3
    li $t2, 1
    beq $t1, $s3, Exit3
    addi $t1, $t1, 1  
    move $t5, $t4
        
InnerLoop3:		#runs  $s7-1 times 
    addi $t7, $s7, -1
    add $t4, $t4, $t5
    beq $t2, $t7, Loop3
    addi $t2, $t2, 1
    j InnerLoop3
Exit3:
    add $s3, $t4, $zero	 # $s3 now holds a^ x
 
    add $s0, $s0, $s1
    add $s1, $s2, $s3
    
    li $v0, 4		#print the string3
    la $a0, string3
    syscall
    
    move $a0, $s0	#print f
    li $v0, 1
    syscall
    
    li $v0, 4		#print the string4
    la $a0, string4
    syscall
    
    move $a0, $s0	#print f binary
    li $v0, 35
    syscall
    
    li $v0, 4		#print the string5
    la $a0, string5
    syscall
    
    move $a0, $s1	#print g
    li $v0, 1
    syscall
    
    li $v0, 4		#print the string6
    la $a0, string6
    syscall
    
    move $a0, $s1	#print g binary
    li $v0, 35
    syscall
    
    li $t1, 0
Quotient: 
    sub $s0, $s0, $s1
    slt $t2, $s0, $zero
    bne $t2, $zero, Final
    addi $t1, $t1, 1
    j Quotient
    
Final:
    add $s3, $t1, $zero   #Stores quotient in $s3
    li $t3, 0
    sub $s4, $t3, $s0   #make leftover positive
    sub $s4, $s1, $s4
    
 
    li $v0, 4		#print the string7
    la $a0, string7
    syscall
    
    move $a0, $s3	#print h
    li $v0, 1
    syscall
    
    li $v0, 4		#print the string8
    la $a0, string8
    syscall
    
    move $a0, $s4	#print Remainder
    li $v0, 1
    syscall

    
    li $v0,10 #end program
    syscall

	


