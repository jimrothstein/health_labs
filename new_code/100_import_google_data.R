#	file <- "100_import_google_data.R		"
#
# ------------------------------------------------
####	PURPOSE:
#     "One Time":  Using LEGACY CODE
# 	  Import final Google data (downloaded as .csv) 
# ------------------------------------------------


#### TODO
-   legacy code; appears to work.
-   re-write using  dt


library(tidyverse)
library(data.table)
library(lubridate)
# -------------------------------------
the_dir <- "~/code/health_labs/DATA/"
the_file <- "2021_03_19_raw_data_from_google.csv"
the_path  <- glue::glue(the_dir, the_file)
# -------------------------------------


import_data  <- function(the_path=NULL){
    read.csv(the_path)
}

the_data  <- tibble::as_tibble(import_data(the_path))

##  As stored, Date is character in form d m y
lubridate::dmy(the_data$Date)

z1  <- the_data |> mutate(Date=lubridate::dmy(Date))
head(z1)
the_data  <- z1
head(the_data)
# 'data.frame':	404 obs. of  10 variables:
#  $ Date          : chr  "12Dec2011" "11Jun2012" "18Sep2012" "08Apr2013" ...
#  $ Test_Name     : chr  "VLDL" "VLDL" "VLDL" "VLDL" ...
#  $ Test_Result   : chr  "20" "13" "65" "7" ...
#  $ Code          : chr  "" "" "" "" ...
#  $ Comment       : chr  "now in Berkeley#1" "" "now in LAS" "stone-free??" ...
#  $ Normal        : chr  "" "" "" "" ...
#  $ Where         : chr  "Santa Cruz" "BKK" "Santa Cruz" "BKK" ...
#  $ Purpose       : chr  "" "IVP - all OK" "" "ESWL #2" ...
#  $ Exercise.Level: chr  "intense" "daily" "" "" ...
#  $ Allopurinol   : int  NA NA NA NA NA NA NA NA NA 300 ...
# NULL
# ----------------------------------
#   Check for Duplicates
the_data %>% count(Date, Test_Name, sort=T) |> head()
#         Date Test_Name n
# 1 2018-08-13  Serum_Cr 3
# 2 2019-05-28  Serum_Cr 2
# 3 2020-05-07  Serum_Ca 2
# 4 2009-04-02       BUN 1
# 5 2009-04-02       GLU 1
# 6 2009-04-02       HDL 1

glimpse(the_data)
##  Examine Duplicates
the_data |> dplyr::filter(Date == dmy("13Aug2018") & Test_Name=="Serum_Cr")

the_data |> dplyr::filter(Test_Name=="A1C")
## Broken ....
the_data %>% dplyr::filter(.by=(Date,Test_Name)
the_data  %>% ungroup() %>% dplyr::select(Date = "12Aug2018", Test_Name == "Serum_Cr")


z  <- the_data |> dplyr::select(c(Date, Test_Name, Test_Result)) |> dplyr::filter(Test_Name == "A1C") 
z |> ggplot2::ggplot(aes(Date, Test_Result)) + geom_point()  

----------------------------------------------------------------------------------
- Mon 09Jan2023   DATA is NOT CLEAN
- DUPLICATES
-
the_file  <- read.csv("~/code/health_labs/DATA/legacy/2021_03_19_FINAL_CLEAN.csv")
long  <- data.table(the_file)
# Find duplicates !
long[, .N, by=c("Date", "Test_Name")][N >1]
long[Date=="2018-08-13" & Test_Name=="Serum_Cr"]
long[Date=="2019-05-28" & Test_Name=="Serum_Cr"]
long[Date=="2020-05-07" & Test_Name=="Serum_Ca"]
----------------------------------------------------------------------------------



####	Legacy

#	start
{
	library(tibble)
	library(readr)
legacy_dir  <- "/home/jim/code/health_labs/DATA/legacy"
legacy_file  <- "2021_03_19_FINAL_LABS_from_Google_spreadsheet_FINAL.csv"
the_file  <- normalizePath(paste0(legacy_dir, "/", legacy_file))

#resulq 
clean_file  <- "2021_03_19_FINAL_CLEAN.csv"
clean_file <- paste0(legacy_dir, "/", clean_file)
clean_file
}


read_raw_data  <- function(){
    # cols_only() --  to read specified cols (omitting others)
    # IF lazy,  use col_types=cols( .default=col_guess())
    # cols(),   to read every col
    # type is list obj

    # parse dates 09APR2010
    type <- cols_only(Date = col_date(format="%d%b%Y"),   
                    Test_Name="c",
                    Test_Result="n")  

    result_ALL<-
      read_csv(the_file,
          na = c("NA", "N/A"),  # these entries remain numbers
          col_names = TRUE,  # use 1st line,
          col_types = type
      )   
}


#  clean, returns tibble
clean_raw_data  <- function(t=NULL ){
    t   <- t  %>% 
           dplyr::select(Date,Test_Name, Test_Result) %>% 
           dplyr::arrange(Date)
}

```


```
```{r do_it}
result_ALL  <- read_raw_data()

result_ALL  <- clean_raw_data(result_ALL)

write_csv(result_ALL, clean_file)

head(result_ALL)
```



