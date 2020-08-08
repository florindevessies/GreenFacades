library(here) # v. 0.1
library(stringr) # v. 1.2.0
library(purrr) # v. 0.2.3
library(tidyverse)
library(data.table)
install.packages("readxl")
library("readxl")
install.packages("writexl")
library("writexl")

#FIRST: save script in the same folder as target
wd <- setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
list.files()
here()
# load all files that need to be combined
(allfiles = list.files(pattern = ".XLS",
                      full.names = TRUE,
                      recursive = TRUE))

allfiles

# create empty dataframe, loop over list of all files 
df <- list()
for (row in allfiles) {
  #read all excel files, save them in content
  content <-  read_excel(row, col_names = TRUE)
  # if the dataframe is empty, fill it up with the first excel sheet
  if(is.null(df)){
    df <- content 
  }
  # if not empty, add it to the list
  else{
    df[[row]] <- data.frame(content)
    # dataframe <- list(dataframe, content)    
  }
}
df
# combine all input of the dataframe in one and making averages
combi <- rbindlist(df)[,lapply(.SD,mean), list(Date, Time)]

# write to excel
xls <- write_xlsx(combi, "averages_PET_west_plain.xlsx", col_names = TRUE)

#change names of first row
names(grid27) <- gsub(" ", "", names(grid27))
names(grid27) <- gsub("\\(.*","", names(grid27))
grid27
grid28 = read_excel(allfiles[2])
names(grid28) <- gsub(" ", "", names(grid28))
names(grid28) <- gsub("\\(.*","", names(grid28))




