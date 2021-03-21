#include <stdio.h>
#include <cstdlib>
extern "C" void display_assembly_array(double arrayToPrint[], long length);
void display_assembly_array(double arrayToPrint[], long length) {
  for (int i = 0; i < length; ++i) {
    printf("%6.8lf\n", arrayToPrint[i]);
  }
}
