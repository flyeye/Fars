% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_map_state}
\alias{fars_map_state}
\title{fars_map_state draw a map of state with accidents}
\usage{
fars_map_state(state.num, year)
}
\arguments{
\item{state.num}{-  USA state code}

\item{year}{- interested year of accidents}
}
\value{
graphical map
}
\description{
Function fars_map_state() draw a map of state with accidents on it by the given state and year. Accidents are represented as points.
}
\note{
function return error message in case of no data for the state or year specified.
}
\examples{
fars_map_state(state.num = 1, year = 2014)


}
