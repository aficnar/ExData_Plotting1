# Get relevant data
FirstLine <- read.table("household_power_consumption.txt",sep=";",header=FALSE,
                        stringsAsFactors=FALSE,skip=1,nrows=1)
FirstDate <- as.Date(FirstLine$V1,format="%d/%m/%Y")
StartDate <- as.Date("01/02/2007",format="%d/%m/%Y")
Diff <- as.numeric(StartDate-FirstDate)
MyNames <- c("Date","Time","GAP","GRP","V","GI","SM1","SM2","SM3")
RawData <- read.table("household_power_consumption.txt",sep=";",header=FALSE,
                      stringsAsFactors=FALSE,col.names=MyNames,na.strings="?",
                      skip=1+(Diff-1)*60*24,nrows=3*60*24)
# Clean it up
Data <- RawData[RawData$Date=="1/2/2007"|RawData$Date=="2/2/2007",]
Data$Time <- strptime(paste(Data$Date,Data$Time),format="%d/%m/%Y %H:%M:%S")
Data$Date <- as.Date(Data$Date,format="%d/%m/%Y")
# Plot
png(filename="plot3.png",width=480,height=480)
plot(Data$Time,Data$SM1,type="l",xlab="",ylab="Energy sub metering")
points(Data$Time,Data$SM2,type="l",col="red")
points(Data$Time,Data$SM3,type="l",col="blue")
legend("topright",legend=c("Sub-metering_1","Sub-metering_2","Sub-metering_3"),
       lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
dev.off() 