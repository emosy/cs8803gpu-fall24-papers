// Choose one of the two papers:

// [1] Suchita Pati, Shaizeen Aga, Mahzabeen Islam, Nuwan Jayasena, and Matthew D. Sinclair. 2024. T3: Transparent Tracking & Triggering for Fine-grained Overlap of Compute & Collectives. In Proceedings of the 29th ACM International Conference on Architectural Support for Programming Languages and Operating Systems, Volume 2 (ASPLOS '24), Vol. 2. Association for Computing Machinery, New York, NY, USA, 1146-1164. https://doi.org/10.1145/3620665.3640410
// https://dl.acm.org/doi/10.1145/3620665.3640410


// [2] Cong Guo, Rui Zhang, Jiale Xu, Jingwen Leng, Zihan Liu, Ziyu Huang, Minyi Guo, Hao Wu, Shouren Zhao, Junping Zhao, and Ke Zhang. 2024. GMLake: Efficient and Transparent GPU Memory Defragmentation for Large-scale DNN Training with Virtual Memory Stitching. In Proceedings of the 29th ACM International Conference on Architectural Support for Programming Languages and Operating Systems, Volume 2 (ASPLOS '24), Vol. 2. Association for Computing Machinery, New York, NY, USA, 450-466. https://doi.org/10.1145/3620665.3640423
// https://dl.acm.org/doi/epdf/10.1145/3620665.3640423

// Please follow the following format:
// Summary:
// Key topic keywords (name 3 keywords)
// Strength: discuss the novelty,  impact
// Weakness:  limitations of the work
// (option) Any improvements for future paper:

Ryan Thomas Lynch \
CS 8803 GPU \
#datetime.today().display() \
Paper reading assignment 8

For this reading, I chose
"T3: Transparent Tracking & Triggering for Fine-grained Overlap of Compute & Collectives".

= Summary
T3 is a HW/SW co-design system for overlapping computation and communication for tensor
parallelism strategies in large language models.
This includes minor changes to the software and hardware of the system, but allows
for great benefits of automatically transparently overlapping computation and
communication at a finer granularity.

At a software level, T3 requires the outputs of computations which need to be
shared via collective communication to be annotated in the software level
so that it can automatically configure the output address space for
communication.

At a hardware level, T3 requires the addition of lightweight trackers which track
the progress of the computation and can trigger automatic pre-programmed DMA commands
so that GPU compute is not needed to manage the communication.
T3 employs some new techniques such as compute-enhanced memories and a new arbitration
policy to reduce contention.

= Key topic keywords
1. HW/SW co-design
2. Tensor parallelism
3. Collective communication
4. Fine-grained overlap

= Strengths
This technique requires only minor changes to either the hardware or software,
so it can achieve a lot with minor changes.

Having pre-programmed DMA commands helps reduce compute usage further, which
is an unexpected win.

I think this paper effectively demonstrates the value of more fine-grained
overlap between communication and computation.

= Weaknesses
Since both the HW and SW need to be modified, then software kernels with this
technique implemented would have no benefit when run on GPUs which do not
implement T3.
The software annotations need to be performed manually, so there is room for
error or poor usage.

= Improvements for future papers
Automatically detecting which parts of the computation need to be communicated
would be a great benefit so that users could keep their code more portable.
