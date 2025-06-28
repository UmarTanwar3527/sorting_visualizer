import 'dart:async';

// BUBBLE SORT
Future<void> bubbleSort(List<int> arr, Function refresh, int delay) async {
  int n = arr.length;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
        refresh(j, j + 1); // Pass targeted and running indices
        await Future.delayed(Duration(milliseconds: delay));
      }
    }
  }
}

// SELECTION SORT
Future<void> selectionSort(List<int> arr, Function refresh, int delay) async {
  int n = arr.length;
  for (int i = 0; i < n; i++) {
    int minIndex = i;
    for (int j = i + 1; j < n; j++) {
      if (arr[j] < arr[minIndex]) {
        minIndex = j;
      }
    }
    if (minIndex != i) {
      int temp = arr[i];
      arr[i] = arr[minIndex];
      arr[minIndex] = temp;
      refresh(i, minIndex); // Pass targeted and running indices
      await Future.delayed(Duration(milliseconds: delay));
    }
  }
}

// INSERTION SORT
Future<void> insertionSort(List<int> arr, Function refresh, int delay) async {
  int n = arr.length;
  for (int i = 1; i < n; i++) {
    int key = arr[i];
    int j = i - 1;
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j--;
      refresh(j + 1, i); // Pass targeted and running indices
      await Future.delayed(Duration(milliseconds: delay));
    }
    arr[j + 1] = key;
    refresh(j + 1, i); // Pass targeted and running indices
    await Future.delayed(Duration(milliseconds: delay));
  }
}

// MERGE SORT
Future<void> mergeSort(
  List<int> arr,
  int left,
  int right,
  Function refresh,
  int delay,
) async {
  if (left < right) {
    int mid = (left + right) ~/ 2;
    await mergeSort(arr, left, mid, refresh, delay);
    await mergeSort(arr, mid + 1, right, refresh, delay);
    await _merge(arr, left, mid, right, refresh, delay);
  }
}

Future<void> _merge(
  List<int> arr,
  int left,
  int mid,
  int right,
  Function refresh,
  int delay,
) async {
  List<int> leftArray = arr.sublist(left, mid + 1);
  List<int> rightArray = arr.sublist(mid + 1, right + 1);

  int i = 0, j = 0, k = left;

  while (i < leftArray.length && j < rightArray.length) {
    if (leftArray[i] <= rightArray[j]) {
      arr[k] = leftArray[i];
      i++;
    } else {
      arr[k] = rightArray[j];
      j++;
    }
    k++;
    refresh(k, -1); // Pass targeted and running indices
    await Future.delayed(Duration(milliseconds: delay));
  }

  while (i < leftArray.length) {
    arr[k] = leftArray[i];
    i++;
    k++;
    refresh(k, -1); // Pass targeted and running indices
    await Future.delayed(Duration(milliseconds: delay));
  }

  while (j < rightArray.length) {
    arr[k] = rightArray[j];
    j++;
    k++;
    refresh(k, -1); // Pass targeted and running indices
    await Future.delayed(Duration(milliseconds: delay));
  }
}


// QUICK SORT
Future<void> quickSort(
  List<int> arr,
  int low,
  int high,
  Function refresh,
  int delay,
) async {
  if (low < high) {
    int pivotIndex = await _partition(arr, low, high, refresh, delay);
    await quickSort(arr, low, pivotIndex - 1, refresh, delay);
    await quickSort(arr, pivotIndex + 1, high, refresh, delay);
  }
}

Future<int> _partition(
  List<int> arr,
  int low,
  int high,
  Function refresh,
  int delay,
) async {
  int pivot = arr[high];
  int i = low - 1;

  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      int temp = arr[i];
      arr[i] = arr[j];
      arr[j] = temp;
      refresh(i, j); // Pass targeted and running indices
      await Future.delayed(Duration(milliseconds: delay));
    }
  }

  int temp = arr[i + 1];
  arr[i + 1] = arr[high];
  arr[high] = temp;
  refresh(i + 1, high); // Pass targeted and running indices
  await Future.delayed(Duration(milliseconds: delay));

  return i + 1;
}
