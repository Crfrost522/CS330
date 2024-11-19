	/* ------------------------------------------------------------------------------
     This assembly code shows a function "myAddTwoNumbersFunction" that :
     - takes two ints as its parameters 
     - adds the two ints together
     - returns the result

     Main:
     - sets the two ints as 7 & 10
     - calls the myAddTwoNumbersFunction to calculate the sum fo the two numbers
     - prints the results to the temrinal with printf
    ---------------------------------------------------------------------------------*/
    .file	"asgn5.c" # original file name. Used when debugging
	.text             # start of text /code
	.globl	myAddTwoNumbersFunction # declares the function globally and makes it accessable 
	.type	myAddTwoNumbersFunction, @function # shows this is an actual function
myAddTwoNumbersFunction:            # labels the function myAddTwoNumbersFunction
.LFB0:                              # start of debug info for 
	.cfi_startproc                  # puts a marker at beginning of the function for debugging
	pushq	%rbp                    # saves the base ppinter to the stack in the rbp register
	.cfi_def_cfa_offset 16          # updates the stack info & sets stack pointer 16 bytes under the base pointer
	.cfi_offset 6, -16              # shows the base pointer is offset -16 on the stack
	movq	%rsp, %rbp              # sets the base pointer to the stack pointer 
	.cfi_def_cfa_register 6         # shows that %rbp is the new stack base pointer
	movl	%edi, -4(%rbp)          # puts arugment 1 in edi with offset -4
	movl	%esi, -8(%rbp)          # puts arugment 2 in esi with offset -8
	movl	-4(%rbp), %edx          # taking argument 1 from the stored memory reg and loads it into the edx reg
	movl	-8(%rbp), %eax          # taking argument 3 from the stored memory reg and loads it into the eax reg
	addl	%edx, %eax              # adds the value in edx and eax regs and stores the result in the eax register
	popq	%rbp                    # pops base pointer from the stack
	.cfi_def_cfa 7, 8               # updating the stack /////
	ret                             # returns to the caller
	.cfi_endproc                    # puts a marker at the end of the function for debugging.
.LFE0:                              # end of debug info
	.size	myAddTwoNumbersFunction, .-myAddTwoNumbersFunction      # calculates size of the function
	.section	.rodata                                             # start of read-only data section
.LC0:                               # label for the string
	.string	"The answer is %d\n"    # strinf so that printf can display the result when called
	.text                           # returns us to the text code section
	.globl	main                    # declaring the main funciton as global
	.type	main, @function         # sets the label as a function
main:                               # labels the main function
.LFB1:                              # start of debug info for main
	.cfi_startproc                  # marking the beginning of the main funtion
	pushq	%rbp                    # saving base pointer to the stack in rbp reg
	.cfi_def_cfa_offset 16          # updates the stack info & sets stack pointer 16 bytes under the base pointer
	.cfi_offset 6, -16              # shows the base pointer is offset -16 on the stack
	movq	%rsp, %rbp              # sets the base pointer to the stack pointer
	.cfi_def_cfa_register 6         # tels that %rbp is the new stack base pointer
	subq	$16, %rsp               # 16 is subtracted from rsp reg, which fress 16 bytes of space
	movl	$10, -12(%rbp)          # stores value 10 into rbp at an offset of -12
	movl	$7, -8(%rbp)            # stores value 7 into rbp at an offset of -8
	movl	$0, -4(%rbp)            # stores 0 at an offset of -4 in rbp
	movl	-8(%rbp), %edx          # loads the number 7 from memory and stores in edx reg
	movl	-12(%rbp), %eax         # loads the number 10 from memory and stores in eax reg
	movl	%edx, %esi              # moves 7 from edx to esi to be 1st argument for function
	movl	%eax, %edi              # moves 10 from eax to edi to be 2nd arg for function
	call	myAddTwoNumbersFunction # calls the function to add the two numbers together
	movl	%eax, -4(%rbp)          # stores the result of the function with an offset of -4
	movl	-4(%rbp), %eax          # call the result into the eax register
	movl	%eax, %esi              # puts the result as the argument for print f
	leaq	.LC0(%rip), %rdi        # loads address of the string into rdi register
	movl	$0, %eax                # stores 0 in eax to clear the register for printf
	call	printf@PLT              # calling rint f to display the result as a string
	movl	$0, %eax                # sets return value for main function.
	leave                           # restores the stack & base pointer
	.cfi_def_cfa 7, 8               # updates stack info and sets pointer 8 bytes below return address
	ret                             # returns to caller
	.cfi_endproc                    # marking the end of the maing function 
.LFE1:                              # end of debug infor for main
	.size	main, .-main            # calculates the size of the main function                             
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0" # compiler vers. Helps with debugging
	.section	.note.GNU-stack,"",@progbits           # warning to let user know that doesnt need stack to be executed
