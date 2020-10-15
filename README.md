# FT-IR-Batch-Analysis--ChemoSpec
Batch Analysis for quantifying FTIR spectra to access bone composition (Amide I, Phosphate, Carbonate, Collagen Maturity, Crystallinity, XLR, Acid Phosphate)

FTIR Batch.R: Run all the spectra analyzed under one code. It is a combination f the following codes:
Preprocessing Wavenumber_Batch.R - this code preprocesses the raw CSV files to make sure all files have the same number of rows since all spectra must have the same dimensions
Baseline_Batch.R - baselining code 
Linear Regression of Baseline.R - plots the baseline for each spectra 
Bone Parameter Labels_Batch.R - labels each spectra for visualization of what parameters of the spectra are being account for
Bone Parameters Analysis_Batch.R - analysis of Amide I, Phosphate, Carbonate, Collagen Maturity, Crystallinity, XLR, and Acid Phosphate


