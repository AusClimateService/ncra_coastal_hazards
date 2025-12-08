require(terra)

colz = rev(c("#000078","#0000BB","#0000FF","#0C3AFC","#1975FA","#25B0F7","#32EBF5","#73EEE6","#B4F1D7","#F5F5C8",
             "#F5F564","#F5E032","#F6CC00","#F7A300","#F97A00","#FB5100","#FF0000","#DA0006","#B5000D","#910014",
             "#7B003D","#660066","#88008C","#AB00B2","#CD00D8","#F000FF","#CAA6DE","#DBA7DD","#EDA9D2"))#,"#FFABC7") )


ncolz = length(colz)
colzRamp = colorRampPalette(rev(colz))


roms = vect("ROMS_gumbel_parameters_SWLandMTWL_Australia")
cchaps = vect("CCHaPS_gumbel_parameters_SWLandMTWL_Australia")
cchaps_moderate = vect("CCHaPS_gumbel_parameters_SWLandMTWL_Australia_moderate")

par(mfrow = c(2,2))
plot(roms,"MTWLlam",col = colzRamp(30),type = "continuous",range = c(0,0.4),ext = ext(cchaps))
plot(cchaps_moderate,"MTWLlam",col = colzRamp(30),type = "continuous",range = c(0,0.4))
plot(cchaps,"MTWLlam",col = colzRamp(30),type = "continuous",range = c(0,0.4))



slr = 0.54

roms_mf = exp(slr/roms$MTWLlam)
roms_mf_ub = exp(slr/roms$MTWLlam+1.28*roms$MTWLlam_se)
median(roms_mf)
median(roms_mf_ub)

cchaps_moderate_mf = exp(slr/cchaps_moderate$MTWLlam)
cchaps_moderate_mf_lb = exp(slr / (cchaps_moderate$MTWLlam + 1.28 * cchaps_moderate$MTWLlam_se))

median(cchaps_moderate_mf,na.rm=TRUE)
median(cchaps_moderate_mf_lb,na.rm=TRUE)

cchaps_mf = exp(slr/cchaps$MTWLlam)
cchaps_mf_lb = exp(slr / (cchaps$MTWLlam + 1.28 * cchaps$MTWLlam_se))
median(cchaps_mf,na.rm=TRUE)
median(cchaps_mf_lb,na.rm=TRUE)



rSU = loopevd::netcdf_to_df("../canute3_0/data/SU_GT81_rGUM_25m_sta.1981-2013_beachslope_0.087.nc")
rSU = rSU[rSU$ROMS_lats < 360,]
rSUv = vect(cbind(rSU$ROMS_lons,rSU$ROMS_lats),"points")
rSU[1,]
rSUv$lam = rSU$mle.2
plot(rSUv,"lam",col = colzRamp(30),type = "continuous",range = c(0,0.4))

cTWv = vect("../canute3_0/data/CCHaPS/MTWL_GT_max_CCHaPS_1981-2020_fgumbel_beachslope_0.087.nc")
cSUv = vect("../canute3_0/data/CCHaPS/WSU_GT_max_CCHaPS_1981-2020_fgumbel_beachslope_0.087.nc")
cSUv2 = vect("../canute3_0/data/CCHaPS/WSU_GT_max_CCHaPS_1981-2020_fgumbel_beachslope_NA.nc")
plot(cSUv,"scale",col = colzRamp(30),type = "continuous",range = c(0,0.4))
plot(cSUv2,"scale",col = colzRamp(30),type = "continuous",range = c(0,0.4))

df = data.frame(x = cSUv$cov_4,y = cSUv2$slope)
require(ggplot2)
ggplot(df, aes(x, y)) +
  geom_bin2d() +
  scale_fill_continuous(trans = "log10") +  # optional: log colour scale
  labs(
    x = "x", y = "y",
    fill = "count",
    title = "2D histogram (bin2d)"
  ) +
  theme_minimal()

tg = vect("gesla3_fgumbel_shp")
tg = tg[tg$nCompleteY >= 20]

#Align the ROMs 1 year ARI (63% AEP) location parameter to the nearest tide gauge value following O'Grady et al 2019 and Haigh et al. 2014.
crs(roms) = crs(tg)
nb = nearby(roms,tg)
roms$muOff = tg$mle_1[nb[,2]]

crs(cchaps) = crs(tg)
nb = nearby(cchaps,tg)
cchaps$muOff = tg$mle_1[nb[,2]]

for(x in 1:length(cchaps))
 t(gumbel_mleAndConfIntvals(loc = cchaps$muOff[x],scale = cchaps$SWLlam[x],ARI = 1/AEP,nMonteCarloSims = 100))
