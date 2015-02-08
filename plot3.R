#Download the sqldf library to process the power consumption data
install.packages("sqldf")

#Import the sqldf library 
library(sqldf)

#Create the file object from power consumption data file 
fi <- file("household_power_consumption.txt")

#Filter data for the desired dates as per assignment from the sample file provided 
#data1 : Dataframe to store the filtered data
data1 <- sqldf("select * from fi where Date in ('1/2/2007','2/2/2007')", file.format = list (header = TRUE , sep =";"))

#Substitue all ? with NA in the data1 dataframe
data1[data1 == "?"] = NA

#Ignore all NA data to avoid coersion warnings 
data2 <- na.omit(data1)

#Close the connection opened for reading file from working directory
close(fi)

#Combine date and timestamp files to single datasource column
data2$Date <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S" )

#Create a PNG plot with desired width , by default height and width are 480 
png("plot3.png" , width=480 , height=480)

#Create historgram for plot3 with mentioned colors , x-y lables 
plot(data2$Date, data2$Sub_metering_1, type="n", lwd="1", xlab="", ylab="Energy sub metering")

#Plot the individual line grpahs based on sub metring types 
lines(data2$Date, data2$Sub_metering_1 , col="black")
lines(data2$Date, data2$Sub_metering_2 , col="red")
lines(data2$Date, data2$Sub_metering_3 , col="blue")

#Mark the legend to identify the sub metering type grpahs 
legend("topright", pch="_", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Close the device opened for writing PNG format 
dev.off()
