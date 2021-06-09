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

## References

* A great intro to PSO: https://yarpiz.com/440/ytea101-particle-swarm-optimization-pso-in-matlab-video-tutorial
* Some non-trivial optimisation functions: http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page364.htm
