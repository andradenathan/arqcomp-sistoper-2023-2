#include <stdio.h>

void swap(int* a, int* b) {
    int aux = *a;
    *a = *b;
    *b = aux;
}

void bubble_sort(int* A, int tamanho) {
    int i, j, aux;
    int swapped;

    for(i = 0; i < tamanho; i++) {
        swapped = 0;
        for(j = 0; j < tamanho - i - 1; j++) {
            if(A[j] > A[j+1]) {
                swap(&A[j], &A[j+1]);
                swapped = 1;
            }
        }
        
        if(swapped == 0) {
            break;
        }
    }
}

void main() {
    int A[10] = {3, 28, 1, 4, 10, 9, 2, 6, 5, 7};
    bubble_sort(A, 10);
    for(int i = 0; i < 10; i++) {
        printf("A[%d]: %d\n", i, A[i]);
    }
}