#
# An x86-32 assembly program that echos one character
#

	.globl check
	.globl _check

	# int check(Node* p)
check:
_check:
	mov $0, %edx		# edx hold counter for num nodes
	cmp $0, 4(%esp)		# cmp 
	je empty		# 0 passed as arg; no nodes
	mov 4(%esp), %ecx	# arg; ecx holds first / trailer node
	cmp $0, (%ecx)		# cmp pointer for first node
	je singular 		# points to 0; only one node		
	mov (%ecx), %eax 	# eax holds leader node
	add $2, %edx		# first 2 nodes; add to count
	jmp loop


	.globl reverse
	.globl _reverse
	# void reverse(p)
reverse:
_reverse:
	push %ebp		# save ebp
	push %esi 		# save esi
	mov %esp, %ebp		# save esp
	mov $0, %edx 		# counter for nodes 
	cmp $0, 12(%esp) 	# cmp 0 to arg for empty list
	je nothing		# terminates
	mov 12(%esp), %ecx 	# ecx holds first node location
	inc %edx 		# inc counter for first node
	mov 12(%esp), %eax 	# eax "holds" node
	jmp traverse		# loop to add data to stack

nothing:
_nothing:
	mov %ebp, %esp	 	# restore esp
	pop %esi 		# restore esi
	pop %ebp 		# restore ebp
	ret

traverse:
_traverse:
	mov 4(%eax), %esi 	# esi holds data 
	push %esi 		# data on stack
	cmp $0, (%eax) 		# cmp next to see if end
	je restore		# restore data
	inc %edx 		# counter++
	mov (%eax), %eax	# node = node.next
	jmp traverse		# restart loop

restore:
_restore:
	pop %eax		# data to add in eax
	mov %eax, 4(%ecx) 	# data to frontmost node
	dec %edx		# counter--
	cmp $0, %edx 		# check if counter 0
	je finish 		# end program
	mov (%ecx), %ecx 	# node = node.next
	jmp restore		# restart loop

finish:
_finish:
	mov %ebp, %esp		# restore esp
	pop %esi 		# restore esi
	pop %ebp		# restore ebp
	ret	

empty:
_empty: 
	mov $0,%eax
	ret

singular:
_singular:
	mov $1, %eax
	ret	

loop:
_loop: 
	mov (%ecx), %ecx	# one jump trailer
	cmp $0, (%eax)		# cmp leader's next
	je done			# leader's next 0; end of list
	inc %edx		# adds to count; has next
	mov (%eax), %eax	# leader gets first hop
	cmp $0, (%eax)		# cmp hop'd leader's next
	je done 		# next is 0; end of list
	inc %edx		# adds to count; has next
	mov (%eax), %eax 	# leader gets second hop
	cmp %ecx, %eax	 	# cmp trailer & leader
	je cycle 		# is cycle; ret -1
	jmp loop	

done:
_done:
	mov %edx, %eax
	ret
	
cycle:
_cycle:
	mov $-1, %eax
	ret
