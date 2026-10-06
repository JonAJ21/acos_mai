# в) Напишите программу на ассемблере RISC-V, которая
# заполняет массив из 16+n целых чисел значениями из
# стандартного ввода. Программа считывает значения в цикле
# и завершает чтение, когда считаны все 16+n значения
# или когда считано значение 0 (n – номер студента в группе)

.data
	array_size: .word 24 # 16 + n, где n = 8
	array: .space 96 # 24 * 4
	ask: .asciz "Введите число (0 - стоп): "
	newline: .asciz "\n"
	msg_zero: .asciz "Введен 0 - прекращаем считывать\n"
	msg_result: .asciz "Массив: "

.text
.globl main
main:
	# В t0 храним длину массива
	la t0, array_size 
	lw t0, 0(t0)
	
	# В t1 - адрес 0-го элемента 
	la t1, array
	
	# В t2 - индекс i
	li t2, 0
	
# Цикл для считывания значений в массив
read_loop:
	# Условие выхода из цикла
	bge t2, t0, full 
	
	# Говорим пользователю, что сделать
	li a7, 4
	la a0, ask
	ecall
	
	# Считываем число, сохраняем в t3
	li a7, 5
	ecall
	mv t3, a0
	
	# Еще одно условие выхода - ввели 0
	beq t3, zero, stopped
	
	# Сохраняем t3 в array[i]
	slli t4, t2, 2 # Побитовый сдвиг влево на 2 бита (умножение на 4), т.к. одно число в массиве занимает - 4 байта
	add t4, t1, t4
	sw t3, 0(t4)
	
	# i += 1
	addi t2, t2, 1 
	
	j read_loop

# Массив заполнен
full:
	mv t5, t2
	j print_array
	
# Встречен 0
stopped:
	li a7, 4
	la a0, msg_zero
	ecall
	mv t5, t2
	j print_array

# Печатаем массив
print_array:
	li a7, 4
	la a0, msg_result
	ecall
	li t6, 0

# Цикл печати
print_loop:
	# Условие выхода
	bge t6, t5, print_done
	
	# Считываем число из массива и выводим
	slli t4, t6, 2
	add t4, t1, t4
	lw a0, 0(t4)
	li a7, 1
	ecall
	
	# Печатаем пробел
	li a7, 11
	li a0, ' '
	ecall
	
	addi t6, t6, 1 # t6 += 1
	
	j print_loop
	
# Закончили печать
print_done:
	li a7, 4
	la, a0, newline
	ecall
	
	li a7, 10
	ecall
	
		

	
	
	
	
	
	
	
	