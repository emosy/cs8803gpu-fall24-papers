// This week's paper topic is accelerating graph using CUDA.
// [1] option 1:

// Scalable gpu graph traversal, (https://research.nvidia.com/sites/default/files/pubs/2012-02_Scalable-GPU-Graph/ppo213s-merrill.pdf)

// Provide a short summary of the paper.
// Discuss the performance optimization techniques in terms of compute/memory.
// Explain what is linear parallelization in this paper.

// [2] option 2:

// If you think the paper requires too much background knowledge, choose any of the references in the paper or

// https://cdn.iiit.ac.in/cdn/cvit.iiit.ac.in/images/ConferencePapers/2007/Pawan07accelerating.pdf
// or other materials on running graph algorithms on CUDA.
// Please provide a short summary of how GPUs have been used for accelerating graph algorithms.

Ryan Thomas Lynch \
CS 8803 GPU \
#datetime.today().display() \
Paper reading assignment 7

I chose the paper "Scalable GPU Graph Traversal".
This paper focuses on a breadth-first search (BFS) implementation
to parallelize BFS better on GPUs while maintaining asymptotically
optimal performance.

= Overview
The paper introduces an algorithm based on prefix sums so that
scatter offsets can be used to parallelize more effectively.
I believe it operates by adding children to an array and then
using the scatter offsets to determine where the children need
to be placed in the array.

= Terms introduced
The paper introduces useful terms like "quadratic parallelization"
and "linear parallelization".

== Quadratic parallelization
Quadratic parallelization is when the number of threads is
proportional to the number of vertices or edges in the graph.
This is extremely naive as it requires many masked threads,
and further it requires $O(n^2 + m)$ time complexity.

== Linear parallelization
Linear parallelization is when the number of threads is
only proportional to the number of vertices or edges
in that iteration's respective frontier.
This means that the number of threads may be difficult
to determine ahead of time, but the benefit is that
the amount of work is in order $O(n + m)$, hence
the term "linear".

== Frontier management
The authors further examine "in core" and "out of core"
management of the frontiers.
In in-core management, the frontiers are stored and processed
online, while in out-of-core management, the frontiers are
stored between iterations.
Most implementations use out-of-core management, but the
explanation given does not make it clear to me why it is
better (though I suspect it has lower implementation complexity).

= Observations
One thing I've noticed across many clever GPU parallelization
algorithms is you need some way to index into a sparse space.
This means you need to consider the particular layout and
semantics of the problem.

I think the prefix sum and scatter method is very clever.

I wish the paper went into more detail about how they discovered
this implementation and had more examples of how it works.
I think there's basically less than half a page of explanation
about the actual proposed algorithm.
