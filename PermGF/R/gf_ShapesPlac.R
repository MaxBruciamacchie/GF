gf_ShapesPlac <-
function() {
  dir.create("SIG")
  dir.create("SIG/Vecteurs")
  library(rgdal)
  library(maptools)
#   load("Tables/gfTablesElaboreesPlac.RData")

  Coords$Observation <- NULL
  Coords$EPSG <- NULL
  coordinates(Coords) <- ~ Xgps + Ygps
  proj4string(Coords) <- CRS("+init=epsg:2154")

  # ----------------------- Fusion
  mailleDen <- Coords
  mailleDen@data <- merge(mailleDen@data, gfPla[,c(1:3,5:11)], by=c("NumForet","NumPlac"), all.x=T)
  tab <- gfPlaEssRegDen[,c(1:4,6)] # Composition
  tab <- dcast(tab,  NumForet + NumPlac + Cycle ~ EssReg, value.var="Gha", na.rm=T)
  mailleDen@data <- merge(mailleDen@data, tab, by=c("NumForet","NumPlac","Cycle"), all.x=T)
  tab <- gfPlaCat[,c(1:4,6)] # Structure
  tab <- dcast(tab,  NumForet + NumPlac + Cycle ~ Cat, value.var="Gha", na.rm=T)
  mailleDen@data <- merge(mailleDen@data, tab, by=c("NumForet","NumPlac","Cycle"), all.x=T)
  tab <- gfPerchesPlaEss[,c(1:4,6)] # Perches
  tab <- dcast(tab,  NumForet + NumPlac + Cycle ~ EssReg, value.var="Gha", na.rm=T)
  names(tab)[4:dim(tab)[2]] <- paste("Perches",names(tab)[4:dim(tab)[2]])
  mailleDen@data <- merge(mailleDen@data, tab, by=c("NumForet","NumPlac","Cycle"), all.x=T)
  tab <- gfTaillisPlaEssReg[,c(1:4,6)] # Taillis
  tab <- dcast(tab,  NumForet + NumPlac + Cycle ~ EssReg, value.var="Gha", na.rm=T)
  names(tab)[4:dim(tab)[2]] <- paste("Taillis",names(tab)[4:dim(tab)[2]])
  mailleDen@data <- merge(mailleDen@data, tab, by=c("NumForet","NumPlac","Cycle"), all.x=T)
  tab <- gfRegePlaEssReg # Rege
  tab$NbSemis <- tab$Classe1 + tab$Classe2 + tab$Classe3
  tab <- tab[,c(1:4,9)]
  tab <- dcast(tab,  NumForet + NumPlac + Cycle ~ EssReg, value.var="NbSemis", na.rm=T)
  names(tab)[4:dim(tab)[2]] <- paste("Semis",names(tab)[4:dim(tab)[2]])
  mailleDen@data <- merge(mailleDen@data, tab, by=c("NumForet","NumPlac","Cycle"), all.x=T)

  # ----------------------- Ecriture et sauvegarde --------------
  writePointsShape(mailleDen, "SIG/Vecteurs/mailleDen")
  save(mailleDen, file = "Tables/gfShapesPlac.Rdata")
}
