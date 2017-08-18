var hour = (argument0 % 720) div 60;
if(hour == 0) hour = 12;
var minute = argument0 % 60;
if(minute < 10) minute = "0" + string(minute);
var timeOfDay;
if(argument0 < 720) timeOfDay = "am";
else timeOfDay = "pm";

return string(hour) + ":" + string(minute) + timeOfDay;
