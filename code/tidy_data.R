require(tidyverse)

#table1-5 are loaded with tidyverse

table6 <- tribble(
  ~traveler,               ~modes,  ~time,
  1,    "walk, transit, walk",  "5,25,3",
  2,                   "auto",        15,
  3,          "bike, transit",    "6,15"
)

separate_rows(table6, modes, time, convert = TRUE)

table4 <- table4a %>% 
  left_join(table4b, by="country", 
            suffix=c("_cases", "_population"))

gather(table4, 
       `1999_cases`:`2000_population`, 
       key='year_type', value="counts") %>% 
  separate(year_type, into=c("year", "type")) %>% 
  spread(key=type, value=counts)


