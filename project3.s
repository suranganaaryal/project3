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