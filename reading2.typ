// Please provide 1 page of summary about the main context of the paper (excluding the appendix) 

// https://dl.acm.org/doi/full/10.1145/3570638

Ryan Thomas Lynch \
CS 8803 GPU \
#datetime.today().display() \
Paper reading assignment 2

// Optimization Techniques for GPU Programming

The paper generalizes and summarizes learnings from hundreds of different articles across years of
GPU programming research.

Some key takeaways are:
ILP (instruction-level parallelism) is underappreciated in the literature.
For example, an emphasis on occupancy means that TLP (thread-level parallelism) is more easily
measured and is prioritized in optimizations.
Look at Volkov's model.

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

Memory access is the most important since it's usually much slower than computation

Themes are not categories and optimizations usually apply to multiple themes.
