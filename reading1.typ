// Read Sections 1-4 of the CUDA Programming Guide
// https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html
// and Chapters 1 and 3 of the
// General-Purpose Graphics Processor Architectures
// https://github.com/tpn/pdfs/blob/master/General-Purpose%20Graphics%20Processor%20Architecture%20(2018).pdf

// Write a one-page summary (500-700 words). Submit your summary as a PDF.

// Reading 1: CUDA Programming Guide

SMs
// Skip section 1
// section 2: Programming Model

what are kernels
threads, blocks, grids

threads per block (and dims) and blocks per grid (and dims) is determined at kernel invocation time.

#quote(attribution: [CUDA 2.2])[
Thread blocks are required to execute independently: It must be possible to execute them in any order, in parallel or in series.
]
one block goes on one SM
threads within a block can share memory via shared memory and `__syncthreads()`.
Plus cooperative group APIs
shared memory is expected to be a low-latency memory near each processor core (much like an L1 cache)

clusters is a new feature between grids and blocks where the clusters are scheduled on the same GPC (GPU processing cluster)

clusters have distributed shared memory

global memory (hierarchy)

async heterogeneous

compute capability

// section 3: programming interface
can write kernels in cuda c++ or PTX
backwards compatible but not forwards compatible

memory init
Linear memory is typically allocated using `cudaMalloc()` and freed using `cudaFree()` and data transfer between host memory and device memory are typically done using `cudaMemcpy()`.

CUDA exposes these independent tasks which can be run concurrently (depending on device support):
- compute on host, device
- memory transfers from host, device to host, device or within same device

unified virtual address space
for 64-bit apps. provides portable pointers

textures and graphics supported too
// section 4: hardware implementation

scalable multi-threaded Streaming Multiprocessors (SMs)
one SM may handle hundreds of threads simultaneously, so it uses a SIMT (single instruction, multiple thread) execution model.
SIMT is similar to SIMD but it allows the programmer to abstract over the equivalent of the SIMD width so that correctness is maintained even if the hardware changes or the program is run inefficiently.
within a single thread, instruction-level parallelism such as pipelining is used
there is no speculation or branch prediction, and instructions are always issued in order

in execution, threads are grouped into warps.
warps are groups of 32 threads that are executed in lockstep
blocks are partitioned into warps so that the first warp has thread ID 0 and all warps contain consecutive thread IDs
within a warp, threads may diverge by disabling execution on certain threads, but this has performance costs.

with the volta architecture, warps no longer share one program counter.
now, each thread has its own program counter and can execute independently of the other threads in the warp.

the hardware implementation of the execution contexts for each warp is maintained such that context
switches between warps has no cost since the warp's context is kept on-chip for the warp's lifetime.

the warp scheduler will select a warp with all of its active threads ready to execute and will issue an instruction to the warp's threads

the number of blocks and warps that can live on the SM at once is dependent on the interaction of multiple limiting factors
including software-imposed requirements such as
the number of registers per thread and amount of shared memory per block
and hardware-imposed limits such as the maximum number of blocks per SM and the amount of shared memory available on the SM.


// General-Purpose
// Graphics Processor Architectures

// chapter 1
// introduction

GPUs can be much more energy efficient and faster than CPUs,
which is necessary as Dennard Scaling and Moore's Law come to an end.
Modern GPUs are Turing complete and very capable for general-purpose computation.

A modern GPU is usually controlled by a CPU which handles memory and coordination of the GPU.
With virtual memory, the memory allocation and copying process can be abstracted away from the programmer.
// chapter 3
// The SIMT Core: Instruction
// and Register Data Flow


SIMT stack
branches is hard

SIMT deadlock

warp scheduling

i don't understand the one, two, three loop approximation
or the hazards.
