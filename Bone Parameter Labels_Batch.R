#Parameters for FTIR Analysis
AmideIBand = c(1592,1712)
PhosphateBand = c(920,1200)
CarbonateBand = c(850,890)

absorbance = baselined$data
wavenumber = baselined$freq

setwd(Figuresdir)
tiff(filename="Bone Parameters.tiff")
plotSpectra(baselined, which = c(1:i) , xlim = c(rev(range(wavenumber))), yrange = range(absorbance), lab.pos = 1000)

#Add vertical lines to Spectra
abline(v=c(AmideIBand[1],AmideIBand[2]), col = "red")
text(1650,1, "Amide I", col = "red", font =2, srt=90)

abline(v=c(PhosphateBand[1],PhosphateBand[2]), col = "orange")
text(1150,1, "Phosphate", col = "orange",font =2, srt=90)

abline(v=c(CarbonateBand[1],CarbonateBand[2]), col = "green")
text(800,1, "Carbonate", col = "green", font =2, srt=90)

dev.off()



