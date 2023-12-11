
#load the data
c6a <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  = " ", header = T)
c6b <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "", header = T)

#exploring
str(c6a)
str(c6b)
View(c6a)
View(c6b)

#changing to factor variables
c6a$treatment <- factor(c6a$treatment)
c6a$subject <- factor(c6a$subject)

c6b$Group <- factor(c6b$Group)

# Convert to long form
c6al <-  pivot_longer(c6a, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "BPRS") %>%
  arrange(weeks) #order by weeks variable


c6bl <- pivot_longer(c6b, cols = -c(ID, Group), 
                      names_to = "days",
                      values_to = "RATS") %>% 
  mutate(Time = as.integer(substr(days, 3, 5))) %>%
  arrange(Time)

#extract week number
c6al <-  c6al %>% 
  mutate(week = as.integer(substr(weeks, 5, 8)))

#exploring the long form data. long form helps in analysis as the time points can be used now as covariates in the analysis
str(c6al)
str(c6bl)
summary(c6al)
summary(c6bl)

#checking the variable names
names(c6al)
names(c6bl)

write.csv(c6al, "BPRS.csv")
write.csv(c6bl, "RATS.csv")
