# Chicago Building Permits

**Goal –** To better understand which areas in Chicago are experiencing the most change in building permits

## Datasets

Both datasets in the Data folder (Building_Permits.csv and CommAreas.csv) are from the City of Chicago's Data Portal.

### Building Permits

The processing time versus the total fee for a permit may help us compare across neighborhoods to see how potentially wealthier neighborhoods may have less processing times. Looking at the TOTAL_FEE versus the PROCESSING_TIME, COMMUNITY_AREA, and WARD for different permits would be interesting to see how the fees vary for different areas and relative to how long it takes to process the permit. It also seems like it would be interesting to compare how long it takes permits in each community to process and see how different parts of Chicago may have work done quicker than another, if a correlation exists.

The data contains missing values for community area numbers, contact information for contacts 2 through 10, property index numbers, east-west coordinates, and/or north-south coordinates in many permits. It indicates that many permits have only one contact point for the permit and/or have missing information. For all of the building permits with incomplete information, it would be difficult to compare and make generalizations about all building permits in Chicago from 2006 through 2019.


#### PROCESSING_TIME vs TOTAL_FEE

While the numbers still get very large on the y-axis, the graph below represents the permits comparing the processing time to the total fee, except for one outlier, where the total fee seemed extremely high, even for permits with lower processing speeds.

![PROCESSING_TIME vs TOTAL_FEE](https://github.com/choudharynisha/Building-Permits-in-Chicago/blob/master/Graphs/CommunityAreaProcessingTime.png)

### Community Areas

Just looking at the Community Areas dataset, it looks like the two area number columns (AREA_NUMBE and AREA_NUM_1) are the same. To verify, we would have to find the correlation coefficient.

```{r}
cor.test(commarea$AREA_NUMBE, commarea$AREA_NUM_1)
```

By running the line of code above, we find that the correlation coefficient is equal to 1, which confirms that AREA_NUMBE and AREA_NUM_1 are the same.

