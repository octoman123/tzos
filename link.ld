ENTRY(loader) /* what to load at */

SECTIONS {
    . = 0x00100000; /* load the code at this memory address for grub to find */

    .text ALIGN (0x1000) :   /* align at 4 KB */
    {
        *(.text)             
    }

    .rodata ALIGN (0x1000) : /* align at 4 KB */
    {
        *(.rodata*)          
    }

    .data ALIGN (0x1000) :   /* align at 4 KB */
    {
        *(.data)             
    }

    .bss ALIGN (0x1000) :    /* align at 4 KB */
    {
        *(COMMON)           
        *(.bss)             
    }
}