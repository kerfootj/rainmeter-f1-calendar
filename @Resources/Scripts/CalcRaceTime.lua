function Initialize()

    msIsDST = SKIN:GetMeasure('MeasureIsDST')

    msYear = SKIN:GetMeasure('MeasureRaceYear')
    msRaceMonth = SKIN:GetMeasure('MeasureRaceMonth')
    msRaceDay = SKIN:GetMeasure('MeasureRaceDay')
    msRaceHour = SKIN:GetMeasure('MeasureRaceHour')
    msRaceMinute = SKIN:GetMeasure('MeasureRaceMinute')

    msQualiMonth = SKIN:GetMeasure('MeasureQualiMonth')
    msQualiDay = SKIN:GetMeasure('MeasureQualiDay')
    msQualiHour = SKIN:GetMeasure('MeasureQualiHour')
    msQualiMinute = SKIN:GetMeasure('MeasureQualiMinute')

    msFP3Month = SKIN:GetMeasure('MeasureFP3Month')
    msFP3Day = SKIN:GetMeasure('MeasureFP3Day')
    msFP3Hour = SKIN:GetMeasure('MeasureFP3Hour')
    msFP3Minute = SKIN:GetMeasure('MeasureFP3Minute')

    msFP2Month = SKIN:GetMeasure('MeasureFP2Month')
    msFP2Day = SKIN:GetMeasure('MeasureFP2Day')
    msFP2Hour = SKIN:GetMeasure('MeasureFP2Hour')
    msFP2Minute = SKIN:GetMeasure('MeasureFP2Minute')

    msFP1Month = SKIN:GetMeasure('MeasureFP1Month')
    msFP1Day = SKIN:GetMeasure('MeasureFP1Day')
    msFP1Hour = SKIN:GetMeasure('MeasureFP1Hour')
    msFP1Minute = SKIN:GetMeasure('MeasureFP1Minute')
    
  
end 

function Update()

    SKIN:Bang('!SetOption', 'MeterTimes', 'Text', '--\n--\n--\n--\n--' )

    isDSTNum = msIsDST:GetValue() 
    isDST = true

    if (isDSTNum == 0)
    then
        isDST = false
    end

    year = msYear:GetValue()

    if (year == 0)
    then
        do return end
    end

    raceMonth = msRaceMonth:GetValue()
    raceDay = msRaceDay:GetValue()
    raceHour = msRaceHour:GetValue()
    raceMinute = msRaceMinute:GetValue()

    qualiMonth = msQualiMonth:GetValue()
    qualiDay = msQualiDay:GetValue()
    qualiHour = msQualiHour:GetValue()
    qualiMinute = msQualiMinute:GetValue()

    fp3Month = msFP3Month:GetValue()
    fp3Day = msFP3Day:GetValue()
    fp3Hour = msFP3Hour:GetValue()
    fp3Minute = msFP3Minute:GetValue()

    fp2Month = msFP2Month:GetValue()
    fp2Day = msFP2Day:GetValue()
    fp2Hour = msFP2Hour:GetValue()
    fp2Minute = msFP2Minute:GetValue()

    fp1Month = msFP1Month:GetValue()
    fp1Day = msFP1Day:GetValue()
    fp1Hour = msFP1Hour:GetValue()
    fp1Minute = msFP1Minute:GetValue()

    formatedRaceTime = convertTime(year, raceMonth, raceDay, raceHour, raceMinute, isDST, true)
    formatedQualiTime = convertTime(year, qualiMonth, qualiDay, qualiHour, qualiMinute, isDST, false)
    formatedFP3Time = convertTime(year, fp3Month, fp3Day, fp3Hour, fp3Minute, isDST, false)
    formatedFP2Time = convertTime(year, fp2Month, fp2Day, fp2Hour, fp2Minute, isDST, false)
    formatedFP1Time = convertTime(year, fp1Month, fp1Day, fp1Hour, fp1Minute, isDST, false)

    formatedTime = formatedRaceTime .. "\n" .. formatedQualiTime .. "\n" .. formatedFP3Time .. "\n" .. formatedFP2Time .. "\n" .. formatedFP1Time
   
    SKIN:Bang('!SetOption', 'MeterTimes', 'Text', formatedTime )
    SKIN:Bang('!DisableMeasureGroup', 'times')

    return
   
end

convertTime = function(year, month, day, hour, minute, isDST, isRace)
    timeStamp = os.time({year=year, month=month, day=day, hour=hour, minute=minute, isdst=isDST})
    
    currentLocalTime = os.time()
    currentUTCTime = os.time(os.date('!*t'))
    
    timeOffset = currentLocalTime - currentUTCTime

    adjustedTimeStamp = 0

    if (isRace)
    then
        adjustedTimeStamp = timeStamp + timeOffset + 600
    else
        adjustedTimeStamp = timeStamp + timeOffset
    end

    formatedTime = os.date('%a, %b %d %H:%M', adjustedTimeStamp)

    return formatedTime

end