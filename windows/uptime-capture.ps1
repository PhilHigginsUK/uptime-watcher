
$lb = Get-WmiObject Win32_OperatingSystem | Select-Object LastBootUpTime
$lbdt = [Management.ManagementDateTimeConverter]::ToDateTime($lb.LastBootUpTime)
$ut = (get-date) - $lbdt
$strString = "{0}" -f $ut.TotalDays

Set-Location \Full\Drive\and\Path\of\the\Folder\You\Deployed\This\Script\to\

rrdtool update uptime.rrd N:$strString
rrdtool graph uptime_24hr.png -a PNG -g --start -1day -v "Days" -l 0 -y 1:1 -X 0 --font TITLE:10:'c:\windows\Fonts\cour.ttf' --font AXIS:8:'c:\windows\Fonts\cour.ttf' --font LEGEND:10:'c:\windows\Fonts\cour.ttf' --font UNIT:8:'c:\windows\Fonts\cour.ttf' 'DEF:uptime=uptime.rrd:Uptime:LAST' 'AREA:uptime#35b73d:Uptime'
rrdtool graph uptime_28days.png -a PNG -g --start -28day -v "Days" -l 0 -y 1:1 -X 0 --font TITLE:10:'c:\windows\Fonts\cour.ttf' --font AXIS:8:'c:\windows\Fonts\cour.ttf' --font LEGEND:10:'c:\windows\Fonts\cour.ttf' --font UNIT:8:'c:\windows\Fonts\cour.ttf' 'DEF:uptime=uptime.rrd:Uptime:LAST' 'AREA:uptime#35b73d:Uptime'
rrdtool graph uptime_12months.png -a PNG -g --start -12month -v "Days" -l 0 -y 1:1 -X 0 --font TITLE:10:'c:\windows\Fonts\cour.ttf' --font AXIS:8:'c:\windows\Fonts\cour.ttf' --font LEGEND:10:'c:\windows\Fonts\cour.ttf' --font UNIT:8:'c:\windows\Fonts\cour.ttf' 'DEF:uptime=uptime.rrd:Uptime:LAST' 'AREA:uptime#35b73d:Uptime'
