# uptime-watcher

This was a simple project I set for myself to use scheduled tasks on Windows and Linux PCs to capture the up-time of the PC every 5 minutes.  This is a pre-cursor for some data capture electronics projects I have in mind.

It uses RRDTool to capture 1 year of data at a granularity of 5 minutes and generate 3 graphs, one showing the most recent 24 hours of uptime, one showing the most recent month and one showing the whole year. 

#### installation

Here are the steps to install it on Windows or Linux:

1. Install rrdtool on your system.
   1. On linux, use `sudo apt-get install librrds-perl rrdtool`
   2. On Windows, download the "Cygwin Windows" binary distribution linked on the [RRDtool download page](https://oss.oetiker.ch/rrdtool/download.en.html). Put it in a folder that is on your `path`.
2. Determine how you want to present the `index.html` and `styles.css` file.  On Linux, I've used apache so I deployed them to the `/var/www/html/` .  On Windows, I just open them from disk in the folder that I deployed the `uptime-capture.ps1` script file to.
3. Copy the `uptime-capture` script file from the Windows or Linux folder into a folder on your system.  Edit the it to ensure that the paths are correct.  Copy the `index.html` file and `styles.css` file to where you want the graphs to be served.  The important paths to change in the `uptime-capture` script are:
   1. The path that the script changes to before invoking the rrdtool calls (the `cd` command in the Linux `.sh` file and the `Set-Location` command in the windows `ps1` file) 
   2. The location that the `PNG` files are written to in the `rrdtool graph` commands.  It should be the same location as you deployed the `index.html` and `styles.css` files to.
4. Create the RRD database file in the same folder as the `uptime-capture` script file with the following command:
   `rrdtool create uptime.rrd --start N --step 300 DS:Uptime:GAUGE:600:0:U RRA:LAST:0.5:1:105120`
5. Setup scheduled execution of the uptime-capture script:
   1. On Linux, setup a system `cron` job with the following specification:
      `*/5 * * * * root /Full/Path/of/the/Folder/You/Deployed/it/to/uptime-capture.sh`
   2. On Windows, run Task Scheduler and create a basic task that starts one time and runs every 5 minutes indefinitely.  The action should be `powershell` with parameters of `-file "/Full/Path/of/the/Folder/You/Deployed/it/to/uptime-capture.ps1"`

When everything is setup and running, you should see the time-stamp of `uptime.rrd` and the three graph `PNG` file change every 5 minutes.  You should also be able to view index.html and see your up-time history for up to the past year.

