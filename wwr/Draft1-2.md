# Introduction

This is a Python program built by Sean Layton that demonstrates the use of alternative solutions and Big O notation in programming with data structures.

The program defines a function find_max() that takes a list of numbers as input and returns the maximum value in the list. The function has two different implementations, which use different algorithms to solve the problem.

The first implementation uses a simple loop to iterate over the elements in the list and keep track of the maximum value that it encounters. This algorithm has a time complexity of O(n), where n is the number of elements in the list.

The second implementation uses the built-in max() function to find the maximum value in the list. This algorithm has a time complexity of O(1), since it only requires a single function call, regardless of the size of the input list.

To compare the performance of the two algorithms, the program generates a list of random numbers and measures the time it takes to run each implementation of the find_max() function. It then prints the results to the screen.

We can start begin by importing 'time' and 'random':

```{python}
import time
import random
```

## Implementation 1: Simple loop

```{python}
def find_max_1(numbers):
    max_value = numbers[0]
    for i in range(1, len(numbers)):
        if numbers[i] > max_value:
            max_value = numbers[i]
    return max_value
```

## Implementation 2: Using built-in max() function
```{python}
def find_max_2(numbers):
    return max(numbers)
```

## Generate a list of random numbers
```{python}
numbers = [random.randint(0, 100000) for _ in range(10000)]
```

## Measure the time it takes to run each implementation
```{python}
start = time.time()
result1 = find_max_1(numbers)
end = time.time()
elapsed1 = end - start
```

```{python}
start = time.time()
result2 = find_max_2(numbers)
end = time.time()
elapsed2 = end - start
```

# Print the results
```{python}
print(f"Implementation 1: max = {result1}, time = {elapsed1:.4f} seconds")
print(f"Implementation 2: max = {result2}, time = {elapsed2:.4f} seconds")
```