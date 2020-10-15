#Load all Libraries needed
library(ChemoSpec)
library (readr)
library (stringr)

#Create Folders
FTIRdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data"
setwd(FTIRdir)
dir.create("Summary Workspace")
dir.create("Figures")
dir.create("Baseline")

Figuresdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Figures"
Summarydir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Summary Workspace"
Baselinedir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Baseline"

#Identify working directory
Modkdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Preprocessed Wavenumber"
setwd(Modkdir)

Modkfiles = list.files((path = Modkdir))

for (i in 1:length(Modkfiles)){
	setwd(Modkdir)
	unbaselined = files2SpectraObject(gr.crit = c("Modk"), gr.col = c("black"), freq.unit = "Wavenumber (cm^-1)", int.unit = "Absorbance", descrip = "Inbred Rats", out.file = "Summary", header = FALSE, sep = ",", dec =".")
	sumSpectra(unbaselined)
	plotSpectra(unbaselined, which = c(1:i), lab.pos = 1000)

	graphics.off()
	baselined = baselineSpectra(unbaselined, int = FALSE, method = "linear", retC = TRUE)
	plotSpectra(baselined, which = c(1:i) , lab.pos = 1000)
	
	BaselineMod=paste("Baselined", str_sub(Modkfiles[i],-8,-1), sep ="_")
	RawData <- read_csv(Modkfiles[i], col_names = FALSE)
	RawData$BaselinedData <- c(t(baselined$data[i,]))
	RawData <- append(RawData, RawData[,2]-RawData[,3])
	names(RawData)<- c('Wavenumber', 'Unbaselined Absorbance', 'Baselined Absorbance', 'Baseline')

	setwd(Baselinedir)
	write.table(RawData[1:4],file = BaselineMod, row.names = FALSE, col.names = TRUE, sep = ",")
}

setwd(Summarydir)
save(object=unbaselined, file = "Workspace Summary.RData")
save(object=baselined, file = "Workspace Summary.RData")

setwd(Figuresdir)
tiff(filename="UnBaselined.tiff")
plotSpectra(unbaselined, which = c(1:i), lab.pos = 1000)

graphics.off()

setwd(Figuresdir)
tiff(filename="Baselined.tiff")
plotSpectra(baselined, which = c(1:i) , lab.pos = 1000)

dev.off()

setwd(Baselinedir)
Baselinefiles = list.files((path = Baselinedir))

graphics.off()
tiff(filename="Baselines.tiff")
plotSpectra(unbaselined, which = c(1:i), lab.pos = 1000)
LinearRegression = vector()

for (i in 1:length(Baselinefiles)){
	BaselinedData <- read_csv(Baselinefiles[i], col_names = TRUE)
	BaselineDataPoints = BaselinedData$Baseline
	Wavenumber = BaselinedData$Wavenumber
	Baseline <- cbind(Wavenumber, BaselineDataPoints)
	points(Baseline, which = c(1:i), pch = ".", col = "red")
}

dev.off()
