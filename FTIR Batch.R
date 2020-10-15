FTIRBatch = "C:/Users/dillstrd/Desktop/FTIR/R/R Code/Batch Analysis/Individual Codes"

setwd(FTIRBatch)
print("Preprocessing Wavenumber_Batch")
source("Preprocessing Wavenumber_Batch.R")

setwd(FTIRBatch)
print("Baseline_Batch")
source("Baseline_Batch.R")

setwd(FTIRBatch)
print("Bone Parameter Labels_Batch")
source("Bone Parameter Labels_Batch.R")

setwd(FTIRBatch)
print("Bone Parameters Analysis_Batch")
#Load all Libraries needed
library(R.utils)
library (baseline)
library(IDPmisc)
library(MESS)

AmideIBand = c(1592,1712)
PhosphateBand = c(920,1200)
CarbonateBand = c(850,890)
CollagenMaturitySubbands = c(1660,1690)
	CMLowerBand= which.min(abs(wavenumber-CollagenMaturitySubbands[1]))
	absorbance(CMLowerBand)
	CMUpperBand= which.min(abs(wavenumber-CollagenMaturitySubbands[2]))
	absorbance(CMUpperBand)
CrystallinitySubbands = c(1020,1030)
	CrysLowerBand= which.min(abs(wavenumber-CrystallinitySubbands[1]))
	absorbance(CrysLowerBand)
	CrysUpperBand= which.min(abs(wavenumber-CrystallinitySubbands[2]))
	absorbance(CrysUpperBand)
XLRSubbands = c(1678,1692)
	XLRLowerBand= which.min(abs(wavenumber-XLRSubbands[1]))
	absorbance(XLRLowerBand)
	XLRUpperBand= which.min(abs(wavenumber-XLRSubbands[2]))
	absorbance(XLRUpperBand)
AcidPhosphateSubbands = c(1030,1106)
	APLowerBand= which.min(abs(wavenumber-AcidPhosphateSubbands[1]))
	absorbance(APLowerBand)
	APUpperBand= which.min(abs(wavenumber-AcidPhosphateSubbands[2]))
	absorbance(APUpperBand)

FTIRdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data"
setwd(FTIRdir)
dir.create("Summary Analysis")

Summarydir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Summary Analysis"
setwd(Summarydir)

Modkdir = "C:/Users/dillstrd/Desktop/FTIR/R/Data/Preprocessed Wavenumber"
Modkfiles = list.files((path = Modkdir))
SummaryAnalysis = vector ()

for (i in 1:length(Modkfiles)){
	files <- Modkfiles[i]
	AmideI = auc(wavenumber, absorbance[i,], from = AmideIBand[1], to =AmideIBand[2])
	Phosphate = auc(wavenumber, absorbance[i,], from = PhosphateBand[1], to =PhosphateBand[2])
	Carbonate = auc(wavenumber, absorbance[i,], from = CarbonateBand[1], to =CarbonateBand[2])
	CarbonatePhosphate = Carbonate/Phosphate
	MineralMatrix = Phosphate/AmideI
	CollagenMaturity = absorbance[i, CMUpperBand]/absorbance[i, CMLowerBand]
	Crystallinity = absorbance[i, CrysUpperBand]/absorbance[i, CrysLowerBand]
	XLR = absorbance[i, XLRLowerBand]/absorbance[i, XLRUpperBand]
	AcidPhosphate = absorbance[i, APUpperBand]/absorbance[i, APLowerBand]
	
	Parameters <- c(AmideI, Phosphate, Carbonate, CarbonatePhosphate, MineralMatrix, CollagenMaturity, Crystallinity, XLR, AcidPhosphate)
	SummaryAnalysis[i] <- as.data.frame(Parameters)
	names(SummaryAnalysis)[i] <- str_sub(Modkfiles[i],-8,-5)
	print(SummaryAnalysis)
	write.table(SummaryAnalysis, "Summary Analysis.csv", sep = ",", col.names=NA, row.names = c('AmideI','Phosphate','Carbonate','CarbonatePhosphate', 'MineralMatrix', 'CollagenMaturity', 'Crystallinity', 'XLR', 'AcidPhosphate'))
}	

