# Fars

This package contains routings designed for processing and visualizing of the data files provided by [US National Highway Traffic Safety Administration's](https://www.nhtsa.gov/) Fatality Analysis Reporting System, which is a US nationwide census providing the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes. The raw data files for years 2013, 2014 and 2015 are included.

![](https://travis-ci.org/flyeye/Fars.svg?branch=master)

Last build [details](https://travis-ci.org/flyeye/Fars) on Travis CI service.

## Installation

You can install Fars from github with:

```R
# install.packages("devtools")
devtools::install_github("Fars/flyeye")
```

## Example

This is a basic example which shows you how to use package:

```R
library(Fars)
fars_summarize_years(c(2013, 2104))
fars_map_state(7, 2014)
```
