# NCRA coastal code pipeline to process sea level rise increments of coastal hazard metrics using Canute values from O'Grady et al 2019 JGR oceans
Data, plots and code to generate national coastal hazard maps

Processing is explained in this [Rmarkdown notebook](https://htmlpreview.github.io/?https://github.com/AusClimateService/ncra_coastal_hazards/blob/main/Extreme_water_level_hazards.html)

Extreme value distribution parameters were sourced from [Canute 3](https://shiny.csiro.au/Canute3_0/) with reference to [O'Grady et al 2019](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2018JC014871) to estimate Annual Exceedence Probabilites (AEPs) and AEP multiplication factors. Tide gauge estimates have been updated to the latest version of [GESLAv3](https://gesla787883612.wordpress.com/). Multiplication factors are explained in [Canute 3](https://shiny.csiro.au/Canute3_0/) 

The code pipeline generates pdf images in the [plots](https://github.com/AusClimateService/ncra_coastal_hazards/tree/main/plots) dir of this git repo, and csv files in the [data](https://github.com/AusClimateService/ncra_coastal_hazards/tree/main/data) dir. 10th and 90th percentile estimates were made using 1.28 times the sqrt of the standard error of the scale parameter fit.    
  
File names are in the format \<metric\>\_\<domain\>\_\<multimodel\_allpercentiles\>\_\<SLR\>\.csv:  
  
* metric - Multiplication Factor
* domain - [GESLAv3](https://gesla787883612.wordpress.com/) or [ACSSH](https://data.csiro.au/collection/csiro:29013?q=coast%20hindcast&_st=keyword&_str=4&_si=2)
* multimodel_allpercentiles - files contain all percentiles.
* SLR - Sea level [cm]  
  
CSV columns represent:  
  
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

