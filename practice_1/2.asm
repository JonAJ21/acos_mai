# б) Напишите программу на ассемблере RISC-V, которая
# принимает на вход целое число x и выводит все значения
# в диапазоне min(x, y)...max(x, y) с шагом h. Где y – номер группы,
# h – номер студента в группе.

.data
	y: .word 138 # - номер группы
	h: .word 8 # - номер студента
	ask_x: .asciz "Введите целое число x: "
	space: .asciz " "
.text
.globl main
main:
	# Загружаем h
	la t0, h 
	lw t0, 0(t0)
	
	# Загружаеи y
	la t1, y 
	lw t1, 0(t1)
	
	# Печатаем "Введите целое число x: "
	li a7, 4
	la a0, ask_x
	ecall
	
	# Считываем x
	li a7, 5
	ecall
	mv t2, a0
	
	# В регистре t1 - min(x,y), а в t2 - max(x,y)
	bgt t1, t2, y_bigger
	j loop

y_bigger:
	mv t3, t1
	mv t1, t2
	mv t2, t3
	j loop

loop:
	# Печатаем: t1
	li a7, 1
	mv a0, t1
	ecall
	
	# Печатаем пробел
	li a7, 4
	la, a0, space
	ecall
	
	# Прибавляем h к t1
	add t1, t1, t0 
	
	# Пока t1 >= t2 продолжнаем цикл
	ble t1, t2, loop
	j exit
	
				
exit:
	li a7, 10
	ecall
 
