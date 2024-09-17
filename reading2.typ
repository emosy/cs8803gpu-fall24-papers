// Please provide 1 page of summary about the main context of the paper (excluding the appendix) 

// https://dl.acm.org/doi/full/10.1145/3570638

Ryan Thomas Lynch \
CS 8803 GPU \
#datetime.today().display() \
Paper reading assignment 2

// Optimization Techniques for GPU Programming

The paper generalizes and summarizes learnings from hundreds of different articles across years of
GPU programming research.
I believe it is very useful as a reference for identifying which techniques need to be applied, when and why to apply them, and how to apply them.

The most interesting takeaway I noticed was that ILP (instruction-level parallelism) is underappreciated in the literature.
For example, an emphasis on occupancy means that TLP (thread-level parallelism) is more easily
measured and is prioritized in optimizations.
// Look at Volkov's model.

Optimizations are presented in four themes:
- Memory Access
  - On-Chip
  - Off-Chip
- Irregularity
  - How to map irregular algorithms efficiently to GPUs
- Balancing
  - Balancing the Instruction Stream
  - Parallelism-related Balancing
  - Synchronization-related Balancing
- Host Interaction

// Memory access is the most important since it's usually much slower than computation

Themes are not categories and optimizations usually apply to multiple themes.

When considering the realm of optimization techniques to apply, the authors suggest a high-level process to follow:
1. Application-specific: Consider optimizations that address specifics of the application
  - Whole-application vs kernel-specific optimizations: "It is often more useful to optimize the pipeline of kernels"
  - Are kernels compute or memory bound?
  - Do kernels reuse data?
  - Are kernels regular or irregular?
2. Identify bottlenecks
  - Memory Access
    - Global memory bandwidth
    - Latency
  - Irregularity
  - Balancing
  - Host Interaction
3. Architectural evolution: Consider the architecture's new features and changes
4. Quantitative Performance Potential: Consider which optimizations to target based on their potential performance gains, although they are not totally comparable

Here are some highlights of interesting optimizations from the themes:

== Memory Access
=== On-Chip
Using dedicated memories such as constant memory, texture memory (optimized for accesses with two-dimensional spatial locality, but which can be used in very clever ways such as reading packed string data), and shared memory (optimized for accesses within one block). 
Shared memory can be used for multiple purposes such as reducing the cost of multiple memory accesses, passing values between threads within a block (introducing synchronization barriers), and reducing the cost of uncoalesced or irregular memory accesses.
Shared memory usage introduces the problem of avoiding bank conflicts, but there are also techniques for this.


=== Off-Chip
Coalescing memory accesses is the second-most applied optimization.
It involves memory requests from multiple threads to global memory being automatically combined into fewer requests to the memory system when possible. 
The paper notes that although the set of rules for determining if coalescing is possible change with each GPU architecture, the general trend is that the rules are becoming more relaxed with newer architectures.

There are multiple techniques documented to change data access patterns depending on the data layout such as reorganizing threads, tuning the thread block size, tiling, parallelizing differently, or using more advanced indexing such as a space-filling curve.
If the data layout does not allow for enough optimization, then the data layout can be changed such as transpositions (row-major to column-major, etc.), adding padding, or changing data hierarchies (e.g., struct of arrays to array of structs).
The data layout may also be changed during computation when the cost of changing the layout is low and the benefits of different layouts for different stages is high.

To simulate the benefits of coalesced memory accesses, programmers can also manually do a coalesced load into shared memory which does not have the additional cost of multiple concurrent accesses (but which does have bank conflict constraints).

// == Irregularity
// === Reducing Divergence
// === Sparse Data Layouts

== Balancing
=== Balancing the Instruction Stream
By assigning work to warps rather than to threads or blocks, the unique structure of warp execution can be leveraged to balance the instruction stream.
This technique can be extended to warp specialization where different warps perform different workloads which can be combined via another warp.

=== Parallelism-related Balancing
A major technique involves varying the amount of work per thread or block.
The major tradeoff comes from gaining more data reuse at the cost of greater resource usage (more registers and shared memory needed).
The optimal amount of work per thread must be auto-tuned for each application.

Auto-tuning is useful across many applications where there are variable parameters (e.g. thread block dimensions, work per thread, etc.).
The search space for these dimensions must be explored by testing different configurations and measuring performance.
Additional tuning dimensions can be added beyond what is normally considered such as the data layout (e.g. sparsity representation).


