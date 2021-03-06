# A more interesting optimisation problem
# http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page1760.htm
# Search domain -2 -> 2

#' @export
goldstein_and_price <- function(x, k = 1)
{
  a = 1+(x[1]+x[2]+1)^2*(19-14*x[1]+3*x[1]^2-14*x[2]+6*x[1]*x[2]+3*x[2]^2);
  b = 30+(2*x[1]-3*x[2])^2*(18-32*x[1]+12*x[1]^2+48*x[2]-36*x[1]*x[2]+27*x[2]^2);
  y = a*b;
}
