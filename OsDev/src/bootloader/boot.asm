org 0x700 ;address our system win address org
bits 16 ; give 16 bits

%define ENDL 0x0D , 0x0A 

#
# BIOS parameters
#



main: 
    ;setup data segments
    mov ax , 0
    mov ds,ax
    mov es, ax

    ;setup stack
    mov ss , ax
    mov sp , 0x7C00

    ;print msg

    mov si , msg_hello
    call puts

    hlt

.halt:
    jmp .halt


;print string while char is not a null
puts:
    push si
    push ax
.loop:
    lodsb
    or al ,al 
    jz .done

    mov ah , 0x0e
    mov bh , 0
    int 0x10

    jmp .loop
.done:
    pop ax
    pop si
    ret




msg_hello: db 'Hello, world!', ENDL , 0



times 510-($-$$) db 0 ; $-$$ is len of out programm in bites
dw 0AA55h