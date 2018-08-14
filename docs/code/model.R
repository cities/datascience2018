library(tidyverse)
library(lubridate)
require(readxl)

# load bike counts & weather data
source("code/load_data.R")

bikecount_weather <- bikecounts %>% 
  mutate(DATE=as_date(date)) %>% 
  left_join(weather)

lm(total ~ TMIN + TMAX + PRCP, bikecount_weather) %>% summary()

bw_lcdf <- bikecount_weather %>% 
  group_by(name) %>% 
  nest()

library(purrr)
library(broom)
model_df <- bw_lcdf %>% 
  mutate(fit=map(data, ~lm(total ~ TMIN + TMAX + PRCP, data=.)),
         tidy=map(fit, tidy),
         glance=map(fit, glance)
         )

model_df %>% 
  unnest(tidy) %>% 
  filter(term=="PRCP") %>% 
  arrange(estimate) %>% 
  slice(1)

model_df %>% 
  unnest(glance) %>% 
  arrange(desc(r.squared))
