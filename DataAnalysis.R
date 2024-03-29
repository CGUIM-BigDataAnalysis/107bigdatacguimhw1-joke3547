#1.
library(dplyr)
library(readr)
X103ESA<-read_csv("C:/Users/user/Desktop/R-Practices/A17000000J-020066-Qod/103ES.csv")
X106ESA<-read_csv("C:/Users/user/Desktop/R-Practices/A17000000J-020066-Qod/106ES.csv")
for (n in 1:14){
  X103ESA[[n]]<-gsub("—|…|、|_","",X103ESA[[n]])
}
for (n in 1:14){
  X106ESA[[n]]<-gsub("—|…|、|_","",X106ESA[[n]])
}
X103ES1<-select(X103ESA,大職業別,starts_with("大學"),starts_with("研究所"))
X106ES1<-select(X106ESA,大職業別,starts_with("大學"),starts_with("研究所"))
combined_data<-inner_join(X103ES1,X106ES1,by="大職業別")

combined_data$`大學-薪資.x`<-as.numeric(combined_data$`大學-薪資.x`)
combined_data$`大學-薪資.y`<-as.numeric(combined_data$`大學-薪資.y`)
combined_data$比例<-combined_data$`大學-薪資.y`/combined_data$`大學-薪資.x`

combined_data<-na.omit(combined_data)
combined_data<- arrange(combined_data,desc(比例))
higher<-combined_data[combined_data$比例>1,]
knitr::kable(higher)
knitr::kable(head(higher,10))

more5p<-combined_data[combined_data$比例>1.05,]
knitr::kable(table(more5p))

MC0<-strsplit(more5p$大職業別,"-")
MC<-c()
for(n in 1:58){
  MC<-c(MC,MC0[[n]][1])
}
knitr::kable(table(MC))

#2.

X104ESA<-read_csv("C:/Users/user/Desktop/R-Practices/A17000000J-020066-Qod/104ES.csv")
X105ESA<-read_csv("C:/Users/user/Desktop/R-Practices/A17000000J-020066-Qod/105ES.csv")
for (n in 1:14){
  X104ESA[[n]]<-gsub("—|…|、|_","",X104ESA[[n]])
}
for (n in 1:14){
  X105ESA[[n]]<-gsub("—|…|、|_","",X105ESA[[n]])
}

X103ES2<-select(X103ESA,年度,大職業別,starts_with("大學"),starts_with("研究所"))
X104ES2<-select(X104ESA,年度,大職業別,starts_with("大學"),starts_with("研究所"))
X105ES2<-select(X105ESA,年度,大職業別,starts_with("大學"),starts_with("研究所"))
X106ES2<-select(X106ESA,年度,大職業別,starts_with("大學"),starts_with("研究所"))
combined_data2<-rbind(X103ES2,X104ES2,X105ES2,X106ES2)
combined_data2$`大學-女/男`<-as.numeric(combined_data2$`大學-女/男`)
combined_data2<-na.omit(combined_data2)
combined_data2<-arrange(combined_data2,`大學-女/男`)

MaleMore<-subset(combined_data2,`大學-女/男`<100)
knitr::kable(table(MaleMore$大職業別))#薪資男>女的行業
knitr::kable(MaleMore)#依照差異大小由大到小排序
knitr::kable(head(MaleMore,10))#呈現前十名的資料

FemaleMore<-subset(combined_data2,`大學-女/男`>100)
FemaleMore<-arrange(FemaleMore,desc(`大學-女/男`))
knitr::kable(table(FemaleMore$大職業別))#薪資女>男的行業
knitr::kable(FemaleMore)#依照差異大小由大到小排序
knitr::kable(head(FemaleMore,10))#呈現前十名的資料

#3.
X106ES3<-select(X106ESA,大職業別,starts_with("大學-薪資"),starts_with("研究所及以上-薪資"))
X106ES3[[2]]<-as.numeric(X106ES3[[2]])
X106ES3[[3]]<-as.numeric(X106ES3[[3]])
X106ES3<-na.omit(X106ES3)
X106ES3$比例<-X106ES3$`研究所及以上-薪資`/X106ES3$`大學-薪資`
X106ES3<-arrange(X106ES3,desc(比例))
knitr::kable(X106ES3)
knitr::kable(head(X106ES3,10))

#4.
X106ES4<-select(X106ESA,大職業別,starts_with("大學-薪資"),starts_with("研究所及以上-薪資"))
X106ES4[[2]]<-as.numeric(X106ES4[[2]])
X106ES4[[3]]<-as.numeric(X106ES4[[3]])
X106ES4<-na.omit(X106ES4)
knitr::kable(X106ES4[grepl("資訊及通訊",X106ES4$大職業別),])
X106ES4$差值<-X106ES4$`研究所及以上-薪資`-X106ES4$`大學-薪資`
X106ES4<-arrange(X106ES4,desc(差值))
knitr::kable(X106ES4[grepl("資訊及通訊",X106ES4$大職業別),])

