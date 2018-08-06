require(rlang)
require(readr)
require(dplyr)
require(tidyr)

trip_rates <- function(dd, var1, var2) {
  var1_quo <- enquo(var1)
  var2_quo <- enquo(var2)
  hh <- dd %>% 
    group_by(HOUSEID) %>% 
    dplyr::summarize(var1=first(!!var1_quo), 
                     var2=first(!!var2_quo), 
                     ntrips=n())
  x <- "var1"
  x2 <- paste0(var1_quo)[2]
  print(x2)
  hh %>% 
    group_by(var1, var2) %>% 
    summarize(avg_trip=mean(ntrips)) %>% 
    spread(key=var2, value=avg_trip) %>% 
    rename(!!x2 := var1)
    #select(var1, `low income`, `med income`, `high income`)
}

dd <- read_csv("data/NHTS2009_dd.csv")
dd <- dd %>% mutate(income_cat=case_when(
  HHFAMINC %in% c("01", "02", "03", "04", "05", "06") ~ "low income",
  HHFAMINC %in% c("07", "08", "09", "10", "11", "12") ~ "med income",
  HHFAMINC %in% c("13", "14", "15", "16", "17", "18") ~ "high income",
  TRUE ~ as.character(NA) # retain missing values as NA
))
trip_rates(dd, HHSIZE, income_cat)
