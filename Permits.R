# import the necessary packages, if not already imported
#install.packages("broom")
#install.packages("ggplot2")
#install.packages("gridExtra")
#install.packages("tidyverse")

# open the libraries
library(broom)
library(gridExtra)
library(ggplot2)
library(lubridate)
library(tidyverse)

# read in the data files and store them as as data.frame
building_permits <- read_csv("~/Documents/Building-Permits-in-Chicago/Data/Building_Permits.csv") %>%
    as.data.frame()
commarea <- read_csv("~/Documents/Building-Permits-in-Chicago/Data/CommArea.csv") %>%
    as.data.frame()

# subsetting desired features from building_permits
permits <- building_permits %>%
    select(ID:WORK_DESCRIPTION, SUBTOTAL_PAID, SUBTOTAL_UNPAID,
           SUBTOTAL_WAIVED:TOTAL_FEE, COMMUNITY_AREA:YCOORDINATE) %>%
    filter((!is.na(COMMUNITY_AREA) & !is.na(XCOORDINATE)) &
           # filtering out permits that were issued before the application was
           # started (seemingly illogical data)
           (PROCESSING_TIME > -1))

# PROCESSING_TIME vs TOTAL_FEE (without the maximum TOTAL_FEE so that the graph
# can be better scaled)
png("~/Documents/ProcessingTimeTotalFee.png")
permits %>%
    filter(TOTAL_FEE != max(TOTAL_FEE)) %>%
    ggplot(aes(PROCESSING_TIME, TOTAL_FEE)) + geom_point() +
    labs(title = "Processing Time vs Total Fee",
         x = "Processing Time (Days)",
         y = "Total Fee (US Dollars)")
dev.off()

cor.test(permits$PROCESSING_TIME, permits$TOTAL_FEE)

# the outlier in the data (when looking at PROCESSING_TIME vs TOTAL_FEE)
permits %>% filter(TOTAL_FEE == max(TOTAL_FEE)) %>% as.data.frame()

# COMMUNITY_AREA vs TOTAL_FEE
png("~/Documents/CommunityAreaTotalFee.png")
permits %>%
    ggplot(aes(COMMUNITY_AREA, TOTAL_FEE)) + geom_point() +
    labs(title = "Community Area vs Total Fee",
        x = "Community Area",
        y = "Total Fee (US Dollars)")
dev.off()

cor.test(permits$COMMUNITY_AREA, permits$TOTAL_FEE)

# COMMUNITY_AREA vs TOTAL_FEE (Table)
commareatotalfee <- permits %>%
    group_by(COMMUNITY_AREA) %>%
    summarize(mean = mean(TOTAL_FEE)) %>%
    as.data.frame() %>%
    tidy()

# WARD vs TOTAL_FEE
png("~/Documents/WardTotalFee.png")
permits %>%
    ggplot(aes(WARD, TOTAL_FEE)) + geom_point() +
    labs(title = "Ward vs Total Fee",
         x = "Ward",
         y = "Total Fee (US Dollars)")
dev.off()

cor.test(permits$WARD, permits$TOTAL_FEE)

# COMMUNITY_AREA vs PROCESSING_TIME
png("~/Documents/CommunityAreaProcessingTime.png")
permits %>%
    ggplot(aes(COMMUNITY_AREA, PROCESSING_TIME)) + geom_point() +
    labs(title = "Community Area vs Processing Time",
         x = "Community Area",
         y = "Processing Time (Days)")
dev.off()

# SUBTOTAL_PAID vs PROCESSING_TIME
png("~/Documents/SubtotalPaidProcessingTime.png")
permits %>%
    ggplot(aes(SUBTOTAL_PAID, PROCESSING_TIME)) + geom_point() +
    labs(title = "Subtotal (Paid) vs Processing Time",
         x = "Subtotal (Paid)",
         y = "Processing Time (Days)")
dev.off()

cor.test(permits$SUBTOTAL_PAID, permits$PROCESSING_TIME)

# CENSUS_TRACT vs PROCESSING_TIME
png("~/Documents/CensusTractProcessingTime.png")
permits %>%
    ggplot(aes(CENSUS_TRACT, PROCESSING_TIME)) + geom_point() +
    labs(title = "Census Tract vs Processing Time",
         x = "Census Tract",
         y = "Processing Time (Days)")
dev.off()



## CommArea DATASET

cor.test(commarea$AREA_NUMBE, commarea$AREA_NUM_1)
# r = 1 → AREA_NUMBE and AREA_NUM_1 are the same

# subsetting the community areas dataset for easier merging with the building
# permits dataset, and then merging
communities <- commarea %>% select(COMMUNITY_AREA = AREA_NUMBE, COMMUNITY)
merged <- left_join(permits, communities, by = "COMMUNITY_AREA")

# finding the new constructions permits per year
merged$NEW_CONSTRUCTION <-
    ifelse(merged$PERMIT_TYPE == "PERMIT - NEW CONSTRUCTION", 1, 0)

new_construction <- merged %>%
    group_by(COMMUNITY) %>%
    summarize(NUMBER = sum(NEW_CONSTRUCTION)) %>%
    arrange(desc(NUMBER)) %>%
    filter(!is.na(COMMUNITY))

png("~/Documents/NewPermitsPerYear.png")
merged$YEAR = year(mdy(merged$APPLICATION_START_DATE))
merged %>%
    filter((YEAR > 2005) & (YEAR < 2020)) %>%
    group_by(YEAR) %>%
    ggplot(aes(YEAR)) + geom_bar() +
    labs(title = "The Number of New Permits Every Year (2006 through 2019)",
         x = "Year",
         y = "The Number of New Permits")
dev.off()

# finding the Renovation / Alteration & Wrecking / Demolition permits per year
merged$RENOVATION_DEMOLITION <- 
  ifelse(merged$PERMIT_TYPE == "PERMIT - RENOVATION/ALTERATION" |
           merged$PERMIT_TYPE == "PERMIT - WRECKING/DEMOLITION", 1, 0)

renovation_demolition <- merged %>%
    group_by(COMMUNITY) %>%
    summarize(number = sum(RENOVATION_DEMOLITION)) %>%
    arrange(desc(number)) %>%
    as.data.frame() %>%
    filter(!is.na(COMMUNITY))