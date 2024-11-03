# CUDA 3D Array Summation Example

This repository provides a CUDA example that demonstrates **element-wise array summation** in a 3D grid and block configuration.

## Overview

The program performs an element-wise summation of two integer arrays (`a` and `b`) and stores the result in array `c`. The summation is computed both on the CPU and GPU, and results are compared for validation.

### Key Components

- **`addKernel`**: A CUDA kernel function that calculates a unique global ID (GID) for each thread in a 3D block and grid setup. Each thread computes the sum of corresponding elements in `a` and `b`, storing the result in `c`.
- **`sum_array_cpu`**: A CPU function for array summation, used as a baseline for comparison with GPU results.

## Execution

The kernel is launched with a 3D grid and block configuration. The program compares CPU and GPU results to ensure accuracy.
