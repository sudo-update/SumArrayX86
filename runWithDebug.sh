nasm -f elf64 -l Control.lis -g -F dwarf -o Control.o Control.asm
g++ -c -Wall -m64 -no-pie -g -o Display.o Display.cpp
nasm -f elf64 -l Fill.lis -g -F dwarf -o Fill.o Fill.asm
nasm -f elf64 -l Sum.lis -g -F dwarf -o Sum.o Sum.asm
gcc -c -Wall -m64 -no-pie -g -o Main.o Main.c -std=c11

#Link the object files using the g++ linker
g++ -m64 -no-pie -o SumArray.out Main.o Sum.o Fill.o Display.o Control.o #-std=c11

#Run the program SumArray:
gdb ./SumArray.out
