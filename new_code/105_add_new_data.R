# file <- as "105_add_new_data.R#"
#

####	lab_data:  Manually Add new lab data SINCE last google entry.
library(data.table)

#	add like tribble (this is fake)
dt_add  <- data.table::fread("Date, Lab_Test, Lab_Result
9/02/22, UrOx, 100
9/02/22, UrOx, 90
9/03/22, UrOx, 50
")
dt_add


dt_add[, .(Date=as.Date(Date), Lab_Test, Lab_Result)]

#	To cut and paste
dput(dt_add)


##-------------------------------------
##
##		BELOW:		Testing with lookup table
##
##-------------------------------------

## practice with legacy; TODO:  run lookup against newly entered data
{
	library(data.table)
#	
	the_dir="/home/jim/code/health_labs/DATA/legacy/"
	IN_FILE  <- file(paste0(the_dir, "2021_03_19_FINAL_CLEAN.csv"))
	dt  <- as.data.table(read.csv(IN_FILE))
	dt
}


####	Construct Lookup table, dt_lab and dt_lab_add (for additions)
{
dt_lookup  <- data.table(Test_Name=c("VLDL", "Ur_Ox"),
											Test_Range=c("", ""),
											Test_Comment=c("**need to addd**", "25-200")
	)
str(dt_lookup)
dt_lookup
dput(dt_lookup)
}

{
#	all rows of dt_lookup
dt[dt_lookup, on = .(Test_Name) ]
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
