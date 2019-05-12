#!/bin/bash

cd /Full/Path/of/the/Folder/You/Deployed/it/to/
echo "($(date +%s) - $(date -d "$(uptime -s)" +%s))/(60*60*24)" | bc -l | awk '{printf "%.15f\n", $0}' | (read v; $(rrdtool update uptime.rrd N:$v) )
rrdtool graph /var/www/html/uptime_24hr.png -a PNG -g --start -1day -v 'Days' -l 0 -y 1:1 -X 0 'DEF:uptime=uptime.rrd:Uptime:LAST' 'LINE1:uptime#000000:Uptime'
rrdtool graph /var/www/html/uptime_28days.png -a PNG -g --start -28day -v 'Days' -l 0 -y 1:1 -X 0 'DEF:uptime=uptime.rrd:Uptime:LAST' 'LINE1:uptime#000000:Uptime'
rrdtool graph /var/www/html/uptime_12months.png -a PNG -g --start -12month -v 'Days' -l 0 -y 1:1 -X 0 'DEF:uptime=uptime.rrd:Uptime:LAST' 'LINE1:uptime#000000:Uptime'
