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

# Figure 1
png("plot1.png",width=480,height=480)
hist(data$global_active_power,xlab="Global Active Power (kilowatts)",
     main="Global Active Power",col="red")
dev.off()