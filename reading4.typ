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


Benefits:
- Reduces warp divergence cost
  - It's possible to split the large warps such that divergent
    branches are assigned to different smaller warps.

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
