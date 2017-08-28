require(tidyverse)

table1 <- tribble(
  ~country,       ~year,   ~case, ~population,
  "Afghanistan",  1999L,    745L,   19987071L,
  "Afghanistan",  2000L,   2666L,   20595360L,
  "Brazil",       1999L,  37737L,  172006362L,
  "Brazil",       2000L,  80488L,  174504898L,
  "China",        1999L, 212258L, 1272915272L,
  "China",        2000L, 213766L, 1280428583L
)

table2 <- tribble(
  ~country,       ~year,        ~type,     ~count,
  "Afghanistan",  1999L,      "cases",        745L,
  "Afghanistan",  1999L, "population",   19987071L,
  "Afghanistan",  2000L,      "cases",       2666L,
  "Afghanistan",  2000L, "population",   20595360L,
  "Brazil",       1999L,      "cases",      37737L,
  "Brazil",       1999L, "population",  172006362L,
  "Brazil",       2000L,      "cases",      80488L,
  "Brazil",       2000L, "population",  174504898L,
  "China",        1999L,      "cases",     212258L,
  "China",        1999L, "population", 1272915272L,
  "China",        2000L,      "cases",     213766L,
  "China",        2000L, "population", 1280428583L
)

table3 <- tribble(
  ~country,     ~year,               ~rate,
  "Afghanistan", 1999L,      "745/19987071",
  "Afghanistan", 2000L,     "2666/20595360",
  "Brazil",      1999L,   "37737/172006362",
  "Brazil",      2000L,   "80488/174504898",
  "China",       1999L, "212258/1272915272",
  "China",       2000L, "213766/1280428583"
)

## cases
table4a <- tribble(
  ~country,      ~`1999`, ~`2000`,
  "Afghanistan",    745L,   2666L,
  "Brazil",       37737L,  80488L,
  "China",       212258L, 213766L
)

## population
table4b <- tribble(
  ~country,            ~`1999`,   ~`2000`,
  "Afghanistan",     19987071L,   20595360L,
  "Brazil",         172006362L,  174504898L,
  "China",         1272915272L, 1280428583L
  )

table5 <- table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)
