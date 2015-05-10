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
png(filename="plot2.png",width=480,height=480)
plot(Data$Time,Data$GAP,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off() 