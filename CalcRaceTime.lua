function Initialize()

    msIsDST = SKIN:GetMeasure('MeasureIsDST')

    msRaceYear = SKIN:GetMeasure('MeasureRaceYear')
    msRaceMonth = SKIN:GetMeasure('MeasureRaceMonth')
    msRaceDay = SKIN:GetMeasure('MeasureRaceDay')
    msRaceHour = SKIN:GetMeasure('MeasureRaceHour')
    msRaceMinute = SKIN:GetMeasure('MeasureRaceMinute')

    msQualiYear = SKIN:GetMeasure('MeasureQualiYear')
    msQualiMonth = SKIN:GetMeasure('MeasureQualiMonth')
    msQualiDay = SKIN:GetMeasure('MeasureQualiDay')
    msQualiHour = SKIN:GetMeasure('MeasureQualiHour')
    msQualiMinute = SKIN:GetMeasure('MeasureQualiMinute')
  
end 

function Update()

    isDSTNum = msIsDST:GetValue() 
    isDST = false

    if (isDSTNum == 0)
    then
        isDST = true
    end

    raceYear = msRaceYear:GetValue()
    raceMonth = msRaceMonth:GetValue()
    raceDay = msRaceDay:GetValue()
    raceHour = msRaceHour:GetValue()
    raceMinute = msRaceMinute:GetValue()

    qualiYear = msQualiYear:GetValue()
    qualiMonth = msQualiMonth:GetValue()
    qualiDay = msQualiDay:GetValue()
    qualiHour = msQualiHour:GetValue()
    qualiMinute = msQualiMinute:GetValue()

    formatedRaceTime = convertTime(raceYear, raceMonth, raceDay, raceHour, raceMinute, isDST, true)

    formatedQualiTime = convertTime(qualiYear, qualiMonth, qualiDay, qualiHour, qualiMinute, false)
    
    print(formatedRaceTime)
    print(formatedQualiTime)

    formatedTime = formatedRaceTime .. "\n" .. formatedQualiTime

    return formatedTime
   

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