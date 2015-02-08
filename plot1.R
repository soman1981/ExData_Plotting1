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

#Create a PNG plot with desired width , by default height and width are 480 
png("plot1.png" , width=480 , height=480)


#Create historgram for plot1 with mentioned colors , x-y lables 
hist( data2$Global_active_power , xlab ="Global Active Power(kilowatts)" , main="Global Active Power" , col ="red")

# Close the device opened for writing PNG format 
dev.off()
