function Initialize()

    msIsDST = SKIN:GetMeasure('MeasureIsDST')
    msRaceYear = SKIN:GetMeasure('MeasureRaceYear')
    msRaceMonth = SKIN:GetMeasure('MeasureRaceMonth')
    msRaceDay = SKIN:GetMeasure('MeasureRaceDay')
    msRaceHour = SKIN:GetMeasure('MeasureRaceHour')
    msRaceMinute = SKIN:GetMeasure('MeasureRaceMinute')
  
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

    formatedTime = converTime(raceYear, raceMonth, raceDay, raceHour, raceMinute, isDST)
    
    return(formatedTime)
   

end

converTime = function(year, month, day, hour, minute, isDST)
    timeStamp = os.time({year=year, month=month, day=day, hour=hour, minute=minute, isdst=isDST})
    
    currentLocalTime = os.time()
    currentUTCTime = os.time(os.date('!*t'))
    
    timeOffset = currentLocalTime - currentUTCTime

    adjustedTimeStamp = timeStamp + timeOffset + 600

    formatedTime = os.date('%a, %b %d %H:%M', adjustedTimeStamp)

    return formatedTime

end