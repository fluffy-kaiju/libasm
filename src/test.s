; nasm -f elf64 -o main.o main.s && ld -o main main.o && ./main
global printfff
section .text
printfff:
  mov rax, 1        ; write(
  mov rdi, 1        ;   STDOUT_FILENO,
  lea rsi, [rel msg]      ;   "Hello, world!\n",
  mov rdx, msglen   ;   sizeof("Hello, world!\n")
  syscall           ; );

  mov rdi, 0
  ret
section .rodata
  msg: db "Hello, world!", 10
  msglen: equ $ - msg
  
