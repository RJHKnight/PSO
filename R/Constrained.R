#' @export
constrained <- function(x, k, target_function, constraint_function)
{
  # Optimise F(x) = f(x) + h(k)*H(x)
  # where:
  # * f(x) is the target function
  # * h(k) is the weight function that decays with iteration
  # * H(x) is the penalty function

  this_h <- 1000 * sqrt(k)

  return (target_function(x) + this_h * penalty_function(x, constraint_function))

}

penalty_function <- function(x, constraint_function)
{
  # Construct the penalty function as follows:
  # H(x) = theta(q(x)) . q(x) ^ (gamma(q(x)))
  #
  # where:
  # q(x) = max(0, constraint_function(x)
  # theta(q(x)) = 10, 20, 100, 300 based on value of q(x)
  # gamma(q(x)) = 1 or 2, based on value of q(x)
  q = max(0, constraint_function(x))
  gamma = ifelse(q < 1, 1, 2)

  # q < 0.001 ~ 10
  # q <= 0.1  ~ 20
  # q <= 1    ~ 100
  # q > 1     ~ 200
  theta = ifelse(q < 0.001, 10, ifelse(q <= 0.1, 20, ifelse(q <= 1, 100, 200)))
  return (theta*q^gamma)

}


