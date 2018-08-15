#clean up
rm -rf bin
rm -rf iso

#build dirs
mkdir bin
mkdir -p iso/boot/grub

#build the binary
nasm -f elf32 kernel.asm
mv kernel.o bin/
ld -T link.ld -melf_i386 bin/kernel.o -o bin/kernel.elf

#build the iso
cp stage2_eltorito iso/boot/grub/
cp bin/kernel.elf ios/boot/
cp grub_menu.lst iso/boot/grub/menu.lst
genisoimage -R                   \
    -b boot/grub/stage2_eltorito \
    -no-emul-boot                \
    -boot-load-size 4            \
    -A os                        \
    -input-charset utf8          \
    -quiet                       \
    -boot-info-table             \
    -o bin/os.iso                \
    iso

bochs -f bochs_config -q