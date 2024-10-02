// Please review the papers.

// Timothy G. Rogers, Daniel R. Johnson, Mike O'Connor, and Stephen W. Keckler. 2015. A variable warp size architecture. SIGARCH Comput. Archit. News 43, 3S (June 2015), 489-501. https://doi.org/10.1145/2872887.2750410
// https://dl.acm.org/doi/abs/10.1145/2872887.2750410

//  You might want to think about the following topics.

// Benefits of target applications
// Hardware cost of the architectures
// Relationship between this architecture and cooperative thread group

// The cost of supporting SIMT stacks
// Any weakness/follow-up ideas from this paper?

Ryan Thomas Lynch \
CS 8803 GPU \
#datetime.today().display() \
Paper reading assignment 4

The paper proposes a technique called "Variable warp size."
This means smaller warp sizes by default, but gang schedule
multiple small warps together in the scheduler.

The paper also defines useful terminology for classifying
how applications perform under different warp sizes:
- "Divergent": performance increases as warp size decreases
- "Convergent": performance decreases as warp size decreases
- "Warp-size insensitive": performance is not affected by warp size


Benefits:
- Smaller warps reduce warp divergence cost
  - It's possible to split the large warps such that divergent
    branches are assigned to different smaller warps.
- The gang scheduling avoids the "memory convergence slip"
  - With smaller warps, coalesced memory accesses may be split
    up over multiple cycles (as the warps get scheduled non-concurrently).
    - This results in more memory accesses (despite coalescing).
    - These accesses may still be cache hits, so some "divergent"
      applications may not be affected by memory convergence slip.
  - Gang scheduling


Hardware cost:
- Much more wiring needed
  - More warps in one SM
    - This requires more resources which are allocated per warp.
  - More warps to be handled by the scheduler
  - More PCs (assuming one PC per warp)
- More complex scheduling

Relationship with cooperative thread group:

Cost of supporting SIMT stacks:

Weaknesses/follow-up ideas:
- It's possible to have divergence such that smaller warps still
  have the same divergence cost as larger warps.
  - For example, if even thread indices perform one operation and
    odd thread indices perform another operation, then the warp will
    still have to perform both operations.
  - This is opposed to a situation where the bottom half of a large warp
    performs one operation and the top half performs another operation,
    in which case the warp can be split into two smaller warps and each
    can perform their own operation without having to perform the other
    operation.
- What kinds of divergent workloads are modeled?
- What if an application has a mixture of divergent and convergent
  workloads?
- By specializing the warp size in the hardware, the architecture
  is necessarily less general-purpose.
  - Even if an ensemble of SMs is developed with some using
    smaller warps and some using larger warps, this means that
    few applications will be able to use all hardware resources.
  - Unused hardware resources (dark silicon) are especially harmful
    in the current era of high energy usage GPUs.
  - A potential mitigation could be to use a heterogeneous approach
    which can dynamically enable or disable groups of SMs dependent
    on the application's needs.
      - This requires more work from the programmer to instrument
        their application to determine which SMs should be enabled
        or disabled.
      - However, this would allow one GPU to be reused for multiple
        applications with different warp size requirements.
      - This may also address the dark silicon heat issue if the
        disabled SMs can be literally powered off.
