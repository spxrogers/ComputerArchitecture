#
# An x86-32 assembly program that echos one character
#

	# declare external functions
	.extern getchar		# get one character from the console
	.extern putchar		# write one character to the console

	# declare main as global
	.global main

	# the main program
main:
	call getchar		# get a character
	push %eax               ### remove this and move it to...
	cmp $-1, %eax
	je done

	cmp $101, %eax
	je lower
	cmp $69, %eax
	je upper
	
	cmp $115, %eax
	je lower
	cmp $83, %eax
	je upper

	cmp $114, %eax
	je lower
	cmp $82, %eax
	je upper

	cmp $111, %eax
	je lower
	cmp $79, %eax
	je upper

	cmp $103, %eax
	je lower
	cmp $71, %eax
	je upper

print:
	# push %eax		### push it here; segfault if i do this
	call putchar		# putchar
	add $4, %esp
	jmp main
	


### so i can modify %eax at upper and lower
upper:
	add $32, (%esp) 	###this would then be add $32, %eax
	jmp print

lower:
	sub $32, (%esp)
	jmp print
	
done:
	add $4, %esp
	mov $0,%eax
	ret

