	.data
x:
	.int 0

	.text
	.globl count1

	# int count1(char p[], int size, int limit)
	# EAX -> COUNTER
	# EDX -> LIMIT
	# ECX -> ARR LOCATION
	# ESI -> SIZE
	# EDI -> CHECK AGAINST SIZE - TO TERMINATE
count1:
	push %ebp		# save ebp
	push %esi		# save esi
	push %edi		# save edi
	mov %esp,%ebp		# save esp
	mov $0,%eax		# initialze count=0;
	mov $0,%edi		# initliaze check=0;
	mov 16(%esp),%ecx	# ecx = arr[0]
	mov 20(%esp),%esi	# esi = size;
	mov 24(%esp),%edx	# edx = limit;
	
	cmp $0,%esi		# check if arr is empty
	je done			# arr size = 0;
	jmp loop		# begin iterate

loop:
	cmp %edx,(%ecx)		# compare arr[i] to limit
	jl increment		# arr[i] < limit - add to count and iterate
	inc %edi		# check++
	add $4,%ecx		# arr[i] = arr[i+1]
	cmp %edi,%esi		# check if at end of array
	je done			# end of list - end function
	jmp loop		# reiterate

increment:
	inc %eax		# count++
	inc %edi		# check++
	add $4,%ecx		# next arr location
	cmp %edi,%esi		# check if end of array
	je done			# end of list - done
	jmp loop		# not done, reiterate	

done:
	mov %ebp,%esp		# restore esp
	pop %edi 		# restore edi
	pop %esi		# restore esi
	pop %ebp		# restore ebp
	ret

	.globl count2

	# int count1(char p[], int size, int limit)
count2:
	push %ebp 		
	push %esi
	push %edi
	mov %esp,%ebp
	mov $0,%eax
	mov $0,%edi
	mov 16(%esp),%ecx
	mov 20(%esp),%esi
	mov 24(%esp),%edx

	cmp $0,%esi
	je done
	jmp loop2

loop2:
	cmp %edx,(%ecx)
	jl increment2
	inc %edi
	add $4,%ecx
	cmp %edi,%esi
	cmove x,%esi
	cmp $0,%esi
	je done
	jmp loop2

increment2:
	inc %eax
	inc %edi
	add $4,%ecx
	cmp %edi,%esi
	cmove x,%esi
	cmp $0,%esi
	je done
	jmp loop2
