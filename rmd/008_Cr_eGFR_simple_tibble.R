# 008_urOx_simple_tibble.R
##	SIMPLE

##	Steps
##	-	retrieve normalized data, all years
##	-	filter data wanted

require(tidyverse)
require(lubridate)


result <-read_csv("./data_norm/ALL_lab_data.csv")
print(result)

###
#	function to list all Test_Names
###
list_test_names <- function(x=result)
	result %>%  select(Test_Name) %>% distinct() %>% arrange(Test_Name)


test_names <- list_test_names()
print(test_names, n=50)
###
#	function to get_data_for_specific_test
###
get_data_for_specific_test<- function(x=result,test="GLU") 
	result %>% filter(Test_Name== test)

## Choose ONE specific test
the_test <- "PTH"
z <- get_data_for_specific_test(result,the_test)
z<-z[-2,] # Ur_Ox24 ONLY, drop 2nd row 668

print(z)
summary(z)

#################################
# Simple:   Fasting GLU over time
#################################

####
#	function:   plot_data, glucose, eGFR	
####
plot_data <- function (z=z,title="Fasting Glucose"){
	
	g <- ggplot(z, aes(x=Date,y=Test_Result)) +
		geom_point() +
		scale_x_date(date_labels = "%Y") +
		# for red line, uncomment
    	#geom_hline(yintercept = 100, color="red") +
    	labs (title = title,
          	subtitle = "2008 - 2019") +
		geom_vline(data = 
			tibble(    # adding layer!, own data
				x= ymd(c("2012-01-01","2016-12-31"))),
				mapping = aes(xintercept = as.numeric(x)),
				color = "blue",
				linetype= 2
			)   # dotted
}            
g = plot_data(z,title=the_test) 
g
######
#  Ur_Ox24	
######
plot_data_Ur_Ox24 <- function (z=z,title="Urine_Oxalate 24Hours"){
	g <- ggplot(z, aes(x=Date,y=Test_Result)) +
			geom_point() +
			scale_x_date(date_labels = "%Y") +
    		geom_hline(yintercept = 35, color="red") +
    		labs (title = title,
          		subtitle = "2008 - 2019") +
			geom_vline(data = 
				tibble(    # adding layer!, own data
					x= ymd(c("2012-01-01","2016-12-31"))
				),
				mapping = aes(xintercept = as.numeric(x)),
				color = "blue",
				linetype= 2
			)   	# dotted
}            
g = plot_data_Ur_Ox24(z,title="Ur_Ca24")
g
#####

## save, retrieve, use object - without recalculating
saveRDS(g,file=here("data_intermediate/eGFR.rds"))
g <- readRDS(here("data_intermediate/eGFR.rds"))
g
######
# STOP
######
summary(g)
##
