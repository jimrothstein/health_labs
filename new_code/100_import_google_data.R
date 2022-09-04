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

#	file <- "100_import_google_data.R		"
#
####	PURPOSE:
"One Time":  Using LEGACY CODE
-	Import final Google data (downloaded as .csv) 
-	Clean 
-	Save as R object.


#### TODO
-	legacy code; appears to work.
- re-write using  dt

####	Legacy

#	start
{
	library(tibble)
	library(readr)
legacy_dir  <- "/home/jim/code/health_labs/DATA/legacy"
legacy_file  <- "2021_03_19_FINAL_LABS_from_Google_spreadsheet_FINAL.csv"
the_file  <- normalizePath(paste0(legacy_dir, "/", legacy_file))

#result
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



