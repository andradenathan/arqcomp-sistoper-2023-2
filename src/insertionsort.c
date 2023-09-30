#include <stdio.h>

void insertion_sort(int *A, int tamanho) {
    int i, j, aux;
    for (i = 1; i < tamanho; i++) {
        aux = A[i];
        j = i-1;
        while(j >= 0 && aux < A[j]) {
            A[j+1] = A[j];
            j--;
        }
        A[j+1] = aux;
    }
}

void main() { 
    int A[] = { 5, 2, 4, 6, 1, 3 };
    int arr_size = sizeof(A) / sizeof(A[0]);
    insertion_sort(A, arr_size);
    for(int i = 0; i < arr_size; i++) {
        printf("A[%d]: %d \n", i, A[i]);
    }
}