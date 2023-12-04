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

# This dataset is from United nations and contains data for human developmental index, life expectancy, education, 
# and gross national income and couple of other variables per country. Additionally I have created 2 new variables 
# comparing women and men by education level and labor participation.

# First, lets explore the dataset. it has total of 195 countries and 20 variables
str(human)
dim(human)

#excluding unneeded variables
exclude <- c("Country", "Edu.Ratio", "Labor.Ratio", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

df <- human[,exclude]

#excluding rows with incomplete data
df$na <- complete.cases(df)
df <- df[df$na == TRUE,]

#excluding region rows
df <- df[1:155,]
df <- df[,1:9]

write_csv(df, file = "human.csv")
