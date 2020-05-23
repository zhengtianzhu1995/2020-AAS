Fun <- function(b, A){
  f = t(b)%*%b - A
  F = 0.5*(norm(f,"F"))^2
  return(F)
}

gradient <- function(b, A){
  g = 2*b%*%(t(b)%*%b - A)
  return(g)
}