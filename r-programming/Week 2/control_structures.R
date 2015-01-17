# If/Else

x <- 2
y <- if(x < 3){
  10
} else {
  0
}

# For loops

for(i in 1:10) {
  print(i)
}

x <- c("a", "b", "c", "d")
print(seq_along(x))

x <- matrix(1:6,2,3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i,j])
  }
}

# While loops
count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}

z <- 5
while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5)
  if(coin == 1) {
    z <- z + 1
  } else {
    z <- z - 1
  }
}

# Repeat, break, next

x0 <- 1
tol <- 1e-8

# Creates an infinite loop until a solution is found
# Requires an algorithm that will converge.
# Better to use a for loop
repeat {
  x1 <- computeEstimate()
  
  if(abs(x1 - x0) < tol) {
    break
  } else {
    x0 <- x1
  }
}

# Use next when you want to skip an iteration in a loop
for(i in 1:100){
  if(i <= 20){
    ## Skip the next 20 iterations
    print(i)
    next
  }
  # do something here
  print("Out of the loop")
}