## ------------------------------------------------------------------------
 year <- as.integer(2014)
 system.file("extdata", sprintf("accident_%d.csv.bz2", year), package = "Fars")


## ----results='asis', echo=FALSE, include=FALSE---------------------------
knitr::opts_chunk$set(echo = TRUE, warning=FALSE)
library(Fars)

## ------------------------------------------------------------------------
  name <- system.file("extdata", sprintf("accident_%d.csv.bz2", 2014), package = "Fars")
  data <- fars_read(name)
  data[1:3, 1:10]

## ------------------------------------------------------------------------
make_filename(2014)

## ------------------------------------------------------------------------
 data <- fars_read_years(c(2013, 2014, 2015))
 data[[1]]

## ------------------------------------------------------------------------
  fars_summarize_years(c(2013, 2014, 2015))

## ------------------------------------------------------------------------
fars_map_state(state.num = 1, year = 2014)

