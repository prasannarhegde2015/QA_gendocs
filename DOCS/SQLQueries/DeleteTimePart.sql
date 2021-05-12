Select wdaEndDate , wdaFK_Well, wdaOilRateAllocated , wdaOilMeasuredRate from WellDailyAverage
WHERE CONVERT(VARCHAR, CAST(wdaEndDate AS TIME), 0) = '1:29AM'
