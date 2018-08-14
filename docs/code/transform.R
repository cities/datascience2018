source("code/load_data.R")

bikecounts

bikecounts %>% 
  filter(is.na(westbound) | is.na(eastbound)) %>% 
  group_by(date) %>% 
  tally

bikecounts %>% 
  mutate(year=year(date)) %>% 
  group_by(name, year) %>% 
  summarize(annual_total = sum(total))

bikecounts

weather <- read_csv("data/NCDC-CDO-USC00356750.csv")

bikecounts %>% 
  mutate(DATE=as_date(date)) %>% 
  anti_join(weather)



my_gap <- gapminder %>% 
  group_by(country) %>% 
  mutate(life_exp_gain = lifeExp - first(lifeExp)) %>% 
  top_n(3)

library(magrittr)
my_gap %<>% 
  mutate(gdp=pop*gdpPercap)


left_join(flights2, airlines, by=c("code"="faa", "name"))

(df1 <- data_frame(x = c(1, 2), y = 2:1))
#> # A tibble: 2 x 2
#>       x     y
#>   <dbl> <int>
#> 1     1     2
#> 2     2     1
(df2 <- data_frame(x = c(1, 3), a = 10, b = "a"))
#> # A tibble: 2 x 3
#>       x     a b    
#>   <dbl> <dbl> <chr>
#> 1     1    10 a    
#> 2     3    10 a


dd %>% 
  mutate(driving=ifelse(CONDITION, 1, 0),
         driving=ifelse(TRPTRANS %in% c("-1", "-7", "-8", "-9"), NA, driving))

bikecounts %>% 
  group_by(name) %>% 
  top_n(3, total)

bikecounts %>% 
  group_by(name) %>% 
  arrange(desc(total), .by_group=TRUE) %>% 
  slice(1:3)

bikecounts %>% 
  mutate(week=floor_date(date, "week")) %>% 
  group_by(name, week) %>%
  summarize(weekly_total=sum(total))

bikecounts %>% 
  group_by(name) %>% 
  mutate(rank=rank(desc(total))) %>% 
  filter(rank <=3) %>% 
  arrange(name, rank)

bikecounts %>% 
  #arrange(name, desc(total)) %>% 
  group_by(name) %>% 
  top_n(3)

bikecounts %>% 
  group_by(name) %>% 
  top_n(-3, total)


nhts <- read_csv("https://raw.githubusercontent.com/cities/datascience2018/master/data/NHTS2009_dd.csv")

nhts %>% 
  group_by(HOUSEID) %>% 
  summarise(total_miles=sum(TRPMILES))

nhts %>% mutate(driving=case_when(
  TRPTRANS %in% c("01", "02", "03", "04", "05", "06", "07") ~ 1, 
  TRPTRANS %in% c("-1", "-7", "-8", "-9") ~ as.double(NA), # retain missing values as NA
  TRUE ~ 0)) %>% 
  filter(driving==1) %>% 
  group_by(HOUSEID) %>% 
  summarize(total_vmt=sum(TRPMILES))














