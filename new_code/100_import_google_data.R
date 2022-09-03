---
title: Template for .Rmd
output: 
  pdf_document:
    latex_engine: xelatex
    toc:  TRUE
    toc_depth:  1
fontsize: 12pt
geometry: margin=0.5in,top=0.25in
#  md_document:
#  html_document:
#    toc: true
#  	toc_float: true
#    css: styles.css
---

####	PURPOSE:
-	Import final Google data, save as R object.
-	Collect and append additional lab tests to that R object


#### Details
-	In theory, Google should never be needed again.
-	Final Google data should be in this folder
-	<Date>_google_data_FINAL.csv
-	This .csv file should remain here, forever.

####	Google spreadsheet file, last edit 19MAR2021.
-	https://docs.google.com/spreadsheets/d/16PRB17uBRtferrNyVSPKHCyelTNW4I6m2bMaTcsgo7s/edit#gid=1272825971&fvid=2066494078
-	TREAT as part of this R package.	
-	Last editd 19MARCH2021 in Google was.

#	file <- "100_import_google_data.R		"
#
TODO  
-	verify dt data
-	verify columns correct data type.
-	merge 2 dt:  dt_lab and additions dt_lab_add (same_structures)



###	BEGIN
###	ASSUME:  google .csv data is downloaded and in same directory.
####	Read data, put into dt
-	compare fread?
{
library(data.table)

IN_FILE  <- file("2021_03_19_FINAL_LABS_from_Google_spreadsheet_FINAL.csv")
dt  <- as.data.table(read.csv(IN_FILE))
dt

str(dt)
}


####	Construct Lookup table, dt_lab and dt_lab_add (for additions)
{
dt_lookup  <- data.table(Test_Name=c("VLDL"),
											Test_Range=c(""),
											Test_Comment=c("**need to addd**")
	)
str(dt_lookup)
dt_lookup
dput(dt_lookup)
# structure(list(Test_Name = "VLDL", Test_Range = "", Test_Comment = ""), row.names = c(NA, 
# -1L), class = c("data.table", "data.frame"), .internal.selfref = <pointer: 0x563d4a456120>)
#    Test_Name Test_Range Test_Comment
# 1:      VLDL                        
dt_lookup_add  <- data.table::fread("Test_Name,Test_Range,Test_Comment
																 fake test, 0-100, this is all fake
																 fake_test2, 101-200, not fake
																 ")
dt_lookup
}



####	Warmup:  List rows of dt match Test_Name
{
	dt[Test_Name == "VLDL"]
	dt[Test_Name != "VLDL"]


	#	Join, dt_lab is lookup, match on columns for Test_Name; return columns
	#	shown by .(r1, r2, .... s1, s2 ..):w
	#
	dt[dt_lookup			, on = .(Test_Name=Test_Name), .(Date, Test_Name, Test_Result,   Test_Range, Test_Comment)]


}


####	lab_data:  Manually Add lab data SINCE last google entry.
-	review data.table::fread 
-	Add data (like tibble)
{
dt_add  <- data.table::fread("A,B
1,20
3,60
")
dt_add

dt_add  <- data.table::fread("A,B
1,'a'
3,'b'
")

dt_add

dput(dt_add)
}




```{r read_raw}
read_raw_data  <- function(){
    # cols_only() --  to read specified cols (omitting others)
    # IF lazy,  use col_types=cols( .default=col_guess())
    # cols(),   to read every col
    # type is list obj

    # parse dates 09APR2010
    type <- cols_only(Date = col_date(format="%d%b%Y"),   
                    Test_Name="c",
                    Test_Result="n")  
    # file 
    input_data  <- "latest.csv"

    result_ALL<-
      read_csv(here(IN,input_data),
          na = c("NA", "N/A"),  # these entries remain numbers
          col_names = TRUE,  # use 1st line,
          col_types = type
      )   
}
```
2.  function:  clean_raw_data()

```{r clean_data}

#  clean
clean_raw_data  <- function(t=NULL ){
    t   <- t  %>% 
           dplyr::select(Date,Test_Name, Test_Result) %>% 
           dplyr::arrange(Date)
}

```
3.  function: write_data_clean()
   *  data_clean/

```{r write_data_clean}
write_raw_clean_data  <- function(t=NULL){
  output_data  <- "ALL_lab_data.csv"
  write_csv(t, here("data_clean", output_data ))
}

```
```{r do_it}
result_ALL  <- read_raw_data()

result_ALL  <- clean_raw_data(result_ALL)

write_raw_clean_data(result_ALL)

head(result_ALL)

```



```{r knit_exit()}
knitr::knit_exit()
```

***
