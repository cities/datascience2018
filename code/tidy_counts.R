library(tidyverse)
table1
table2
table3
table4a %>% 
  gather(`1999`:`2000`, key="year", value="cases")

table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

source("code/load_data.R")

bikecounts_skiny <- bikecounts %>% 
  gather(westbound:total, key="type", value="counts")

bikecounts %>% 
  gather(westbound, eastbound, total, key="type", value="counts") %>% 
  spread(type, counts)

gather(bikecounts, westbound:total, key="type", value="counts")

# add day-of-week column
bikecounts <- bikecounts %>% 
  mutate(dow=wday(date, label=TRUE))

# summarize bike counts by bridge & day-of-week
bikecounts_dow <- bikecounts %>% 
  group_by(name, dow) %>% 
  summarize(avg_daily_counts=mean(total, na.rm = TRUE))

bikecounts_dow %>% 
  spread(dow, avg_daily_counts)

bikecounts_dow %>% 
  spread(name, avg_daily_counts)
