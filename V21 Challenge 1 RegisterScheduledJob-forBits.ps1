$trigger = New-JobTrigger -Once -At (get-date) -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration (New-Timespan -Days 30)
Register-ScheduledJob -Name BITS -FilePath "C:\Users\ayman\Dropbox\Variiance\PS\PS Par3\LabFiles.\Check-Service.ps1" -Trigger $trigger