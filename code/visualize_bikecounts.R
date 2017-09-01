library(tidyverse)
library(lubridate)
require(readxl)

(tilikum <- read_excel("data/Tilikum Crossing daily bike counts 2015-16 082117.xlsx", skip=1))
hawthorne <- read_excel("data/Hawthorne Bridge daily bike counts 2012-2016 082117.xlsx")

tilikum$bridge <- "Tilikum"
hawthorne$bridge <- "Hawthorne"

names(hawthorne) <- c("date", "westbound", "eastbound", "total", "bridge")

bikecounts <- bind_rows(tilikum, hawthorne) %>% 
  mutate(date=as_date(date))

#bikecounts <- bikecounts %>% 
#  gather(westbound, eastbound, key="direction", value="counts")

#bikecounts %>% 
#  gather(westbound, eastbound, key="direction", value="counts") -> bikecounts

weather_raw <- read_csv("data/NCDC-CDO-PortlandOR.csv")
weather_df <- weather_raw %>% 
  filter(STATION=="USC00356750") %>% 
  transmute(date=DATE, PRCP, TMIN=as.numeric(TMIN), TAVG=as.numeric(TAVG), TMAX=as.numeric(TMAX), SNOW)

bikecounts <- left_join(bikecounts, weather_df, by="date")

bikecounts <- bikecounts %>% 
  mutate(week=date - wday(date) + 1,
         month=date - mday(date) + 1,
         year=date - yday(date) + 1)

#filter any days w/ missing values as they throw off the plot
bikecounts <- bikecounts %>%
  filter(complete.cases(eastbound, westbound, total))

## generate summaries for plotting
bikecounts_week <- bikecounts %>% 
  group_by(bridge, week) %>% 
  summarize(total=sum(total))

bikecounts_month <- bikecounts %>% 
  group_by(bridge, month) %>% 
  summarize(total=sum(total))

bikecounts_year <- bikecounts %>% 
  group_by(bridge, year) %>% 
  summarize(total=sum(total))

ggplot(bikecounts) +
  geom_line(aes(x=date, y=total, color=bridge)) +
  scale_y_log10()

ggplot(bikecounts_week) +
  geom_line(aes(x=week, y=total, color=bridge)) +
  scale_y_log10()

ggplot(bikecounts_month) +
  geom_line(aes(x=month, y=total, color=bridge)) +
  scale_y_log10()

ggplot(bikecounts_year) +
  geom_line(aes(x=year, y=total, color=bridge)) +
  scale_y_log10()

ggplot(bikecounts) +
  geom_line(aes(x=date, y=PRCP)) +
  labs(y="Daily Percipitation")

ggplot(bikecounts) +
  geom_line(aes(x=date, y=TMAX)) +
  labs(y="Daily Max Temperature")

# Example of decompose timeseries day
#install.packages("ggfortify")

library(ggfortify)
prcp_ts <- ts(weather_df$PRCP, start=2011, frequency = 365)
autoplot(stl(prcp_ts, s.window = 'periodic'), ts.colour = 'blue')

tmax_ts <- ts(weather_df$TMAX, start=2011, frequency = 365)
autoplot(stl(tmax_ts, s.window = 'periodic'), ts.colour = 'blue')
