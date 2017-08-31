
fwf_pos <- fwf_empty("data/NCDC-CDO-USC00356750.txt")
test_df <- read_fwf("data/NCDC-CDO-USC00356750.txt", col_positions = fwf_pos)

test_df <- read_fwf("data/NCDC-CDO-USC00356750.txt", 
                    col_positions = fwf_positions(c(1, 20, 112),
                                                  end=c(19, 69, 120),
                                                  col_names = c("STATION", "NAME", "PRCP")),
                    skip=2)

library(tidyverse)
require(readxl)

(tilikum <- read_excel("data/Tilikum Crossing daily bike counts 2015-16 082117.xlsx", skip=1))
hawthorne <- read_excel("data/Hawthorne Bridge daily bike counts 2012-2016 082117.xlsx")

tilikum$bridge <- "Tilikum"
hawthorne$bridge <- "Hawthorne"

names(hawthorne) <- c("date", "westbound", "eastbound", "total", "bridge")

bikecounts <- bind_rows(tilikum, hawthorne)

bikecounts <- bikecounts %>% 
  gather(westbound, eastbound, key="direction", value="counts")

bikecounts %>% 
  gather(westbound, eastbound, key="direction", value="counts") -> bikecounts

bikecounts %>% 
  mutate(week=week(date),
         month=month(date),
         year=year(date))

nhts <- read_csv("data/NHTS2009_dd.csv")
