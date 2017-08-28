require(tidyverse)

#table1-5 are loaded with tidyverse

table6 <- tribble(
  ~traveler,               ~modes,  ~time,
  1,    "walk, transit, walk",  "5,25,3",
  2,                   "auto",        15,
  3,          "bike, transit",    "6,15"
)

#separate_rows(table6, modes, time, convert = TRUE)
