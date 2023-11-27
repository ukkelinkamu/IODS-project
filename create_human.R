library(readr)
library(dplyr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#structure and dimensions
str(hd)
str(gii)
dim(hd)
dim(gii)

#variable summaries
summary(hd)
summary(gii)

#rename variables
hd_c <- hd
gii_c <- gii

colnames(hd_c) <- c("HDI rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI-HDI")

colnames(gii_c) <- c("GII rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

#create ratio variables
gii_c <- mutate(gii_c, Edu.Ratio = Edu2.F/Edu2.M, Labor.Ratio = Labo.F/Labo.M)

human <- inner_join(hd_c, gii_c, by = "Country")

write.csv(human, file = "human.csv")

