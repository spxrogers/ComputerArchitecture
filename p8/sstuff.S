	.global indepAdd32Ops
indepAdd32Ops:
	push %ebx
	push %ecx
	push %edx
	push %esi
	push %edi
	push %ebp

	.rept 1000
	inc %eax
	inc %ebx
	inc %ecx
	inc %edx
	inc %esi
	inc %edi
	inc %ebp
	.endr

	pop %ebp
	pop %edi
	pop %esi
	pop %edx
	pop %ecx
	pop %ebx

	mov $7000,%eax
	ret
	
	.global indepAdd8Ops
indepAdd8Ops:
        push %ebx
        push %ecx
        push %edx

        .rept 1000
        inc %al
        inc %cl
        inc %dl
        inc %bl
        .endr

        pop %edx
        pop %ecx
        pop %ebx

        mov $7000,%eax
        ret

	.global indepLoads
indepLoads:
	push %ebx
        push %ecx
        push %edx
        push %esi
        push %edi
        push %ebp
	mov $100, %eax

	.rept 1000
	leal (%eax), %ebx
       	leal (%eax), %ecx
        leal (%eax), %edx
        leal (%eax), %esi
        leal (%eax), %edi
        leal (%eax), %ebp	
	.endr

	pop %ebp
        pop %edi
        pop %esi
        pop %edx
        pop %ecx
        pop %ebx

	mov $6000, %eax
	ret
	
	.global depLoads
depLoads:
	push %edx
	mov $100, %edx	

	.rept 10000
	leal (%edx), %eax
	leal (%eax), %edx
	.endr

	pop %edx

	mov $10000, %eax
	ret

	.global indepMuls
indepMuls:
	push %ebx
	push %ecx
	push %edx
	push %esi
	push %edi
	push %ebp
	mov $2, %eax

	.rept 1000
	imul %eax, %ebx
	imul %eax, %ecx
	imul %eax, %edx
	imul %eax, %esi
	imul %eax, %edi
	imul %eax, %ebp
	.endr

	pop %ebp 
	pop %edi
	pop %esi
	pop %edx
	pop %ecx
	pop %ebx

	mov $6000, %eax
	ret

	.global depMuls
depMuls:
	push %ecx
	mov $2, %eax
	mov $2, %ecx

	.rept 10000
	imul %eax, %eax
	.endr

	pop %ecx
	mov $10000, %eax
	ret

	.global indepDivs
indepDivs:
	push %edx
        push %ecx
	push %esi
	push %edi
	push %ebp

        mov $2, %ecx
	mov $2, %esi
	mov $2, %edi
	mov $2, %ebp
        mov $8, %eax
        cdq

        .rept 2500
        div %ecx
	div %esi
	div %edi
	div %ebp
        .endr

	pop %ebp
	pop %edi
	pop %esi
        pop %ecx
        pop %edx
        mov $10000, %eax
        ret	

	.global depDivs
depDivs:
	push %edx
	push %ecx
	mov $2, %ecx
	mov $8, %eax
	cdq

	.rept 10000
	div %ecx
	.endr

	pop %ecx
	pop %edx
	mov $10000, %eax
	ret

	.global depUncond
depUncond:
	.rept 10000
	jmp 1f
	1:
	.endr

	mov $10000, %eax
	ret

	.global depTaken
depTaken:
	mov $1, %eax
	mov $1, %ecx
	cmp %eax, %ecx

	.rept 10000
	je 2f
	2:
	.endr

	mov $10000, %eax
	ret

	.global depUntaken
depUntaken:
	mov $1, %eax
	cmp $0, %eax

	.rept 10000
	je depUntaken
	.endr

	mov $10000, %eax
	ret

	.globl indepAdds
indepAdds:
        push %ebx
	push %ecx
	push %edx
	push %esi
	push %edi
	push %ebp

	.rept 1000
	add $1,%eax
	add $1,%ebx
	add $1,%ecx
	add $1,%edx
	add $1,%esi
	add $1,%edi
	add $1,%ebp
	.endr

	pop %ebp
	pop %edi
	pop %esi
	pop %edx
	pop %ecx
	pop %ebx

	mov $7000,%eax

	ret

	.globl depAdds
depAdds:
        mov $0,%eax

	.rept 10000
	add $1,%eax
	.endr

	ret

