foo <- function(x){ 
  if(x > 0) 
    claim <- paste(x, "is larger than 0") 
  else
    claim <- paste(x, "is less than 0")
  claim
}