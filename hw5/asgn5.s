.data               # start of data section
# put any global or static variables here
#setting A and B as global variables
A: .quad 5          #  A = 5
B: .quad 3          #  B = 3

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
multiplyString: .string "Result of A x 5 is: %d\n"
numTwoString: .string "Result of (A + B) - (A / B) is: %d\n"
numThreeString: .string "Result of (A - B) + (A * B) is: %d\n"

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===

main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===

/* ---Problem 1: A * 5---*/
# multiply a = 5 * b = 3, c is  = 15 (c being the result) 
#setting up variables. A & B
movq A, %rax        # putting A into rax
imulq $5, %rax      # multiplying A x 5 and store it in ra
 
#printf sum of mult. is %D, c
# save caller save registers.
# did not save any
# set up args in registers: rdi, rsi, rdx & rcx
movq $multiplyString, %rdi     # pointer to string thats in rdi
movq %rax, %rsi                # moves c into rsi
# 0 in rax for no floating point regs.
movq $0, %rax                  # stores 0 into rax
# then call the function
call printf                    # printing result to terminal

# ==============================================================================
/* ---Problem 2: (A + B) - (A / B)---*/
# using same variables from problem 1
# add A + B   ,    A = 5    &    B = 3
movq A, %rax    # moved a(5) into rax
movq B, %rbx    # b=3 in rbx
#add a + b so add rax + rbx
addq %rbx, %rax  #A+B

#need to store a+b in another register temp.
#store in  r10 reg.
movq %rax, %r10

# divide A / B
movq A, %rax   # puts 5 back into rax
#sign extend
cqto  #extends sign into rdx:rax
#now  divide 
idivq %rbx
# after dividing and getting answer we subtract (A/B) from (A+B), then store into %r10
subq %rax, %r10
#printf "Result of A / B is: %d\n"
movq $numTwoString, %rdi # put string pointer into rdi
movq %r10, %rsi          # moves C(result) into rsi
movq $0, %rax            # stores 0 into rax. Clears rax for no floating point
call printf              # printing result to terminal
  

# ==============================================================================
/* ---Problem 3: (A - B) + (A * B)---*/

# using same variables from problem 1 & 2
# subtract A - B   ,    A = 5    &    B = 3
movq A, %rax    # moved a(5) into rax
movq B, %rbx    # b=3 in rbx
#add a + b so add rax + rbx
subq %rbx, %rax  #A-B
#need to store a-b in another register temp.
#store in  r11 reg.
movq %rax, %r11

#multiplication
#now need to multiply A x B. used same code from prob 1.
movq A, %rax    # moved 5 into rax
movq B, %rbx    # b=3 in rbx
#a*b multiply
imulq %rbx       # multiplying rbx * rax so a * b. Result stored in rdx:rax
#add together now
addq %rax, %r11

#printf "Result of (A - B) + (A * B) is: %d\n"
movq $numThreeString, %rdi
movq %r11, %rsi
movq $0, %rax
call printf


# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return