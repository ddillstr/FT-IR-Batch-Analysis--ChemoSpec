#all the spectra read into Chemospec must have the same dimensions (same number of wavenumbers
#this code preprocesses the raw CSV files to make sure all files have the same number of rows

#Load libraries needed (if not installed then install them (install.library("NAME"))
library (readr)
library (stringr)

FTIRdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data"
setwd(FTIRdir)
dir.create("Preprocessed Wavenumber")

Modkdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Preprocessed Wavenumber"

RawFilesdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Spectra Raw Files"
setwd(RawFilesdir)

rawfiles = list.files((path = RawFilesdir))

for (i in 1:length(rawfiles)){
setwd(RawFilesdir)
wavenumberMod=paste("Modk", str_sub(rawfiles[i],-15,-1), sep ="_")
print(wavenumberMod)
spectravalues <- read_csv(rawfiles[i], col_names = FALSE)
lowerk = which(spectravalues[,1]==470.5536)
upperk = which(spectravalues[,1]==2129.544)
print(c(lowerk,upperk))
setwd(Modkdir)
write.table(spectravalues[lowerk:upperk,1:2], file = wavenumberMod, row.names = FALSE, col.names = FALSE, sep = ",") 
}
