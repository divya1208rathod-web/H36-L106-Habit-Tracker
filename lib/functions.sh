
#!/bin/bash

LOG_FILE="$SCRIPT_DIR/data/log.csv"
LOG_DIR="$SCRIPT_DIR/logs"

log() {
    mkdir -p "$LOG_DIR"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_DIR/activity.log"
}

check_data() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "Error: log.csv not found!"
        return 1
    fi
    return 0
}

show_help() {
    echo "Habit Tracker Help"
    echo "Run: bash main.sh"
    echo "Options: --help, --backup, --cron"
}

view_data() {
    check_data || return
    echo "Date, Habit, Done"
    column -s, -t "$LOG_FILE" 2>/dev/null || cat "$LOG_FILE"
}

feature_1() {
    check_data || return
    local today habit answer
    today=$(date '+%Y-%m-%d')

    echo "Enter habit names one by one."
    echo "Type 'done' when finished."

    while true; do
        read -rp "Habit name: " habit
        [[ "$habit" == "done" ]] && break
        [[ -z "$habit" ]] && continue

        while true; do
            read -rp "Did you complete '$habit'? (Y/N): " answer
            answer=${answer^^}
            [[ "$answer" == "Y" || "$answer" == "N" ]] && break
            echo "Please enter Y or N."
        done

        echo "$today,$habit,$answer" >> "$LOG_FILE"
        log "Marked $habit as $answer"
        echo "Saved: $habit = $answer"
    done
}

feature_2() {
    check_data || return
    read -rp "Enter habit name: " habit
    awk -F, -v h="$habit" '
        NR>1 && $2==h {
            if ($3=="Y") streak++; else streak=0
        }
        END { print "Current streak:", streak+0 }
    ' "$LOG_FILE"
}


feature_3() {
    check_data || return

    local start_date end_date
    start_date=$(date -d "monday this week" '+%Y-%m-%d')
    end_date=$(date -d "sunday this week" '+%Y-%m-%d')

    awk -F, -v start="$start_date" -v end="$end_date" '
        NR > 1 && $1 >= start && $1 <= end {
            total++
            if ($3 == "Y") done++
        }
        END {
            if (total > 0)
                printf "This week completion: %.2f%% (%d/%d completed)\n", done*100/total, done, total
            else
                print "No entries found for this week."
        }
    ' "$LOG_FILE"
}


feature_4() {
    check_data || return

    local month
    month=$(date '+%Y-%m')

    awk -F, -v month="$month" '
        NR > 1 && substr($1, 1, 7) == month && $3 == "Y" {
            count[$2]++
        }
        END {
            for (h in count) {
                if (count[h] > best) {
                    best = count[h]
                    name = h
                }
            }
            if (best > 0)
                print "Best habit this month:", name, "-", best, "completed"
            else
                print "No completed habits found this month."
        }
    ' "$LOG_FILE"
}

feature_5() {
    check_data || return
    mkdir -p "$SCRIPT_DIR/reports"
    report="$SCRIPT_DIR/reports/weekly_report_$(date +%Y%m%d).txt"
    {
        echo "Weekly Habit Tracker Report"
        echo "Generated: $(date)"
        echo
        cat "$LOG_FILE"
    } > "$report"
    echo "Report saved to: $report"
    log "Weekly report saved"
}

do_backup() {
    mkdir -p "$SCRIPT_DIR/backups"
    archive="$SCRIPT_DIR/backups/habittrack_$(date +%Y%m%d_%H%M%S).tar.gz"
    tar -czf "$archive" -C "$SCRIPT_DIR" data logs reports
    echo "Backup saved: $archive"
    log "Backup created"
}

view_log() {
    if [[ -f "$LOG_DIR/activity.log" ]]; then
        cat "$LOG_DIR/activity.log"
    else
        echo "No activity log yet."
    fi
}

cron_task() {
    mkdir -p "$SCRIPT_DIR/logs"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - mark your habits" >> "$SCRIPT_DIR/logs/cron.log"
}
