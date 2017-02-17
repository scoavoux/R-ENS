d <- data.frame(x = rnorm(100, mean = 10, sd = 3),
                y = rnorm(100, mean = 16, sd = 5))
d

centrer_reduire <- function(v){
  cr <- (v - mean(v))/sd(v)
  return(cr)
} 

## Première option, lapply
d[] <- lapply(d, centrer_reduire)
## Ou en créant la fonction directement dans lapply
d[] <- lapply(d, function(v) (v - mean(v))/sd(v))


## Deuxième option: boucle for
for(i in 1:ncol(d)){
  d[, i] <- centrer_reduire(d[, i])
}



d <- as.data.frame(lapply(d, centrer_reduire))

d$x <- centrer_reduire(d$x)
d$y <- centrer_reduire(d$y)

