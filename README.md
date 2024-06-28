# NCRA coastal code pipeline to process sea level rise increments of coastal hazard metrics using Canute values from O'Grady et al 2019 JGR oceans
Data, plots and code to generate national coastal hazard maps

The NCRA [coastal inundation layers are explained here ](https://htmlpreview.github.io/?https://github.com/AusClimateService/ncra_coastal_hazards/blob/main/Inundation_layers.html)

Processing of the hazard metrics is explained in this [Rmarkdown notebook](https://htmlpreview.github.io/?https://github.com/AusClimateService/ncra_coastal_hazards/blob/main/Extreme_water_level_hazards.html)

Extreme value distribution parameters were sourced from [Canute 3](https://shiny.csiro.au/Canute3_0/) with reference to [O'Grady et al 2019](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2018JC014871) to estimate Annual Exceedance Probabilities (AEPs) and AEP multiplication factors. Tide gauge estimates have been updated to the latest version of [GESLAv3](https://gesla787883612.wordpress.com/). Multiplication factors are explained in [Canute 3](https://shiny.csiro.au/Canute3_0/) 

The code pipeline generates pdf images in the [plots](https://github.com/AusClimateService/ncra_coastal_hazards/tree/main/plots) dir of this git repo, and csv files in the [data](https://github.com/AusClimateService/ncra_coastal_hazards/tree/main/data) dir. 10th and 90th percentile estimates were made using 1.28 times the sqrt of the standard error of the scale parameter fit.    
  
File names are in the format \<metric\>\_\<domain\>\_\<multimodel\_allpercentiles\>\_\<SLR\>\.csv:  
  
* metric - Multiplication Factor
* domain - [GESLAv3](https://gesla787883612.wordpress.com/) or [ACSSH](https://data.csiro.au/collection/csiro:29013?q=coast%20hindcast&_st=keyword&_str=4&_si=2)
* multimodel_allpercentiles - files contain all percentiles.
* SLR - Sea level [cm]  
  
CSV file columns represent:  
  
* longitude
* latitude
* SLR - Sea level rise increment [m]
* SWL_AEP1PC - Still Water Level 1% AEP (storm tide including SLR) [m]
* MTWL_AEP1PC - Mean Total Water Level 1% AEP (storm tide including SLR and wave setup) [m]
* SWL_MFSLR_50 - SWL Multiplication Factor for the SLR 50th percentile 
* SWL_MFSLR_10 - SWL Multiplication Factor for the SLR 10th percentile 
* SWL_MFSLR_90 - SWL Multiplication Factor for the SLR 90th percentile 
* MTWL_MFSLR_50 - MTWL Multiplication Factor for the SLR 50th percentile 
* MTWL_MFSLR_10 - MTWL Multiplication Factor for the SLR 10th percentile 
* MTWL_MFSLR_90 - MTWL Multiplication Factor for the SLR 90th percentile
   
GESLAv3 csv file columns also include the TG name and the number of years with at least 80% of hourly observations (nCompleteYr)  

#### HOW TO USE THE METRICS ####  
  
***The SWL MF is primarily a metric to evaluate the increase in coastal flooding in protected harbors and estuaries due to SLR.***   

***The MTWL MF is primarily a metric to evaluate the increase in coastal erosion for ocean coasts.***  


#### The NCRA will explore SLR increments of 0.06, 0.1, 0.2, 0.38, 0.6 and 1.0 m
  
A value of SLR **0.06** extrapolates the current SLR trajectory from the IPCC AR6 baseline to 2020. Below is a table of global warming level (GWL) match ups to SSP to inform the SLR increments, based on IPCC Tables 9.9 and 9.10 in [Fox-Kemper et al 2021](https://www.ipcc.ch/report/ar6/wg1/downloads/report/IPCC_AR6_WGI_Chapter09.pdf).   
  
| Year | GWL | Table 9.10 (Indicative SSP for GWL) | Table 9.9 (Closest SLR and Year) | Table 9.9 Values Used for SLR Inc. |
|------|-----|-------------------------------------|----------------------------------|------------------------------------|
| 2030 | 1.5 | SSP1-2.6                            | SSP1-2.6                         | **0.09** (0.08–0.12)                   |
| 2050 | 2   | SSP1-2.6/SSP2-4.5                   | SSP2-4.5                         | **0.20** (0.17–0.26)                   |
| 2090 | 2   | SSP1-2.6/SSP2-4.5                   | SSP1-2.6                         | **0.39** (0.30–0.54)                   |
| 2090 | 3   | SSP2-4.5/SSP3-7.0                   | SSP5-8.5                         | **0.63** (0.52–0.83)                   |
| 2100 | 5   | SSP5-8.5                            | SSP5-8.5                         | 0.70 (0.63–**1.01**)                   |
