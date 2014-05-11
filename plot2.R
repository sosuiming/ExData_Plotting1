#Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
#16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
#16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
#16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
#16/12/2006;17:27:00;5.388;0.502;233.740;23.000;0.000;1.000;17.000

#read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?")
fi <- file("household_power_consumption.txt", "r");

N = 10
df <- data.frame(date=character(),time=character(),gap=numeric(),grp=numeric(),v=numeric(),gi=numeric(),sm1=numeric(),sm2=numeric(),sm3=numeric(),stringsAsFactors=F);


pattern <- '^[1,2]/2/2007';
row <- 1
while (length(lines <- readLines(fi, n=1)) > 0)
{
    if (length(grep(pattern, lines[1] , perl=T)) > 0)
    {
        record = unlist(strsplit(lines[1], ';'));
        df[row,] <- record;
        row <- row + 1;
    }
}
close(fi);

dtimes <- paste(df$date, df$time, sep=' ');
dtimes <- strptime(dtimes, format = '%d/%m/%Y %H:%M:%S');

df <- transform(df, gap=as.numeric(gap),grp=as.numeric(grp),v=as.numeric(v),gi=as.numeric(gi),sm1=as.numeric(sm1),sm2=as.numeric(sm2),sm3=as.numeric(sm3));

png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12);
plot(dtimes, df$gap, type='l', xlab='', ylab='Global Active Power (kilowalts)');
dev.off()


