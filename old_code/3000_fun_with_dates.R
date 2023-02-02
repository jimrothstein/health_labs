#   3000_fun_dates.R

rm(list=ls())
library(lubridate)
library(tidyverse)
##########

#	DATA
x=c("19 MAR 2019","18 MAR 2019")
y=c(195,194)
class(x)


#	--------------------
#	Do not use DATE TIME
#	--------------------
# 	DATE_TIME   aka POSIXct

#	use lubridate, not as.POSIXct
#	use parse _date_time when dmy() does not find format
#x=parse_date_time(x,"dbY")
#(x)
#class (x)


#	--------------------
#	Do use DATE, via Lubridate
#	--------------------
x2<-dmy(x)
(x2)
 class (x2)

#	TIBBLE
# y magically converted to tibble <dttm>   aka as POSIXct
t  <- tibble(x2,y)
(t)

#	PLOT
ggplot(t, aes(x2,y)) + geom_point()
	 ,

#	OTHER EXAMPLES	 	

(parse_date_time(c("19 MAR 2019"),"dbY"))	
(parse_date_time(c("19-03-18"),"ymd"))	
(parse_date_time("18-03-2019","dmY"))


