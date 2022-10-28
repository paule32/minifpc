; -------------------------------------------------------------------------------------------
; Input:
; ESI = pointer to the string to convert
; ECX = number of digits in the string (must be > 0)
;
; Output:
; EAX = integer value
; -------------------------------------------------------------------------------------------
    global _string_to_int
    section .text
_string_to_int:
    xor ebx, ebx         ; clear ebx
.next_digit:
    movzx   eax, byte [esi]
    inc     esi
    sub     al, '0'      ; convert from ASCII to number
    imul    ebx, 10
    add     ebx, eax     ; ebx = ebx*10 + eax
    loop    .next_digit  ; while (--ecx)
    mov     eax, ebx
    ret

; -------------------------------------------------------------------------------------------
; Input:
; EAX = integer value to convert
; ESI = pointer to buffer to store the string in (must have room for at least 10 bytes)
;
; Output:
; EAX = pointer to the first character of the generated string
; -------------------------------------------------------------------------------------------
    global _int_to_string
    section .text
_int_to_string:
    add     esi,9
    mov     byte [esi], 0x00

    mov     ebx, 10         
.next_digit:
    xor     edx, edx        ; Clear edx prior to dividing edx:eax by ebx
    div     ebx             ; eax /= 10
    add     dl, '0'         ; Convert the remainder to ASCII 
    dec     esi             ; store characters in reverse order
    mov     [esi], dl
    test    eax, eax            
    jnz     .next_digit     ; Repeat until eax==0
    mov     eax, esi
    ret
