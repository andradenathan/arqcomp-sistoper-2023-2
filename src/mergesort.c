#include <stdio.h>
#include <stdlib.h>

void merge(int A[], int inicio, int meio, int fim)
{
    int i, j, k;
    int arr_esq_tam = meio - inicio + 1;
    int arr_dir_tam = fim - meio;
 
    int arr_esq[arr_esq_tam], arr_dir[arr_dir_tam];
 
    for (i = 0; i < arr_esq_tam; i++)
        arr_esq[i] = A[inicio + i];
    for (j = 0; j < arr_dir_tam; j++)
        arr_dir[j] = A[meio + 1 + j];
 
    i = 0;
    j = 0;
    k = inicio;
    while (i < arr_esq_tam && j < arr_dir_tam) {
        if (arr_esq[i] <= arr_dir[j]) {
            A[k] = arr_esq[i];
            i++;
        } else {
            A[k] = arr_dir[j];
            j++;
        }
        k++;
    }
 
    while (i < arr_esq_tam) {
        A[k] = arr_esq[i];
        i++;
        k++;
    }
 
    while (j < arr_dir_tam) {
        A[k] = arr_dir[j];
        j++;
        k++;
    }
}

void merge_sort(int A[], int esq, int dir) {
    if(esq < dir) {
        int meio = esq + (dir - esq)/2;

        merge_sort(A, esq, meio);
        merge_sort(A, meio+1, dir);
        merge(A, esq, meio, dir);
    }
}

void main() {
    int A[] = {3, 28, 1, 4, 10, 9, 2, 6, 5, 7};
    int arr_size = sizeof(A) / sizeof(A[0]);
    merge_sort(A, 0, arr_size - 1);
    for(int i = 0; i < arr_size; i++) {
        printf("A[%d]: %d\n", i, A[i]);
    }
}