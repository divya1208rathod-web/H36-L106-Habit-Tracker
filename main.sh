
#!/bin/bash

# Habit Tracker - L106

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/functions.sh"
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "--backup" ]]; then
    do_backup
    exit 0
elif [[ "$1" == "--cron" ]]; then
    cron_task
    exit 0
fi

while true
do
    echo ""
    echo "================================"
    echo "       HABIT TRACKER"
    echo "================================"
    echo "1. Mark Today's Habits"
    echo "2. View Habit Data"
    echo "3. Current Streak"
    echo "4. This Week Completion"
    echo "5. Best Habit of Month"
    echo "6. Save Weekly Report"
    echo "7. Backup Data"
    echo "8. View Activity Log"
    echo "0. Exit"
    echo "================================"

    read -rp "Enter your choice: " choice

    case "$choice" in
        1) feature_1 ;;
        2) view_data ;;
        3) feature_2 ;;
        4) feature_3 ;;
        5) feature_4 ;;
        6) feature_5 ;;
        7) do_backup ;;
        8) view_log ;;
        0)
            echo "Thank you for using Habit Tracker!"
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
