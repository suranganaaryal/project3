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
