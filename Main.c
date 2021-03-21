// *****************************************************************************
// Program name: "SumArray".  This program creates an array, then reads the
// values of the array through the standard innput device.  It then displays the
// entries of the array, and finally calculates the sum of the entries of said
// array.  The calculated sum is ouptut to the standard output device and then
// returned.
// Copyright (C) 2021 Sean Javiya.
//
// This file is part of the software ArraySum                                                                 *
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// *****************************************************************************
//
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// Author information
//   Author name: Sean Javiya
//   Author email: seanjaviya@csu.fullerton.edu
// Program information
//   Program name: ArraySum
//   Programming languages: One driver module in C, three modules in X86, one
//                          library module in C++, and one bash file
//   Date program began: 2021-Mar-16
//   Date of last update: 2021-Mar-21
//   Date of reorganization of comments: 2021-Mar-21
//   Files in this program: Display.cpp, Fill.asm, Main.c, Control.asm, Sum.asm
//                          run.sh
//   Status: Finished.
//   The program was tested extensively with no errors in (Tuffix) Ubuntu 20.04
// Purpose
//   This program is the driver program.  It will call Control, which will
//   calculate the sum of the entries of an array.  This program will also be
//   submit (for credit) for an assignment conducted during my graduate studies
//   program.
// This file
//    File name: Main.c
//    Language: C
//    Max page width: 132 columns  (this file was not optimized for printing)
//    Compile:
//      gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c11
//    Link:
//      g++ -m64 -no-pie -o SumArray.out Main.o Sum.o Fill.o Display.o Control.o
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern double Control();

int main(int argc, char* argv[]) {
  double resultFromControl = -1.0;
  printf("SumArray is a program by Sean Javiya.\n");
  printf("This software is licensed with GNU GPL3.0\n");
  printf("Version: 1.0\nReleased: March 19, 2021\n");
  resultFromControl = Control();
  printf("The Main driver received %6.8lf and will keep it.", resultFromControl);
  printf("\nThank you for using SumArray.\nFor support contact: Sean Javiya\n");
  printf("                     seanjaviya@csu.fullerton.edu");
  printf("\nA zero will be returned to the operating system.\n");
  return 0;
}
