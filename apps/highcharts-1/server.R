df = structure(list(Date = structure(c(16075, 16082, 16082, 16089, 16096, 16096, 16103, 16110, 16110), class = "Date"), Type = c("Type-1", "Type-1", "Type-2", "Type-1", "Type-1", "Type-2", "Type-1", "Type-1", "Type-2"), Numbers = c(16, 82, 2, 177, 270, 3, 381, 461, 4)), .Names = c("Date", "Type", "Numbers"), row.names = c(NA, -9L), class = "data.frame")

# don't switch to scientific notation, since we want date to be
# represented in milliseconds
options(scipen = 13)
dat = transform(df, Date2 = as.numeric(as.POSIXct(Date))*1000)

h1 <- hPlot(Numbers ~ Date2, data = dat, 
            group = 'Type', 
            type = "line", 
            radius=6
)
h1$xAxis(type = 'datetime', labels = list(
  format = '{value:%Y-%m-%d}'  
))
h1