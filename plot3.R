# household_power_consumption.txt in working directory 
## get the index of the lines wih dates 2007-02-01 and 2007-02-02
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))
# Read only data from selected lines, this step avoid excesive use of memory
data<-read.table("household_power_consumption.txt",sep=";",nrows=length(lines),skip=lines[1]-1)
# Read the attribute names
attrnames<-read.table("household_power_consumption.txt",sep=";",nrows=1,skip=0,header=TRUE)

# DATA TRANSFORMATIONS
# Assign the attribute names after convert to lowercase
names(data)<-tolower(names(attrnames))
# Convert the variables Date and Time to date/time classes
a<-paste(data$date,data$time)
data$newdate<-strptime(a,  "%d/%m/%Y %H:%M:%S")
#data$newdate<-as.Date(b)

# Figure 3
png("plot3.png",width=480,height=480)
plot(data$newdate,data$sub_metering_1+data$sub_metering_2+data$sub_metering_3,type="n",
     ylab="Energy sub metering",xlab="")
lines(data$newdate,data$sub_metering_1)
lines(data$newdate,data$sub_metering_2,col="red")
lines(data$newdate,data$sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()