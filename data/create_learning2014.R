#read the data and form dataset to lrn14
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#forming combination variable vectors and 
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

#select variables for the analysis
analysisvar <- c("gender", "Age", "attitude", "deep", "stra", "surf", "Points")
a_lrn14 <- select(lrn14, one_of(analysisvar))

#excluding rows including 0 points
a_lrn14 <- filter(a_lrn14, Points > 0)

#setting working directory
setwd("/Users/aleksi/Documents/rkokeilut/IODS-project")

#creating a CSV file
write.csv(a_lrn14,file = "a_learn14.csv")

#test reading
test <- read.csv("a_learn14.csv")

str(test)
head(test)
