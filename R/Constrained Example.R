# Simple example
# Minimise:
# - (25 * x) - (30 * y)
#
#' @export
target_function_1 <- function(x)
{
  (-25 * x[1]) + (-30 * x[2])
}

# Subject to:
# 40 - x / 200 - y / 140 >= 0
# 0 <= x <= 6000
# 0 <= y <= 4000
#' @export
constraint_function_1 <- function(x)
{
  if (x[1] > 6000)
    return (10000)

  if (x[2] > 4000)
    return (10000)

  return (-1 * (40 - (x[1] / 200) - (x[2] / 140)))
}
