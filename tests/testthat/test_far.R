test_that("Fars test", {
  a <- fars_read_years(2015)
  expect_that(as.integer(a[[1]][1,2]), equals(2015))
})
