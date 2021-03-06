library(nnet)

#---------------- loading data ------------#
data_set.original  = read.table("./datas/flag.data", sep=",", row.names = 1,numerals = "no.lose")

#---------------- preprocessing -----------#
    #------------ first step ---------#

name.cols = c("landmass", "zone", "area", "populati", "language", "religion", "bars", "stripes", "colours", "red", "green", "blue", "gold", "white", "black", "orange", "mainhue", "circles", "crosses", "saltires", "quarters", "sunstars", "crescent", "triangle", "icon", "animate", "text", "topleft", "botright")
colnames(data_set.original) = name.cols

#landmass
landmass.level = c("N.America", "S.America", "Europe", "Africa", "Asia", "Oceania")
landmass = apply( as.matrix(data_set.original$landmass),1, function(x) landmass.level[x] )

#zone
zone.level = c("NE", "SE", "SW", "NW")
zone = apply( as.matrix(data_set.original$zone),1, function(x) zone.level[x] )

#language
language.level = c("English", "Spanish", "French", "German", "Slavic", "Other Indo-European", "Chinese", "Arabic", "Japanese/Turkish/Finnish/Magyar", "Others")
language = apply( as.matrix(data_set.original$language),1, function(x) language.level[x] )

#religion 
religion.level = c("Catholic", "Other Christian", "Muslim", "Buddhist","Hindu","Ethnic", "Marxist", "Others")
religion = apply( as.matrix(data_set.original$religion),1, function(x) religion.level[x+1] )

data_set = as.data.frame(cbind(landmass,zone,language,religion,data_set.original[,!colnames(data_set.original) %in% c("landmass","zone","language","religion")]))

saveRDS(data_set,"./results/flag.original")

    #-------------- preprocessing ---------------#
#------- binirizing cathégorials variables ---------#

summary(data_set)

categorials = data_set[,apply(apply(data_set, 2, function(x) as.numeric(x)), 2, function(x) !is.na(x))[1,]]


saveRDS(data_set,"./results/flag.preprocessed")

