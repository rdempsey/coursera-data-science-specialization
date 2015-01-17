# Add two numbers
add2 <- function(x, y){
    x + y
}

# Return all values above n
above10 <- function(x){
    use  <- x > 10
    x[use]
}

# Return all values above n
above <- function(x, n = 10){
    use <- x > n
    x[use]
}

# Calculate the mean of each column in a dataset
columnmean <- function(x, removeNA = TRUE) {
    nc <- ncol(x)
    means <- numeric(nc)
    for(i in 1:nc) {
      means[i] <- mean(x[,i], na.rm = removeNA)
    }
    means
}

# Extending another function
# Use ... to keep "absorb" all of the other arguments in the original function
# Can also be used for generic functions to pass arguments to methods
# Also necessary when you don't know the amount of arguments in advance; example: args(paste)
# Any arguments after the ... have to be named explicitly and in full
myplot <- function(x, y, type = "1", ...){
  plot(x, y, type = type, ...)
}

# R uses lexical scoping, which means that the values of free variables are searched for in the
# environment (collection of symbol/value pairs) in which the function was defined
# Function + an environment = a closure or function closure
# Global environment = workspace, or the namespace of a package

# Here 'n' is a free variable. This is okay because n is defined in the make.power function.
# This function can be used to construct many other functions
make.power <- function(n) {
  pow <- function(x) {
    x ^n
  }
  pow
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)

# Get the environment for a function
ls(environment(cube))
get("n", environment(cube))

# Scoping - Optimization

# A constructor function carries everything needed, like baggage
# Optimization functions in R minimize functions, so you need to use the negative log-likelihood

make.NegLogLik <- function(data, fixed=c(FALSE, FALSE)) {
  params <- fixed
  # Returns a log likelihood for a normal distribution
  function(p) {
      params[!fixed] <- p
      mu <- params[1] # mean
      sigma <- params[2] # standard deviation
      a <- -0.5*length(data)*log(2*pi*sigma^2)
      b <- -0.5*sum((data-mu)^2) / (sigma^2)
      -(a +b)
  }
}

set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)

optim(c(mu = 0, sigma = 1), nLL)$par

# Optimize sigma at 2
nLL <- make.NegLogLik(normals, c(FALSE, 2))
optimize(nLL, c(-1, 3))$minimum

# Fix mu = 1, optimize over sigma
nLL <- make.NegLogLik(normals, c(1, FALSE))
optimize(nLL, c(1e-6, 10))$minimum
