library(ggplot2)  
# loading the graphical library ggplot2  
#DF <- read.csv("//home//Downloads//new_2008.csv")  
DF <- read.csv("C://Users//Ritik//Downloads//2008.csv")
#colnames(DF) <- c("SNo", "Year"....)  
dim(DF)  
str(DF)  
vec <- c("Year", "Month", "DayofMonth", "DayOfWeek", "DepTime", "CRSDepTime", "ArrTime", "CRSArrTime", "UniqueCarrier", "FlightNum", "TailNum", "ActualElapsedTime", "CRSElapsedTime", "AirTime", "ArrDelay", "DepDelay", "Origin", "Dest", "Distance", "TaxiIn", "TaxiOut", "Cancelled", "CancellationCode", "Diverted", "CarrierDelay", "WeatherDelay", "NASDelay", "SecurityDelay", "LateAircraftDelay") 
colnames(DF) <- vec  
str(DF)  
X <- DF$ArrDelay + DF$DepDelay  
summary(X) 
 
Y <- with(DF, ArrDelay + DepDelay)  
summary(Y)  
#table  
table(DF$UniqueCarrier)  
with (DF, table(UniqueCarrier))  
with (DF, table(UniqueCarrier, CancellationCode))  
#proportions 
X <- with (DF, table(UniqueCarrier))  
X/sum(X)*100  
# flights related to Christmas season # take a subset of flights on Dec 25  
ChristmasFlights <- subset(DF, DayofMonth == 25)  
summary(ChristmasFlights) 
dim(ChristmasFlights) 
ChristmasWeek <- subset(DF, DayofMonth %in% 21:27)  
# between destinations - say origin is from JFK  
JFKStuff <- subset(DF, Origin == "JFK")  
JFKStuff <- subset(ChristmasFlights, Origin == "JFK" & Dest == "PIT")  
Somestations <- subset(ChristmasFlights, Origin %in% c("JFK", "PIT", "LGA"))  
# hist, plot, boxplot  
# basic syntax of ggplot   
# ggplot(dataframe, aesthetics = x coordinate, y coordinate, shape) + layer = geom_XYZ XYZ {bar, histogram}   
ggplot(DF, aes(x = UniqueCarrier)) + geom_bar()  
# stacked barchart - carrier & cancellationcode  
ggplot(DF, aes(x = UniqueCarrier, fill = CancellationCode)) + geom_bar()  
# stacked with proportion  
ggplot(DF, aes(x = UniqueCarrier, fill = CancellationCode)) + geom_bar(position="fill")  
# histogram (1 quantative variable)  
ggplot(DF, aes(x = Distance)) + geom_histogram()  
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this  
ggplot(DF, aes(x = Distance)) + geom_histogram(binwidth = 100)  
Note : Get data , Clean Data in HIVE , feed data into Tableau and show different techniques using different processing and charts.  
# Uncomment line below if theres an issue getting mySQL to work 
# HIVESERVER2 in unix prompt 
# install.packages("/home/edureka/Downloads/RHive_2.0-0.2.tar.gz", repos = NULL, type = "source") 
library(ggplot2)  
library(RHive) 
rhive.init() 
rhive.env() 
Sys.setenv(HADOOP_HOME="/usr/lib/hadoop-2.2.0") 
Sys.setenv(HADOOP_STREAMING="/usr/lib/hadoop-2.2.0/share/hadoop/tools/lib/hadoop-streaming-2.2.0.jar") 
Sys.setenv(HIVE_HOME="/usr/lib/hive-0.13.1-bin") 
Sys.setenv(HADOOP_CMD="/usr/lib/hadoop-2.2.0/bin/hadoop") 
Sys.setenv(RHIVE_FS_HOME="/home/edureka/Downloads/RHive") 
rhive.init() 
rhive.env() 
rhive.connect(host="192.168.56.102",user="edureka", defaultFS="hdfs://localhost:8020") 
rhive.query("show databases") 
rhive.query("use airlines") 
rhive.query("show tables") 
# rhive.query("drop table airport1") 
rhive.query("Select * from flights_delayed limit 10 ") 
DF <- rhive.query("Select * from flights_delayed") 
DF 
colnames(DF) 
length(rownames(DF)) 
# rhive.write.table(flight_delays, tableName = 'flight_delays', sep=',')  
# rhive.query("Select * from flight_delays limit 10") 
# flight_delays2 <- rhive.load.table(tableName = 'flight_delays') 
# flight_delays2 
dim(DF) 
str(DF)  
DF$flights_delayed.arr_delay  
X <- DF$flights_delayed.arr_delay + DF$flights_delayed.dep_delay  
summary(X)  
Y <- with(DF, flights_delayed.arr_delay + flights_delayed.dep_delay)  
summary(Y)  
summary(DF$flights_delayed.day) 
# flights related to Christmas season # take a subset of flights on Dec 25  
ChristmasFlights <- subset(DF, DF$flights_delayed.day == 25)  
summary(ChristmasFlights) 
dim(ChristmasFlights) 
ChristmasWeek <- subset(DF, flights_delayed.day %in% 21:27)  
# between destinations - say origin is from JFK   
# hist, plot, boxplot  
# basic syntax of ggplot    
# histogram (1 quantative variable)  
ggplot(DF, aes(x = DF$flights_delayed.distance)) + geom_histogram()  
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this  
ggplot(DF, aes(x = DF$flights_delayed.distance)) + geom_histogram(binwidth = 100) 