#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// extern stuff going out
// prototype stuff coming inc
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
