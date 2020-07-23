#   3001_simple_lab_plot.R

rm(list=ls())
library(lubridate)
library(tidyverse)
##########

#	DATA


x=c("29 JAN 2018", "13 JUN 2018", "19 MAR 2019")
y <- c(0.60,0.37,0.51)
class(x)


# 	DATE_TIME   aka POSIXct


# 	repeat, but make a date (not date-time)
x2<-dmy(x)

(x2)
 class (x2)
#	TIBBLE
# y magically converted to tibble <dttm>   aka as POSIXct
t  <- tibble(x2,y)
(t)

#	PLOT
ggplot(t, aes(x2,y)) + geom_point()
# plot(x,y)

# plot(y~as.Date(x, format="%d/%m/%y"), type="l", origin=as.Date("01/01/2014")
			   )
)
	 ,

#	OTHER EXAMPLES	 	

(parse_date_time(c("19 MAR 2019"),"dbY"))	
(parse_date_time(c("19-03-18"),"ymd"))	
(parse_date_time("18-03-2019","dmY"))


