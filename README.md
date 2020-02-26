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

The outlier was a New Construction permit that, according to the data, had $2,814,056 in total fees (with a $2,750,554 subtotal waived).

#### COMMUNITY_AREA vs TOTAL_FEE

When comparing the different community areas to the total fees of each permit, the graph seems to show that some community areas tend to have higher total fees than others, but as shown in the graph below, it is still pretty scattered, there is not much correlation between the community area and the total fee.

![COMMUNITY_AREA vs TOTAL_FEE](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/CommunityAreaTotalFee.png)

#### COMMUNITY_AREA vs PROCESSING_TIME

When comparing the different community areas to the processing time, it seems like different communities have different ranges in processing times, but there does not appear to be a very strong correlation between which neighborhoods tend to have lower (or higher) processing times than others.

![COMMUNITY_AREA vs PROCESSING_TIME](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/CommunityAreaProcessingTime.png)

### Community Areas

Just looking at the Community Areas dataset, it looks like the two area number columns (AREA_NUMBE and AREA_NUM_1) are the same. To verify, we would have to find the correlation coefficient.

```{r}
cor.test(commarea$AREA_NUMBE, commarea$AREA_NUM_1)
```

By running the line of code above, we find that the correlation coefficient is equal to 1, which confirms that AREA_NUMBE and AREA_NUM_1 are the same.

#### New Construction Permits per Year

![New Construction Permits per Year](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/NewPermitsPerYear.png)