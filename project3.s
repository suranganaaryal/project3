.data
input: .space 1001
prompt: .asciiz "?"
comma: .asciiz ","


.text

main:
li $v0,8
la $a0,input 					
li $a1, 1001 								
syscall

li $t5,0

jal sub_a

forward:
j display

sub_a:
sub $sp, $sp,4
sw $a0, 0($sp)
lw $t0, 0($sp)
addi $sp,$sp,4
move $t6, $t0

start: 
li $t2,0
li $t7, -1				 				
lb $s0, ($t0)
beq $s0, 9, removing							
beq $s0, 32, removing
move $t6, $t0 
j loop

removing:
addi $t0,$t0,1
j start

loop:
lb $s0, ($t0) 							
beq $s0, 0, substring 					
beq $s0, 10, substring
addi $t0,$t0,1
beq $s0, 44, substring

checking:
addi $t5,$t5,1
bgt $t2,0,invalid
beq $s0, 9,  skipping 			
beq $s0, 32, skipping
ble $s0, 47, invalid 
ble $s0, 57, valid 					
ble $s0, 64, invalid
ble $s0, 81, valid 						
ble $s0, 96, invalid 						
ble $s0, 113, valid
bgt $s0, 113, invalid

skipping:
addi $t2,$t2,-1
j loop

valid:
addi $t3, $t3,1
mul $t2,$t2,$t7
j loop

invalid:
lb $s0, ($t0)
beq $s0, 0, inside
beq $s0, 10, inside
addi $t0,$t0,1
beq $s0, 44, inside
j invalid


inside:
addi $t1,$t1,1
sub $sp, $sp,4
sw $t7, 0($sp)
move $t6,$t0
lb $s0, ($t0)
beq $s0, 0, forward
beq $s0, 10, forward
beq $s0,44, invalid
li $t3,0
li $t2,0
j loop

substring:
bgt $t2,0,inside
bge $t3,5,inside
addi $t1,$t1,1
sub $sp, $sp,4
sw $t6, 0($sp)
move $t6,$t0
lw $t4,0($sp)
li $s1,0

jal sub_b
lb $s0, ($t0)
beq $s0, 0, forward
beq $s0, 10, forward
beq $s0,44, invalid
li $t2,0
j loop

sub_b:
beq $t3,0,finish
addi $t3,$t3,-1
lb $s0, ($t4)
addi $t4,$t4,1
j sub_c

moving:
sw $s1,0($sp)
j sub_b

sub_c:
move $t8, $t3
li $t9, 1
ble $s0, 57, number
ble $s0, 87, uppercase
ble $s0, 119, lowercase

number:
sub $s0, $s0, 48
beq $t3, 0, mixed
li $t9, 30
j exponent

lowercase:
sub $s0, $s0, 87
beq $t3, 0, mixed
li $t9, 30
j exponent

uppercase:
sub $s0, $s0, 55
beq $t3, 0, mixed
li $t9, 30
j exponent

mixed:
mul $s2, $t9, $s0
add $s1,$s1,$s2
j moving

exponent:
ble $t8, 1, mixed
mul $t9, $t9, 30
addi $t8, $t8, -1
j exponent

finish : jr $ra

display:
mul $t1,$t1,4
add $sp, $sp, $t1

end:
li $v0, 1				

add $a0,$zero, $t5
syscall

li $v0, 11
add $a0,$zero,'/'
syscall

sub $t1, $t1,4
sub $sp,$sp,4
lw $s7, 0($sp)
beq $s7,-1,questionprinting
li $v0, 1
lw $a0, 0($sp)
syscall

commaprinting:
beq $t1, 0,Exit
li $v0, 4
la $a0, comma
syscall
j end