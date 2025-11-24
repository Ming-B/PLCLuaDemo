#include <stdio.h>
#include <time.h>

int fibonacci(int n) { if (n < 2) return n; return fibonacci(n-1) + fibonacci(n-2); }

int main() { 
    clock_t sStart = clock();
    int *fibs = malloc(30*sizeof(int));
    for (int i = 0; i < 30; i++) {
        fibs[i] = fibonacci(i);
    }
    clock_t sEnd = clock();
    printf("C finished in: %g milliseconds", 1000*(double)(sEnd-sStart)/CLOCKS_PER_SEC);
    return 0;
}
