// Choose one of the two papers
// [1] Michael Davies, Ian McDougall, Selvaraj Anandaraj, Deep Machchhar, Rithik Jain, and Karthikeyan Sankaralingam. 2024. A Journey of a 1,000 Kernels Begins with a Single Step: A Retrospective of Deep Learning on GPUs. In Proceedings of the 29th ACM International Conference on Architectural Support for Programming Languages and Operating Systems, Volume 2 (ASPLOS '24), Vol. 2. Association for Computing Machinery, New York, NY, USA, 20-36. https://doi.org/10.1145/3620665.3640367
// https://dl.acm.org/doi/10.1145/3620665.3640367

// [2] Zejia Lin, Aoyuan Sun, Xianwei Zhang, and Yutong Lu. 2024. MixPert: Optimizing Mixed-Precision Floating-Point Emulation on GPU Integer Tensor Cores. In Proceedings of the 25th ACM SIGPLAN/SIGBED International Conference on Languages, Compilers, and Tools for Embedded Systems (LCTES 2024). Association for Computing Machinery, New York, NY, USA, 34-45. https://doi.org/10.1145/3652032.3657567
// https://dl.acm.org/doi/pdf/10.1145/3652032.3657567

Ryan Thomas Lynch \
CS 8803 GPU \
#datetime.today().display() \
Paper reading assignment 9

For this reading assignment I chose "A Journey of a 1,000 Kernels Begins with a Single Step".

= Summary
The authors perform a survey of state-of-the-art AI applications
across many use cases in order to propose a new evaluation suite
they call CaSiO.
The need for a new suite spanning many use cases, hardware types,
model architectures, and algorithms is motivated by observing
that competing performance suites are narrowly focused on specific
architectures, generations, and applications.
In addition to introducing CaSiO to be reused by future works, the
authors also identify multiple insights that are systematically
present across almost all AI research approaches.
For example, the constant need for HW-SW co-design is addressed as
"HW under-utilization" and is referenced multiple times in the paper
where the limiting factor of performance is the poor mapping between
the software implementation and the hardware's most efficient manner
of operation.

= Key topic keywords
1. Evaluation suite
2. Longitudinal study
3. AI Applications

= Strengths

= Weaknesses

Contrasting this paper with the 80-page beast that is "Optimization
Techniques for GPU Programming", it is apparent that this paper cannot
go into nearly as much detail.
I believe this is because the field is moving so fast that established
practices cannot be as easily referenced, and much work is overlapping
and does not efficiently further the research knowledge frontier.
I think this should be expected for a paper in a fast-moving field like
AI, where you have to run so fast you're going to trip over yourself
more than you should.

For example, there are ten applications chosen for analysis in this
ensemble, but it's likely that maybe half of these applications will not
be considered relevant to the state-of-the-art in three years.
Compare this with GPU programming where video games and high-performance
computing simulations are two dominating applications that have stayed
relevant for decades.
On the other hand, ten feels like too small a number to effectively
represent a field as diverse as artificial intelligence in 2024.

Although I cannot propose a better alternative, I believe the manner of
selection of the applications is not the most efficient to provide future
research value.
For example, considering research impact based on the number of citations
may favor older topics even if they are not as relevant to the modern
pressing issues.
Consider the convolutional neural network versus the transformer architecture.
I would posit that much of the cost of compute this month on cutting-edge
machine learning comes from transformers, but they likely have fewer citations
than CNNs.
Another axis where CNNs would be favored over transformers would be in
availability.
Of the leading state-of-the-art transformer models, I believe only Llama
from Meta is available openly.
This doesn't mean that intense research isn't happening on closed models,
and in fact there is likely more total research being performed at companies
like OpenAI, xAI, Anthropic, etc. on their closed models than at Meta on
Llama.


= Improvements for future papers

I believe that the authors may need to be more biased in promoting their views
of what the future of AI research needs.
For example, if I believe that the next two years of AI research will be
dominated by transformers, then I would choose to put more transformers in the
suite I build.
Of couse, we can't become so myopic that we miss "the next big thing", but I
think we need to recognize that we're ultimately betting on which paper would
be most useful to write.

I believe there needs to be another paper like this but for accelerator
architectures.
We as a community focus obsessively over GPUs (and on CUDA specifically), which
is understandable given the landscape of HW research.
However, from my personal experience working with Tesla's custom neural network
accelerator hardware, I believe there is much to be explored in the area of
heterogeneous AI accelerators that don't look just like a GPU.
For example, more open research into Amazon's Trainium architecture would be
an area I would seek to foster.
