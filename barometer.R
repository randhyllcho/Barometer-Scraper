baro <- function() {
  require(rvest)
  require(stringr)
  
  htmlpage <- read_html("http://forecast.weather.gov/MapClick.php?lat=47.73901680288424&lon=-122.34335668736054#.VhHpeRNVhBc")
  barometer <- barometer <- html_nodes(htmlpage, "tr:nth-child(3)")
  pressure <- html_text(barometer)
  result <- paste(pressure, collapse= " ")
  result <- str_extract_all(pressure, regex("[0-9.]+", dotall=FALSE))
  result <- str_split(result[[1]], " ")
  result <- as.numeric(unlist(str_split(result[[1]], " ")))

  result.data <- data.frame(result, Sys.time())
  colnames(result.data) <- c("Pressure", "Date/Time")
  write.table(result.data, file = "/Users/ryanchristensen/R_Projects/barometerReadings.csv", append = TRUE, sep = ",", row.names = FALSE, col.names = FALSE)
}
baro()


repeat {
  startTime <- Sys.time()
  baro()
  sleepTime <- startTime + 60 - Sys.time()
  if (sleepTime > 0)
    Sys.sleep(1799)
}


