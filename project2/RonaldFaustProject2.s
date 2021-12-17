.data
	string1: .asciiz "The South Carolina Gamecocks football program represents the University of South Carolina in the sport of American football. The Gamecocks compete in the Football Bowl Subdivision of the National Collegiate Athletic Association (NCAA) and the Eastern Division of the Southeastern Conference. Will Muschamp currently serves as the team's head coach."
	string2: .asciiz "Please input first word: Gamecocks (or gamecocks, or GAMEcocks , ...)"
	string3: .asciiz "Please input second word: Football (or FootBall, footBALL, ...)"
	firstWord: .asciiz "First Word: "
	secondWord: .asciiz "Second Word: "
	newLine: .asciiz "\n"
	buffer:  .space 20
    
.text
    
	li $v0, 4	#print the string2
	la $a0, string2
	syscall
    
    
	li $v0,8   #take in string input 
	la $a0, buffer
	li $a1, 20
	move $s0, $a0	#String address stored in $s0
	syscall
	
	li $t4, 0 # initialize the count to zero
loop:
	lb $t5, 0($a0) # load the next character into t1
	beqz $t5, exit # check for the null character
	addi $a0, $a0, 1 # increment the string pointer
	addi $t4, $t4, 1 # increment the count
	j loop

exit:
	li $s6, 348  #length of hardcoded string
	li $t6, 0
	addi $t4, $t4, -1
	la $s2, string1  #hardcoded string in $s2
	
	li $t1, 0	#use $t1 for the char number of String1 
ResetCount:
	li $t2, 0	#use $t2 for char number of user inputted string 
GetString1Char:
	la $a1, ($s2)	#reads character of string
	add $a1, $a1, $t1
	lbu $t0, ($a1)
	addi $t1, $t1, 1
	
	beq $t1, $s6, SecondRunThrough
	
GetString2Char:
	la $a1, ($s0)	#reads character of string
	add $a1, $a1, $t2
	lbu $t3, ($a1)
	addi $t2, $t2, 1

CheckIfEqual:
	beq $t2, $t4, IncreaseCount
	li $t7, 91
	beq $t0, $t3, GetString1Char
	slt $t7, $t3, $t7
	bne $t7, $zero, Add
	beq $t7, $zero, Subtract
	j GetString1Char

Add:
	addi $t3, $t3, 32
	bne $t0, $t3, ResetCount
	j GetString1Char
	
Subtract:
	addi $t3, $t3, -32
	bne $t0, $t3, ResetCount
	j GetString1Char
IncreaseCount:
	addi $t6, $t6, 1
	j ResetCount


SecondRunThrough:
	li $v0, 4	#print the string3
	la $a0, string3
	syscall
    
    
	li $v0,8   #take in string input 
	la $a0, buffer
	li $a1, 20
	move $s1, $a0	#String address stored in $s1
	syscall
	
	li $t4, 0 # initialize the count to zero
loop1:
	lb $t5, 0($a0) # load the next character into t1
	beqz $t5, exit1 # check for the null character
	addi $a0, $a0, 1 # increment the string pointer
	addi $t4, $t4, 1 # increment the count
	j loop1

exit1:
	li $s7, 0
	addi $t4, $t4, -1
	la $s2, string1  #hardcoded string in $s2
	
	li $t1, 0	#use $t1 for the char number of String1 
ResetCount1:
	li $t2, 0	#use $t2 for char number of user inputted string 
GetString1Char1:
	la $a1, ($s2)	#reads character of string
	add $a1, $a1, $t1
	lbu $t0, ($a1)
	addi $t1, $t1, 1
	
	beq $t1, $s6, End
	
GetString2Char1:
	la $a1, ($s1)	#reads character of string
	add $a1, $a1, $t2
	lbu $t3, ($a1)
	addi $t2, $t2, 1

CheckIfEqual1:
	beq $t2, $t4, IncreaseCount1
	li $t7, 91
	beq $t0, $t3, GetString1Char1
	slt $t7, $t3, $t7
	bne $t7, $zero, Add1
	beq $t7, $zero, Subtract1
	j GetString1Char1

Add1:
	addi $t3, $t3, 32
	bne $t0, $t3, ResetCount1
	j GetString1Char1
	
Subtract1:
	addi $t3, $t3, -32
	bne $t0, $t3, ResetCount1
	j GetString1Char1
IncreaseCount1:
	addi $s7, $s7, 1
	j ResetCount1
	
	
End:    

	li $v0, 4	#print the first user inputted string
	la $a0, firstWord
	syscall
	
	move $a0, $t6	#print count of first word appearances
	li $v0, 1
	syscall
	
	li $v0, 4	#print the string2
	la $a0, newLine
	syscall
	
	li $v0, 4	#print the string2
	la $a0, secondWord
	syscall
	
	move $a0, $s7	#print count of first word appearances
	li $v0, 1
	syscall	
	
	li $v0,10 #end program
	syscall
    
