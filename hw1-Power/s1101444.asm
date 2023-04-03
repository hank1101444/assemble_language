.data
one: .word 1
str1: .string "input number X= "
str2: .string "input number N= "
undefined: .string "Undefined"	### append "undefined" string when occurs pow(0, 0)
student_id: .string "s1101444\n"	### append "student_id" string to output my student_id

.text
main:
	jal ra print_student_id	###jump to print_student_id label
	jal printMsg1
	jal inputXN	# return the result a0	
	mv s0,a0	# Set s0 equal to the result
	jal printMsg2
	jal inputXN	# return the result a0	
	mv s1,a0	# Set s1 equal to the result	
	beq s1 zero up_zero_problem	###solve pow(?, 0) problem & consider pow(0, 0)
	beq s0 zero down_zero_problem	### solve pow(0, ?) problem
	mv a0,s0
	mv a1,s1
	jal power # power(X=a0, N=a1), return a0
	mv s0,a0
	jal printResult #printResult(s0)
	j end

power: 
	li t0, 0
	mv t1,a0
	addi a1,a1,-1
loop: 
	bge t0, a1, endpower 	# i = 0,  i<n ;
	mul a0, a0, t1
	addi t0, t0, 1
	jal x0, loop
endpower: 
	jr ra	# jump register
	
print_student_id:	### print_student_id
	la a0, student_id	### load string address to a0
	li a7, 4	###load 4 into a7 register to output string
	ecall	###system call to output
	ret	###return to ra

printResult:
	mv a0,s0
	li a7, 1			# print string
 	ecall
 	ret
inputXN:
	li a7,5
	ecall
	ret	
printMsg1:
	la a0, str1			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg2:
	la a0, str2			# prepare to print string 2
	li a7, 4			# print string
 	ecall
 	ret
up_zero_problem:
	beq s0 s1 UnDefined	###pow(0, 0) -> undefined
	beq s1 zero result_one	###pow(?, 0) -> 1

down_zero_problem:		### pow(0, ?) -> 0
	mv a0 zero	###0 -> a0
	li a7, 1	###load immidiate 1 to a7 to print int
	ecall		###system call to output
	j end		###end program
	
UnDefined:	###print "undefined"
	la a0, undefined	###load string address
	li a7, 4	###print string
	ecall	###system call to output
	j end
result_one:	###print 1 when pow(?, 0) occurs
	li a0, 1	###load immidiate 1 to a0
	li a7, 1	###print int
	ecall	###system call to output
	j end	### end program
end:	#end program
	li a7, 10			
 	ecall
