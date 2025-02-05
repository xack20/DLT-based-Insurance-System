#!/bin/bash
# @Author: Zakaria Hossain Foysal
# @Date:   2024-05-31 17:38:32
# @Last Modified by:   Zakaria Hossain Foysal
# @Last Modified time: 2024-05-31 17:38:55
#!/bin/bash

# Path to the log file
LOG_FILE="logfile.log"

# Maximum log file size in bytes (10MB in this case)
MAX_SIZE=$((10 * 1024 * 1024))

# Check if the log file exists
if [ -f "$LOG_FILE" ]; then
    # Get the current size of the log file
    FILE_SIZE=$(stat -c%s "$LOG_FILE")

    # If the file size exceeds the maximum limit, truncate the log file
    if [ "$FILE_SIZE" -gt "$MAX_SIZE" ]; then
        echo "Log file size exceeds $MAX_SIZE bytes. Truncating log file."
        > "$LOG_FILE"
    fi
fi
