# file <- as "105_add_new_data.R#"
#

####	lab_data:  Manually Add new lab data SINCE last google entry.
library(data.table)


#	add like tribble (this is fake)
dt_add  <- data.table::fread("Date, Lab_Test, Lab_Result, Lab 
9/01/22, Tot_Cholesterol, 131,
9/01/22, Trig, 73,
9/01/22, HDL, 52, 
9/01/22, LDL, 64, 
9/01/22, Serum_Uric, 6.0, Kaiser,
9/01/22, Ur_Ca24, 217,  
9/01/22, Ur_Citrate24, 749, 
9/01/22, Ur_Vol24, 6.2, 
9/01/22, Ur_pH, 7.7,  
9/01/22, UrOx, 55,  
9/01/22, Ur_Uric24, 0.422,  
9/01/22, Serum_Ca, 9.4, 
9/01/22, Serum_P, 3.8,  
9/01/22, Serum_Cl, 99,  
9/01/22, Serum_Cr, 1.22,   
9/01/22, Serum_Uric, 6.1, Litholink,  
9/01/22, eGFR, 65,   
5/12/22, Ur_Pr/Cr, 0.91,  
5/12/22, TSH, 1.35, 
5/12/22, PTH, 99, 
5/12/22,  A1C, 5.5, 
5/12/22,  GLU, 102, 
5/12/22,  Serum_Cr, 1.12, Kaiser,
5/12/22,  BUN, 26, Kaiser,
5/12/22,  eGFR, 72, Kaiser, 
5/12/22,  UrOx, 45, Litholink , 
1/19/23, UrOx, 66, Litholink, 
10/21/21, UrOx, 85, Litholink,
", sep=",", fill=T )

dt_add

# Date is read in as "character"
dt_add[, .(Date = sort(as.Date(Date, format="%m/%d/%y")), Lab_Test=format(Lab_Test, justify="left"), Lab_Result, Lab )]

# -------------------------------------  TODO:  format Lab_Test, left align-----------------------------
format_col.complex = function(x, ...) sprintf('(%.1f, %.1fi)', Re(x), Im(x))

format_col = function(x, ...) sprintf('(%.s)', x)
format_col(dt_add$Lab_Test)
# ----------------------------------------------------------------------------

#	To cut and paste
dput(dt_add)


##-------------------------------------
##
##		BELOW:		Testing with lookup table
##
##-------------------------------------

## practice with legacy; TODO:  run lookup against newly entered data
## Unique Test_Names
{
	library(data.table)
#	
	the_dir="/home/jim/code/health_labs/DATA/legacy/"
	IN_FILE  <- file(paste0(the_dir, "2021_03_19_FINAL_CLEAN.csv"))
	dt  <- as.data.table(read.csv(IN_FILE))
	dt
	dt[, .(Test_Name)]

	dt[, .(sort(unique(Test_Name)))]


}


####	Construct Lookup table, dt_lab and dt_lab_add (for additions)
{
dt_lookup  <- data.table(Test_Name=c("VLDL", "Ur_Ox24", "eGFR"),
											Test_Range=c("", "25-200", ""),
											Test_Comment=c("**need to addd**", "..comment..", "")
	)
str(dt_lookup)
dt_lookup
dput(dt_lookup)
}

{
#	all rows of dt_lookup (appears same as inner join?)
dt1  <- dt[dt_lookup, on = .(Test_Name) ]
}

dt1
# why need?
print(dt1)




####	Warmup:  List rows of dt match Test_Name
{
	dt[Test_Name == "VLDL"]
	dt[Test_Name != "VLDL"]


	#	Join, dt_lab is lookup, match on columns for Test_Name; return columns
	#	shown by .(r1, r2, .... s1, s2 ..):w
	#
	dt[dt_lookup			, on = .(Test_Name=Test_Name), .(Date, Test_Name, Test_Result,   Test_Range, Test_Comment)]


}






vim: timeoutlen=500 
