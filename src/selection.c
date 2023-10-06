#include <stdio.h>

// Função para trocar dois elementos do vetor
void swapElements(int array[], int firstIndex, int secondIndex) {
	int tempValue;
	tempValue = array[firstIndex];
	array[firstIndex] = array[secondIndex];
	array[secondIndex] = tempValue;
}

// Função de ordenação por seleção
void selectionSort(int array[], int size) {
	int start, current, minIndex;

	for (start = 0; start < size - 1; start++) {
		minIndex = start;

		for (current = start + 1; current < size; current++) {
			if (array[current] < array[minIndex]) {
				minIndex = current;
			}
		}

		if (start != minIndex) {
			swapElements(array, start, minIndex);
		}
	}
}

int main() {
	int numbers[] = {5, 4, 3, 2, 1};
	int length = sizeof(numbers) / sizeof(numbers[0]);

	selectionSort(numbers, length);

	for (int index = 0; index < length; index++) {
		printf("%d\n", numbers[index]);
	}
	return 0;
}
