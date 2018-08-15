#clean up
rm -rf bin
rm -rf iso

#build dirs
mkdir bin
mkdir -p iso/boot/grub

#build the binary
nasm -f elf32 kernel_loader.asm
mv kernel_loader.o bin/
ld -T link.ld -melf_i386 bin/kernel_loader.o -o bin/kernel.elf

#build the iso
cp stage2_eltorito iso/boot/grub/
cp bin/kernel.elf iso/boot/
cp grub_menu.lst iso/boot/grub/menu.lst
genisoimage -R                              \
             -b boot/grub/stage2_eltorito    \
             -no-emul-boot                   \
             -boot-load-size 4               \
             -A TZOS                         \
             -input-charset utf8             \
             -quiet                          \
             -boot-info-table                \
             -o bin/os.iso                       \
             iso

bochs -f bochs_config -q