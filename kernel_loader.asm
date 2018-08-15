; We are using Grub using the El Torito specification which is for booting off CDs.
; The really nice thing about the El Torito specification is that it allows us to load larger boot loaders.
; In this case it allows us to load the Grub stage 2 directly. Grub's El Torito loader further forces us into
; Mutliboot which among other things will
; 1. Load our kernel at 1MB (i.e. the bottom of protected mode memory, right above the limit of real mode)
; 2. Switch into protected mode
; 3. Verify the memory at 1MB == 0x1BADB002
; 4. Jump to the text section of the memory
global loader

                                
MAGIC_NUMBER equ 0x1BADB002     ; Grubs magic constant
FLAGS        equ 0x0            
CHECKSUM     equ -MAGIC_NUMBER  


section .text:
align 4                         ; This is the start of the Grub header
    dd MAGIC_NUMBER             ; The constant Grub will search for to verify its a valid memory location for the kernel  
    dd FLAGS                    ; We are not using any special flags for Grub
    dd CHECKSUM                 ; Checksum for the Grub Loader

loader:
    mov eax, 0xCAFEBABE
.loop:
    jmp .loop