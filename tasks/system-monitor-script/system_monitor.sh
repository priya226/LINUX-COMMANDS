#!/bin/bash

# Define the log file
LOG_FILE="/var/log/system_monitor.log"

# Function to log messages
log() {
    local message=$1
    echo "$message - $(date +%T)" >> $LOG_FILE
}

# Function to get CPU usage
get_cpu_usage() {
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
}

# Function to get memory usage
get_memory_usage() {
    free | grep Mem | awk '{print $3/$2 * 100.0"%"}'
}

# Function to get disk usage
get_disk_usage() {
    df -h | grep '/dev/sda1' | awk '{print $5}'
}

# Main monitoring function
monitor_system() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local cpu_usage=$(get_cpu_usage)
    local memory_usage=$(get_memory_usage)
    local disk_usage=$(get_disk_usage)

    log "CPU: $cpu_usage, Memory: $memory_usage, Disk: $disk_usage"
    echo "$timestamp - CPU: $cpu_usage, Memory: $memory_usage, Disk: $disk_usage"
}

# Run the monitoring function
monitor_system

# Optional: Set up a cron job to run this script every 5 minutes
#Open the crontab file: crontab -e
#Add the following line to run the script every 5 minutes:
# */5 * * * * /path/to/this/script.sh


: <<EOF
     Logging Function: The script logs messages to /var/log/system_monitor.log with timestamps.
     Resource Monitoring Functions:
     CPU Usage: Uses top and awk to calculate CPU usage.
    Memory Usage: Uses free and awk to calculate memory usage.
     Disk Usage: Uses df and awk to get disk usage.
      Main Monitoring Function: Calls the resource functions and logs the results.
      
    Setup
      Make the script executable:
       bash
          chmod +x system_monitor.sh
     Run the script:
      bash
         ./system_monitor.sh
    Troubleshooting
       Permission Denied: If you get a "Permission Denied" error, ensure you've made the script executable with chmod +x.
       Script Not Found: If you get a "Script Not Found" error, ensure you're in the correct directory or specify the full path to the script.
EOF






