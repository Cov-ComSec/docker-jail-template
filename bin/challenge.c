#include <stdio.h>

int main()
{
    // this can often be useful for remote challenges
    // unless you want to manually flush buffers
    setbuf(stdin, NULL);
    setbuf(stdout, NULL);

    puts("Hello World");
}
