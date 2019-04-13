function Initialize()
  
    msQualiYear = SKIN:GetMeasure('MeasureQualiYear')
    msQualiMonth = SKIN:GetMeasure('MeasureQualiMonth')
    msQualiDay = SKIN:GetMeasure('MeasureQualiDay')
    msQualiHour = SKIN:GetMeasure('MeasureQualiHour')
    msQualiMinute = SKIN:GetMeasure('MeasureQualiMinute')
end 

function Update()

    qualiYear = msQualiYear:GetValue()
    qualiMonth = msQualiMonth:GetValue()
    qualiDay = msQualiDay:GetValue()
    qualiHour = msQualiHour:GetValue()
    qualiMinute = msQualiMinute:GetValue()

    formatedTime = converTime(qualiYear, qualiMonth, qualiDay, qualiHour, qualiMinute)
    
    return(formatedTime)
   

end

converTime = function(year, month, day, hour, minute)
    timeStamp = os.time({year=year, month=month, day=day, hour=hour, minute=minute, isdst=false})
    
    currentLocalTime = os.time()
    currentUTCTime = os.time(os.date('!*t'))
    
    timeOffset = currentLocalTime - currentUTCTime

    adjustedTimeStamp = timeStamp + timeOffset

    formatedTime = os.date('%a, %b %d %H:%M', adjustedTimeStamp)

    return formatedTime

end