data2<-read.csv('./Desktop/大三下学期/SAS/SAS_project/result4.csv')
length(data2)
data2<-read.csv('./Desktop/大三下学期/SAS/SAS_project/result9.csv')
data3<-read.csv('./Desktop/大三下学期/SAS/SAS_project/result10.csv')
sum(data2$Air.conditioning)
data2$property_type


data2<-data[,c(1,2,4,11:59)]

table(data2$neighbourhood)

data_entire<-data2[data2[,18]=='Entire home/apt',]
data_private<-data2[data2[,18]=='Private room',]
data_shared<-data2[data2[,18]=='Shared room',]

table(data_entire$property_type)
table(data_private$property_type)
table(data_shared$property_type)

for(i in 1:length(data2$host_response_time)){
  if(data2$host_response_time[i] == 'a few days or more'){
    data2$host_response_time[i] = 'a few days or more'
    }
  else if(data2$host_response_time[i] == 'within a day'){
    data2$host_response_time[i] = 'within a day'
    }
  else if(data2$host_response_time[i] == 'within a few hours'){
    data2$host_response_time[i] = 'within a few hours'
    }
  else if(data2$host_response_time[i] == 'within an hour'){
    data2$host_response_time[i] = 'within an hour'
    }
  else{
    data2$host_response_time[i] = 'unknown'
    }
}

data3 <- data2[data2[,44]!='NA',]


data3<-data2[,c(22,41:115)]
fit<-lm(log(data2$price)~data2$host_identity_verified+data2$host_is_superhost+data2$neighbourhood+data2$property_type+data2$accommodates+
          data2$bedrooms+data2$beds+data2$minimum_nights+data2$has_availability+data2$bath+data2$Bathroom+data2$Kitchen+
          data2$Basic+data2$Security+data2$Checkin+data2$description+data2$neiover,data = data2)
summary(fit)
table(data2[,6])
table(data2$room_type)
table(data2$property_type)

table(data2$host_response_rate)
table(data2$host_acceptance_rate)

table(data3$has_availability)
table(data2$property_type)




