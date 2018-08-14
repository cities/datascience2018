library(tidyverse)
library(lubridate)
require(readxl)

# load bike counts & weather data
source("code/load_data.R")

bikecounts <- bikecounts %>% 
  mutate(DATE=as_date(date))

bikecounts <- left_join(bikecounts, weather_df, by="DATE")

bikecounts

bikecounts <- bikecounts %>% 
  mutate(week=week(date, label=TRUE),
         month=month(date, label=TRUE),
         year=year(date))

bikecounts %>% 
  group_by(name, month) %>% 
  summarize(monthly_total=sum(total)) %>% 
  ggplot() +
  geom_line(aes(x=month, y=monthly_total, group=name, color=name))

ggplot(bikecounts) +
  geom_col(aes(x=date, y=total, color=name))

ggplot(bikecounts) +
  geom_boxplot(aes(x=month, y=total))

bikecounts %>% 
    group_by(name, week) %>% 
    summarize(weekly_total=sum(total)) %>% 
    ggplot() +
    geom_line(aes(x=week, y=weekly_total, color=name))

bikecounts_weather <- bikecounts %>% 
  mutate(DATE=as_date(date)) %>% 
  left_join(weather)

bikecounts_weather%>% 
  ggplot() +
  geom_col(aes(x=DATE, y=total)) +
  geom_line(aes(x=DATE, y=TMIN * 100)) +
  scale_y_continuous(sec.axis = sec_axis(~./100, name="Temp (F)")) +
  facet_wrap(~name)

ggplot() +
  geom_col(data=bikecounts, aes(x=as_date(date), y=total)) +
  geom_line(data=weather, aes(x=DATE, y=TMIN))

bikecounts_weather %>% 
  ggplot() +
  geom_smooth(aes(x=TMIN, y=total, group=name)) +
  geom_smooth(aes(x=TMAX, y=total, group=name)) +
  facet_wrap(~name)

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
hawthorne_bc <- bikecounts %>% filter(name=="Hawthorne") %>% pull(total)
hawthorne_ts <- ts(hawthorne_bc, start=2012, frequency = 365)
autoplot(stl(hawthorne_ts, s.window = 'periodic'), ts.colour = 'blue')

tmax_ts <- ts(weather$TMAX, start=2011, frequency = 365)
autoplot(stl(tmax_ts, s.window = 'periodic'), ts.colour = 'blue')



## hypothetically, what if our data is un-tidy
bikecounts_wide <- bikecounts %>%
  select(date, name, total) %>% 
  mutate(date=as_date(date)) %>% 
  spread(name, total)

ggplot(bikecounts_wide) +
  geom_line(aes(x=date, y=Hawthorne, color="red")) +
  geom_line(aes(x=date, y=Steel, color="blue"))+
  geom_line(aes(x=date, y=Tilikum, color="green"))

ggplot(bikecounts) +
  geom_line(aes(x=date, y=total, color=name))

## directlabels
install.packages("directlabels")
library(directlabels)

bikecounts %>% 
  mutate(name=factor(name, 
                     levels=c("Hawthorne", "Steel", "Tilikum"))) %>% 
  ggplot(aes(x=date, y=total, color=name)) +
  geom_line() +
  geom_dl(aes(label = name), method="smart.grid")


weather %>% 
  gather(TMIN, TMAX, key="measure", value="temp") %>% 
  ggplot(aes(x=DATE, y=temp, color=measure)) +
  geom_smooth() + scale_colour_discrete(guide = 'none') +
  geom_dl(aes(label = measure), method="last.qp")

bikecounts %>% 
  mutate(name=factor(name, 
                     levels=c("Hawthorne", "Steel", "Tilikum"))) %>% 
  ggplot(aes(x=date, y=total, color=name)) +
  geom_line() +
  geom_dl(aes(label = name), method="smart.grid")

