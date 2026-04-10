##file <- "200_simple_database.R"
library(data.table)

##  assume this is complete, up-to-date data 
##  long (normalized) format
  the_file  <- read.csv("~/code/health_labs/DATA/legacy/2021_03_19_FINAL_CLEAN.csv")
  

long  <- data.table(the_file)
long
str(long)

setkeyv(long, 
  cols=c("Date", "Test_Name"))

#   ------------------------------------------------
# Find duplicates !
#   These entries MUST be corrected, or removed.
# 
#   ------------------------------------------------
long[, .N, by=c("Date", "Test_Name")][N >1]
long[Date=="2018-08-13" & Test_Name=="Serum_Cr"] # 3 the same
long[Date=="2019-05-28" & Test_Name=="Serum_Cr"] # 1.30 vs 1.35 ??
long[Date=="2020-05-07" & Test_Name=="Serum_Ca"] # 2 different values

# find
duplicated(long, by=1:2)
long[duplicated(long, by=1:2)]


# remove
long  <- unique(long, by=1:2)
long

# check
duplicated(long, by=1:2)


##  dcast to wide
##

# Date , Test_Name should be unique
wide = dcast(long, Date ~ Test_Name, value.var = "Test_Result")
head(wide)



unique(long$Test_Name)
