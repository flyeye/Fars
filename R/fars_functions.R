#'
#' fars_read() - read accidents statistics by the given file name
#'
#' open file with accidents statistics by the given file name and read it into dplyr::tbl_df variable.
#' @export
#' @param filename - character string with file name
#'
#' @return data frame as dplyr::tbl_df object. If file does not exist print error message.
#'
#' @examples
#' \dontrun{
#' data <- fars_read("accident_2016.csv.bz2")
#' }
#'
#'
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' make_filename() function returns make a filename by the given year
#'
#' Make a file name as a character string by the given year
#'
#' @param year - year of accidents
#'
#' @return filename - file name as a character string
#'
#' @examples
#' \dontrun{
#' make_filename(2016)
#' }
#'
#' @export
make_filename <- function(year) {
        year <- as.integer(year)
        system.file("extdata", sprintf("accident_%d.csv.bz2", year), package = "Fars")
}


#' fars_read_years read accidents data by given years
#'
#' Read accidents data by given years and return data frame with short info for each accident.
#'
#' @param years - vector of years.
#'
#' @return data frame of class dplyr::tbl_df with two columns (month ans year) per each accident. If data for any of given years do not exist
#' function stops working and return an error message.
#'
#' @examples
#' \dontrun{
#' fars_read_years(c(2013, 2014, 2015))
#' }
#'
#' @export
fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        mutate(dat, year = year) %>%
                                select_("MONTH", "year")
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' fars_summarize_years - summarize statistical data about accidents
#'
#' Function takes given vector of years and summarize statistical data about accidents
#'
#' @param years - vector of years
#'
#' @return data frame with summary about accidents in the given years: quantity of accidents per month for each year. If data for any of given years do not exist
#' function stops working and return an error message.
#'
#' @examples
#' \dontrun{
#' fars_summarize_years(c(2013, 2014, 2015))
#' }
#'
#' @export
fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        bind_rows(dat_list) %>%
                group_by_("year", "MONTH") %>%
                summarize(n = n()) %>%
                spread("year", n)
}

#' fars_map_state draw a map of state with accidents
#'
#' Function fars_map_state() draw a map of state with accidents on it by the given state and year. Accidents are represented as points.
#' @export
#' @param year - interested year of accidents
#' @param state.num  -  USA state code
#'
#'
#' @return
#' graphical map
#'
#' @examples
#' \dontrun{
#' fars_map_state(state.num = 1, year = 2014)
#' }
#'
#' @note function return error message in case of no data for the state or year specified.
#'
#'

fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        #data.sub <- filter(data, "STATE == state.num")
        data.sub <- filter_(data, .dots= paste0("STATE", "== ", state.num))
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                points(LONGITUD, LATITUDE, pch = 46)
        })
}
