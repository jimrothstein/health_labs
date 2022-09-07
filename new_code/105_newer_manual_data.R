# file <- as "105_newer_manual_data.R#"
#
-	Here we manually enter all newer LAB data, save it.
-	See 110_ for data checking and merge ALL data (new+old) into 1 data.table.
-	Step between legacy  and merging new/old.



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


dt_add  <- data.table::fread("Date, Lab_Test, Lab_Result
9/02/22, UrOx, 100
9/02/22, UrOx, 90
9/03/22, UrOx, 50
")
dt_add


dt_add[, .(Date=as.Date(Date), Lab_Test, Lab_Result)]

}
