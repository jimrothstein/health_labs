# 007_urOx_simple_tibble.R
##	SIMPLE
	
require(tidyverse)
	require(lubridate)

data=tibble(
	x=ymd(c(20140124,20140125,
			#20140225,
			20140525,20140728,20141112,
			20150506,
			20160214,20160913,
			20170206,20170929,
			20180813,20181120)),
	
	y=c(162,160,
		#668,
		55,65,86,
		133,
		51,112,
		46,48,
		194,77)
)
f <- function(df){
	df=df
	}
f(data)
print(data)
plot(data)
base_plot<-function(df,x,y){
	g <- ggplot(df, aes(x=x,y=y)) + geom_point() + geom_hline(yintercept = 35, color="red")
}
g<-base_plot(data,x,y)
g
##
g <- ggplot(z, aes(x=Date,y=Test_Result)) +
	geom_point() +
    scale_x_date(date_labels = "%Y") +
    geom_hline(yintercept = 100, color="red") +
    labs (title = "Fasting Glucose",
          subtitle = "2008 - 2018") +
	geom_vline(data = tibble(    # adding layer!, own data
		x= ymd(c("2012-01-01","2016-05-01"))
		),
		mapping = aes(xintercept = as.numeric(x)),
		color = "blue",
		linetype= 2)   # dotted
            
g
summary(g)