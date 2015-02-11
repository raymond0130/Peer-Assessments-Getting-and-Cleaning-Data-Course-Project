setwd("F:/-资料库-/Coursera公开课/Coursera-DataScience/3、Getting and Cleaning Data-获取和整理数据/项目实验/1、Peer Assessments/UCI HAR Dataset")

#读取activity_labels、features
activity_labels<-read.table("activity_labels.txt")
names(activity_labels)<-c("id","Activity")

features<-read.table("features.txt")
names(features)<-c("id","features")


#读取train文件夹下的文件
x_train<-read.table("./train/X_train.txt")
subject_train<-read.table("./train/subject_train.txt")
y_train<-read.table("./train/y_train.txt")

#读取test文件夹下的文件
x_test<-read.table("./test/X_test.txt")
subject_test<-read.table("./test/subject_test.txt")
y_test<-read.table("./test/y_test.txt")

#合并train/test中的y与Subject文件 
train_y_subject<-cbind(y_train,subject_train)
names(train_y_subject)=c("Activity","Subject")


test_y_subject<-cbind(y_test,subject_test)
names(test_y_subject)=c("Activity","Subject")

#合并test、train文件
y_subject<-rbind(train_y_subject,test_y_subject)
x<-rbind(x_train,x_test)
#命名x中的列
names(x)<-features[,2]

#注意正则表达式的转义字符
#筛选列名中含有"mean()"或"std()"的列
Eliminate_mean_std<-x[c(grep("mean\\(\\)",names(x)),grep("std\\(\\)",names(x)))]

dim(Eliminate_mean_std)
y_subject_Eliminate_mean_std<-cbind(y_subject,Eliminate_mean_std)
dim(y_subject_Eliminate_mean_std)

#计算per activity per subject  各指标均值
mean<-aggregate(y_subject_Eliminate_mean_std[,-c(1,2)],
                by=list(Activity=y_subject_Eliminate_mean_std$Activity,
                        Subject=y_subject_Eliminate_mean_std$Subject),FUN=mean)

dd<-merge(activity_labels,mean,by.y="Activity",by.x="id")[,-1]
head(dd)

#导出
write.table(dd,"dd.txt",row.names=FALSE)
