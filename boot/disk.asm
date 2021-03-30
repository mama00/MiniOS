; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    pusha

    push dx

    mov ah, 0x02 
    mov al, dh   
    mov cl, 0x02
                 
    mov ch, 0x00 

    mov dh, 0x00 
    int 0x13      ; BIOS interrupt
    jc disk_error ; if error (stored in the carry bit)

    pop dx
    cmp al, dh    ; BIOS also sets 'al' to the # of sectors read. Compare it.
    jne sectors_error
    popa
    ret


disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah 
    call print_hex 
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
