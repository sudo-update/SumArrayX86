nasm -f elf64 -l Control.lis -o Control.o Control.asm
g++ -c -Wall -m64 -no-pie -o Display.o Display.cpp
nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm
nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm
gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c11

#Link the object files using the g++ linker
g++ -m64 -no-pie -o SumArray.out Main.o Sum.o Fill.o Display.o Control.o #-std=c11

#Run the program SumArray:
./SumArray.out
