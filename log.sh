#!/bin/bash

# Use LOG_AUX_FOLDER_PATH if set, otherwise use default path
LOG_DIR="${LOG_AUX_FOLDER_PATH:-$HOME/.aux/log}"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to handle commands
handle_command() {
    local command="$1"
    case "$command" in
        "today"|"day")
            current_date=$(date '+%m-%Y-%d')
            log_file="$LOG_DIR/log-${current_date}.md"
            if [ -f "$log_file" ]; then
                cat "$log_file"
            else
                echo "No log file exists for today"
            fi
            ;;
        "yesterday")
            yesterday_date=$(date -d "yesterday" '+%m-%Y-%d')
            log_file="$LOG_DIR/log-${yesterday_date}.md"
            if [ -f "$log_file" ]; then
                cat "$log_file"
            else
                echo "No log file exists for yesterday"
            fi
            ;;
        "summary")
            current_date=$(date '+%m-%Y-%d')
            log_file="$LOG_DIR/log-${current_date}.md"
            if [ -f "$log_file" ]; then
                log_content=$(cat "$log_file")
                echo "Generating summary of today's log..."
                summary=$(ollama run mistral "Summarize the following log entries in bullet points: $log_content")
                echo -e "\nSummary of today's log:"
                echo "$summary"
                
                # Append the summary to the log file
                echo -e "\n## Summary at $(date '+%Y-%m-%d %H:%M:%S')\n**Summary:**\n$summary" >> "$log_file"
                echo "Summary has been added to $log_file"
            else
                echo "No log file exists for today"
            fi
            ;;
        "tasks")
            current_date=$(date '+%m-%Y-%d')
            log_file="$LOG_DIR/log-${current_date}.md"
            if [ -f "$log_file" ]; then
                log_content=$(cat "$log_file")
                echo "Analyzing today's log for tasks..."
                tasks=$(ollama run mistral "Read through this log and extract any tasks or todo items. Format them as a bullet point list. If no tasks are found, say 'No tasks found.' Here's the log: $log_content")
                echo -e "\nTasks found in today's log:"
                echo "$tasks"
            else
                echo "No log file exists for today"
            fi
            ;;
        "help")
            echo "Available commands:"
            echo "  help          - Show this help message"
            echo "  today/day     - Display today's log entries"
            echo "  yesterday     - Display yesterday's log entries"
            echo "  tasks         - Extract and list tasks from today's log"
            echo "  summary       - Generate a summary of today's log"
            echo "  [any text]    - Create a new log entry with the text"
            ;;
        *)
            return 1
            ;;
    esac
    return 0
}

# Check if argument is provided
if [ $# -gt 0 ]; then
    if handle_command "$1"; then
        exit 0
    fi
    # If command not recognized, use it as log entry
    user_input="$*"
else
    # Ask for user input if no arguments provided
    echo "log $(date '+%m-%Y-%d') waiting for input:"
    read user_input

    # Handle interactive commands
    if handle_command "$user_input"; then
        exit 0
    fi
fi

# Process log entry
date_format=$(date '+%m-%Y-%d')
filename="$LOG_DIR/log-${date_format}.md"

# Create or append to the log file
echo -e "\n## Entry at $(date '+%Y-%m-%d %H:%M:%S')\n$user_input" >> "$filename"

echo "Log entry has been saved to $filename" 