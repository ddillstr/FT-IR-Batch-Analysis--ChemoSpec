rm(list=ls())

#Load libraries needed (if not installed then install them (install.library("NAME"))
library (readr)
library (stringr)

Baselinedir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Baseline"
setwd(Baselinedir)

Baselinefiles = list.files((path = Baselinedir))

for (i in 1:length(Baselinefiles)){
	BaselineMod=paste("Baselined", str_sub(Baselinefiles[i],-8,-1), sep ="_")
	BaselinedSpectra <- read_csv(Baselinefiles[i], col_names = FALSE)
	BaselinedSpectra <- append(BaselinedSpectra, BaselinedSpectra[,3]-BaselinedSpectra[,2])
	names(BaselinedSpectra)<- c('Wavenumber', 'Unbaselined Absorbance', 'Baselined Absorbance', 'Baseline')
	write.table(BaselinedSpectra[1:4],file = BaselineMod, row.names = FALSE, col.names = TRUE, sep = ",")
}

for (i in 1:length(Baselinefiles)){
	BaselinedSpectra <- read_csv(Baselinefiles[i], col_names = FALSE)
	Absorbance = as.data.frame(BaselinedSpectra[1])
	LinearRegression = as.data.frame(BaselinedSpectra[3])
	points(LinearRegression, Absorbance)
}