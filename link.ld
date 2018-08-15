ENTRY(kernel) /* what to load at */

SECTIONS {
    . = 0x00100000; /* load the code at this memory address for grub to find */

    .text ALIGN (0x10000): /* align at 4kb */
    {
        *.(text)
    }

    .rodata ALIGN (0x1000):
    {
        *(.rodata*)
    }

    .data ALIGN (0x1000):
    {
        *(.data)
    }

    .bss ALIGN (0x1000):
    {
        *(COMMON)
        *(.bss)
    }
}