# L106 – Habit Tracker

**Student:** DIVYA RATHOD | **Roll:** H36 | **Division:** H | **Enrollment:** 24004501210356

## Problem
Build a habit tracker that marks habits daily and shows streaks and weekly scores.

## Who will use it
Students building daily routines.

## Folder structure
- `main.sh`: Starts the Habit Tracker menu and handles user choices.
- `lib/functions.sh`: Contains functions for tracking habits, reports, backups, and logs.
- `data/log.csv`: Stores habit records with date, habit name, and completion status.
- `reports/`: Stores generated weekly reports.
- `backups/`: Stores backup archives.
- `logs/activity.log`: Records project activities.
- `logs/cron.log`: Records scheduled cron task activity.
- `README.md`: Contains project information and instructions.
## Features
1. Mark today's habits (Y/N for each in a loop)
2. Show the current streak per habit
3. Show this week's completion %
4. Show the best habit of the month
5. Save a weekly report

## How to run
Open Ubuntu Terminal and run these commands:

cd ~/linux_project/habittrack
bash main.sh

To display help, run:
bash main.sh --help

To create a backup, run:
bash main.sh --backup

## My crontab line and what it means
My crontab line:

0 21 * * * /bin/bash /home/dell/linux_project/habittrack/main.sh --cron

Explanation of the five fields:
1. Minute: 0
2. Hour: 21 (9 PM)
3. Day of month: * (every day)
4. Month: * (every month)
5. Day of week: * (every day of the week)
## Commands I used and why
This task runs daily at 9 PM when WSL is running and cron is active.
- pwd: Display the current directory.
- cd: Change the directory.
- ls: List files and folders.
- cat: Display file contents.
- nano: Edit project files.
- grep: Search for text.
- awk: Process CSV data and calculate statistics.
- tar: Create backups and the final archive.
- crontab -l: Display scheduled cron jobs.
## What I learned
1. I learned basic Linux commands and Bash scripting.
2. I learned how to store daily habits in a CSV file.
3. I learned to calculate habit completion using awk.
4. I learned to create reports and backups using shell commands.
5. I learned to schedule automatic tasks using cron.
