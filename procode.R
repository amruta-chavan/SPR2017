dat<-read.csv("D:/Spring 2017/Project/DFR_Data_FY2016.csv",header=T)
report<-read.csv("D:/Spring 2017/Project/ESRD_Dialysis_Adequacy.csv",header=T)

library(data.table)
d1<-data.table(dat)
d2<-data.table(report)
# set the ON clause as keys of the tables:
setkey(d1,provname)
setkey(d2,FacilityName)

# perform the join using the merge function
Result <- merge(d1,d2, all.x=TRUE,by.x = "provname",by.y = "FacilityName")

#
write.table(Result,"D:/Spring 2017/Project/AllDat.txt", sep=",")

#Cleaning Data
cleanit<-read.csv("D:/Spring 2017/Project/FinalData/AllDat.csv",header=T)
View(cleanit)
#replace values
cleanit[cleanit=="."]<-NA
write.table(cleanit,"D:/Spring 2017/Project/FinalData/AllVat.txt", sep=",")

#cleand data
cleand<-read.csv("D:/Spring 2017/Project/FinalData/AllVal.csv",header=T)
#Remove columns with NA values
dt<-cleand[, colSums(is.na(cleand)) != nrow(cleand)]

#Cleaning
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)

full<-dt[colSums(!is.na(dt)) > 5000]
write.table(full,"D:/Spring 2017/Project/FinalData/morerefined.txt", sep=",")
cmplt<-full[complete.cases(full),]


#POattern

f1<-full[, -grep("1+", colnames(full))]
f2<-f1[, -grep("2+", colnames(f1))]
f3<-f2[, -grep("3+", colnames(f2))]
f4<-f3[, -grep("4+", colnames(f3))]

#Not cited and missing
f4[f4=="Not+"]<-NA
f4[f4=="Cited"]<-NA
f4[f4=="Missing"]<-NA


#Remove NA values
consz<-f4[, colSums(is.na(f4)) != nrow(f4)]
write.table(consz,"D:/Spring 2017/Project/FinalData/consizedata.txt", sep=",")

