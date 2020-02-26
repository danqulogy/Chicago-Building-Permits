# Chicago Building Permits

**Goal –** To better understand which areas in Chicago are experiencing the most change in building permits

## Datasets

Both datasets in the Data folder ([Building_Permits.csv](https://data.cityofchicago.org/Buildings/Building-Permits/ydr8-5enu) and CommAreas.csv) are from the City of Chicago's Data Portal.

### Building Permits

The processing time versus the total fee for a permit may help us compare across neighborhoods to see how potentially wealthier neighborhoods may have less processing times. Looking at the TOTAL_FEE versus the PROCESSING_TIME, COMMUNITY_AREA, and WARD for different permits would be interesting to see how the fees vary for different areas and relative to how long it takes to process the permit. It also seems like it would be interesting to compare how long it takes permits in each community to process and see how different parts of Chicago may have work done quicker than another, if a correlation exists.

The data contains missing values for community area numbers, contact information for contacts 2 through 10, Property Index Numbers, east-west coordinates, and/or north-south coordinates in many permits. It indicates that many permits have only one contact point for the permit, have not always been recorded, and/or have missing information. For example, as noted on the City of Chicago's Data Portal page for this dataset, "Property Index Numbers (PINs) and geographic information (ward, community area and census tract) are provided for most permit types issued in 2008 or later." In this case, as seen in the data, there is missing information for certain building permits because it was not recorded. For all of the building permits with incomplete information, it would be difficult to compare and make generalizations about all building permits in Chicago from 2006 through 2019.

#### PROCESSING_TIME vs TOTAL_FEE

While the numbers still get very large on the y-axis, the graph below represents the permits comparing the processing time to the total fee, except for one outlier, where the processing time seemed extremely high, even for permits with a lower processing time.

![PROCESSING_TIME vs TOTAL_FEE](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/ProcessingTimeTotalFee.png)

The outlier was a New Construction permit that, according to the data, had $2,814,056 in total fees (with $2,750,554 of the subtotal waived).

#### SUBTOTAL_PAID vs PROCESSING_TIME

The amount of the subtotal paid seemed to have an interestingly higher correlation with the processing time thus far.

![SUBTOTAL_PAID vs PROCESSING_TIME](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/SubtotalPaidProcessingTime.png)

The points on this graph are more correlated than the graphs of other numerical values compared to processing time. The correlation coefficient is about 0.0232.

#### COMMUNITY_AREA vs TOTAL_FEE

When comparing the different community areas to the total fees of each permit, the graph seems to show that some community areas tend to have higher total fees than others, but as shown in the graph below, it is still pretty scattered, there is not much of a relationship between community areas and total fees.

![COMMUNITY_AREA vs TOTAL_FEE](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/CommunityAreaTotalFee.png)

Because the community area is assigned numbers that are not exactly measureable, it does not make sense to find the correlation coefficient to see how well correlated the community areas and the total fees are.

#### CENSUS_TRACT vs PROCESSING_TIME

When comparing the census tract of the primary location of the permit, we can see that certain census tracts seem to be more condensed than others.

![CENSUS_TRACT vs PROCESSING_TIME](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/CensusTractProcessingTime.png)

Because the census tract is also assigned and not a measureable quantity, it does not make sense to find the correlation coefficient to see how well correlated the census tracts and the processing times are.

#### COMMUNITY_AREA vs PROCESSING_TIME

When comparing the different community areas to the processing time, it seems like different communities have different ranges in processing times, but the graph appear to be a very strong correlation between which neighborhoods tend to have lower (or higher) processing times than others.

![COMMUNITY_AREA vs PROCESSING_TIME](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/CommunityAreaProcessingTime.png)

Just like before, because the community area is assigned numbers that are not exactly measureable, it does not make sense find the correlation between the community area and the processing time. However, we can see that certain communities do not seem to necessarily have less processing times than others.

#### Processing Times Correlation

Based on the graphs above and the correlation coefficients found, the subtotal paid and the processing time correlation are the most correlated.

### Community Areas

Just looking at the Community Areas dataset, it looks like the two area number columns (AREA_NUMBE and AREA_NUM_1) are the same. To verify, we would have to find the correlation coefficient.

```{r}
cor.test(commarea$AREA_NUMBE, commarea$AREA_NUM_1)
```

By running the line of code above, where `commarea` is the name of the data frame storing the data from the Community Areas dataset, we find that the correlation coefficient is equal to 1, which confirms that AREA_NUMBE and AREA_NUM_1 are the same.

#### New Construction Permits per Year

Combining relevant columns of data from the Community Areas dataset with the Building Permits dataset becomes useful here to attain more insight to communities and what types of permits they have.

In order to map the community names to all of its associated permits, the following code correctly identifies the community name for each permit's community area:

```{r}
communities <- commarea %>% select(COMMUNITY_AREA = AREA_NUMBE, COMMUNITY)
merged <- left_join(permits, communities, by = "COMMUNITY_AREA")
```

Below, every reference to merged is referring to the data frame created using this code snippet.

![New Permits per Year](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/NewPermitsPerYear.png)

As shown in the graph above, the number of new permits per year overall in Chicago has been steadily increasing since 2008, with a large jump from 2007 to 2008.

More specifically, by running the code below, we can see the breakdown by neighborhood / community for New Construction permits over the 14 years.

```{r}
merged %>%
    group_by(COMMUNITY) %>%
    summarize(NUMBER = sum(NEW_CONSTRUCTION)) %>%
    arrange(desc(NUMBER)) %>%
    filter(!is.na(COMMUNITY))
```

By looking at the table created, we can see that the top 5 neighborhoods with the most New Construction permits are as follows:

1. West Town (1,510)
2. Lake View (1,112)
3. Loop (1,075)
4. Near North Side (1,075)
5. Lincoln Park (1,021)

We can also look at the breakdown of Renovation/Alteration and Wrecking/Demolition permits by neighborhood / community over the 14 years by running the following code:

```{r}
merged %>%
    group_by(COMMUNITY) %>%
    summarize(number = sum(RENOVATION_DEMOLITION)) %>%
    arrange(desc(number)) %>%
    as.data.frame() %>%
    filter(!is.na(COMMUNITY))
```

By looking at the table created, we can see that the top 5 neighborhoods with the most Renovation/Alteration and Wrecking/Demolition permits are as follows:

1. Loop (10,613)
2. Near North Side (8,655)
3. West Town (6,003)
4. Near West Side (5,265)
5. Lake View (5,055)