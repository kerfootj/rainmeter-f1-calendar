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
  
end 

function Update()

    SKIN:Bang('!SetOption', 'MeterTimes', 'Text', '--\n--\n--\n--\n--' )

    isDSTNum = msIsDST:GetValue() 
    isDST = false

    if (isDSTNum == 0)
    then
        isDST = true
    end

    year = msYear:GetValue()
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

    formatedRaceTime = convertTime(year, raceMonth, raceDay, raceHour, raceMinute, isDST, true)
    formatedQualiTime = convertTime(year, qualiMonth, qualiDay, qualiHour, qualiMinute, false)
    formatedFP3Time = convertTime(year, fp3Month, fp3Day, fp3Hour, fp3Minute, false)
    
    formatedTime = formatedRaceTime .. "\n" .. formatedQualiTime .. "\n" .. formatedFP3Time .. "\n--\n--"
   
    print(formatedRaceTime)
    print(formatedQualiTime)

    SKIN:Bang('!SetOption', 'MeterTimes', 'Text', formatedTime )
    SKIN:Bang('!DisableMeasureGroup', 'times')

    return 0
   
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