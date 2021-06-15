# Particle Swarm Optimisation in R

*Quite possibly a POS PSO...*

## Introduction

A basic implementation of a Particle Swarm Optimiser written in R. 

This was written purely for my personal education, there are no doubt more sophisticated and complete implementations available. Use at your own risk...

## Installation

You can install the development version from github using devtools:

``` r
# install.packages("devtools")
devtools::install_github("rjhknight/PSO")
```

## Example Usage

The main optimiser can be invoked as follows:

```r
pso(goldstein_and_price, 2, -2, 2)
```

Where *goldstein_and_price* is an inbuilt 2D Optimisation problem.

## Example Output

The Goldstein and Price function is a non-trivial 2-D optimisation problem in the search domain of ![range](http://www.sciweavers.org/upload/Tex2Img_1623218874/render.png).

The function output is as follows:

![function_output](https://github.com/RJHKnight/PSO/blob/main/output/goldstein_and_price.jpg)

It contains one global maxima and several local minima. 

The true global minima is found at (0,-1) with a value of 3.

The progress of the swarm optimisation (for swarm size of 100) over the first 100 iteration is as follows:

![swarm_output](https://github.com/RJHKnight/PSO/blob/main/output/optimisation_output.gif?raw=true)

Which is pretty cool!

## Constrained Optimisation

We can constrain the optimisation by defining a set of non-linear constraints in the form:

![const](http://www.sciweavers.org/upload/Tex2Img_1623756948/render.png)

We can then adjust our value function to include a penalty function. Specifically, we use a function of the form:

![penalty](http://www.sciweavers.org/upload/Tex2Img_1623757165/render.png)

Where

![h](http://www.sciweavers.org/upload/Tex2Img_1623757344/render.png)

and q is related to the constraints by:

![q](http://www.sciweavers.org/upload/Tex2Img_1623757513/eqn.png)

And h(k) reprents a damping term based on the iteration number k

## Constrained Optimisation Usage

I've provided a wrapper function for the calculation of H(x) given a specific (single) constraint g(x). This will provide some base implementations for theta and gamma. It can be invoked as follows:

```r
function_with_penalty <- function(x, k) constrained(x, k, target_function = target_function_1, 
    constraint_function = constraint_function_1)
    
pso(function_with_penalty, 2, 0, 6000)
```

## Constrained Optimisation Example

constraint_function_1 and target_function_1 represent a toy optimisation problem, where the task is to maximise:

25x + 30y

Subject to the constraints:

(1/200) x + (1/140) y <= 40;
0 <= x <= 6000;
0 <= y <= 4000

Running the swarm optimisation above, it converges within ~70 iterations to a solution of:

x = 6000,
y = 1400

at which the value f(x) = 192000

which is the correct solution.

## References

* A great intro to PSO: https://yarpiz.com/440/ytea101-particle-swarm-optimization-pso-in-matlab-video-tutorial
* Some non-trivial optimisation functions: http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page364.htm
* Details of the penalty method for constrained optim: https://www.cs.cinvestav.mx/~constraint/papers/eisci.pdf
* The toy constrained optimisation example: https://people.eng.unimelb.edu.au/pstuckey/COMP90046/lec/s1_modelling.pdf
