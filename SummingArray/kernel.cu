
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void addKernel(int *a, int *b, int *c, int size)
{
    int tid = ((blockDim.x * threadIdx.y) + threadIdx.x) + ((blockDim.x * blockDim.y) * threadIdx.z);


    int blockId = blockIdx.x + (gridDim.x * blockIdx.y) + (gridDim.x * gridDim.y * blockIdx.z);

    int num_threads_in_block = blockId * blockDim.x * blockDim.y;

    int block_offset = num_threads_in_block * blockDim.z;
    int gid = tid + block_offset;

    if (gid < size)
    {
        c[gid] = a[gid] + b[gid];
    }

}

int main()
{
    int size = 10000;
    
    int NO_BYTES = size * sizeof(int);

    int* h_a, * h_b, * gpu_results;

    h_a = (int*)malloc(NO_BYTES);

    time_t t;

    srand((unsigned)time(&t));
    for (int i = 0; i < size; i++)
    {
        h_a[i] = (int)(rand() & 0xFF);
    }
    for (int i = 0; i < size; i++)
    {
        h_b[i] = (int)(rand() & 0xFF);
    }

    int* d_a, * d_b, * d_c;
    cudaMalloc((int**)&d_a, NO_BYTES);
    cudaMalloc((int**)&d_b, NO_BYTES);
    cudaMalloc((int**)&d_c, NO_BYTES);

    cudaMemcpy(d_a, h_a, NO_BYTES, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, NO_BYTES, cudaMemcpyHostToDevice);

    dim3 block(5, 5, 5);
    dim3 grid(5, 5, 5);

    addKernel << <grid, block >> > (d_a, d_b, d_c, size);
    cudaDeviceSynchronize();


}
