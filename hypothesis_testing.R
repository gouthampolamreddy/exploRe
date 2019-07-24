rm(list = ls())

temp_data = read.csv("Cold_Storage_Temp_Data.csv")

str(temp_data)

library("dplyr")

## Mean in three seasons

summarise(group_by(temp_data, Season), mean(Temperature, na.rm = TRUE))

## Overall mean for the full year

temp_data %>% summarise(mean(Temperature, na.rm = TRUE))

## Standard Deviation for the whole year

temp_data %>% summarise(sd(Temperature, na.rm = TRUE))

# temp falling below 2 deg C

prob_below_two = pnorm(2, mean(temp_data$Temperature, na.rm = TRUE), sd(temp_data$Temperature, na.rm = TRUE))

# temp above 4 deg C

prob_above_four = pnorm(4, mean(temp_data$Temperature, na.rm = TRUE), sd(temp_data$Temperature, na.rm = TRUE), lower.tail = FALSE)

# Penalty  

penal_p = prob_below_two + prob_above_four

perc_penal = penal_p*100


#Z test
getwd()
recent_temp_data = read.csv("Cold_Storage_Mar2018 .csv")

mean_sample = mean(recent_temp_data$Temperature, na.rm = TRUE)
sd_population = sd(temp_data$Temperature, na.rm = TRUE)
z_critical = qnorm(0.1, mean(temp_data$Temperature, na.rm = TRUE), sd(temp_data$Temperature, na.rm = TRUE))
sample_size = 35
stand_error = sd_population/sqrt(sample_size)
mean_population = mean(temp_data$Temperature, na.rm = TRUE)

z = (mean_sample - mean_population)/stand_error
