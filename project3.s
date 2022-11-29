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