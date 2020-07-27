#003_post_2017_download_norm_saveresults.R

library(tidyverse)
library(here)

###########
#	INPUT:	- Step 1, download .csv from Google.
#         - put .csv  ./data_raw
#         - ALL years, all lab data 
#					- OK to overwrite data in ./data_raw, with newer.
#
#	OUTPUT:	
#
###########

###########
#	read ALL on ...		
# 	raw data from local into tibble
###########

read_raw_data  <- function(){
# cols_only() --  to read specified cols (omitting others)
    # IF lazy,  use col_types=cols( .default=col_guess())
    # cols(),   to read every col
    # type is list obj

# parse 09APR2010
type <- cols_only(Date = col_date(format="%d%b%Y"),   
						      Test_Name="c",
						      Test_Result="n")  
# READ
# input_data  <- "ALL_lab_data.csv"
input_data  <- "2020_07_26_ALL_lab_data.csv"

result_ALL<-read_csv( file= paste0("data_raw/",input_data),
        na = c("NA", "N/A"),  # these entries remain numbers
        col_names = TRUE,  # use 1st line,
        col_types = type
    )   
}

clean_raw_data  <- function(t=NULL ){
# CLEAN
t   <- t  %>% 
  dplyr::select(Date,Test_Name, Test_Result) %>% 
    dplyr::arrange(Date)
}

write_raw_clean_data  <- function(t=NULL){
# WRITE
output_data  <- "ALL_lab_data.csv"
write_csv(t, paste0("./data_norm/", output_data ))
}

result_ALL  <- read_raw_data()
result_ALL  <- clean_raw_data(result_ALL)
write_raw_clean_data(result_ALL)
head(result_ALL)
