#!/bin/bash

# Set Git user information (if not set globally)
git config --global user.name "Daniel"
git config --global user.email "Danialgrad2018@gmail.com"



# Define the paths and contents
file_path="Files"
content1="Please Email me to get the files.\nDanialgrad2018@gmail.com"
content2="Please Email me to get the files.\nDanialgrad2018@gmail.com\nOr\ndanielnestle2024@gmail.com"

# Start and end dates for the past year
start_date=$(date -d "1 year ago" +%Y-%m-%d)
end_date=$(date +%Y-%m-%d)

# Loop through each day from start_date to end_date
current_date="$start_date"
while [ "$current_date" != "$(date -d "$end_date + 1 day" +%Y-%m-%d)" ]; do
    day_of_week=$(date -d "$current_date" +%u)
    
    # Check if the day is Monday (1) to Friday (5) or Saturday (6)
    if [ "$day_of_week" -le 5 ] || [ "$day_of_week" -eq 6 ]; then
        num_commits=$((RANDOM % 3 + 2))  # Random number of commits between 2 and 4
        for ((i=1; i<=$num_commits; i++)); do
            if [ $((i % 2)) -eq 1 ]; then
                echo -e "$content1" > "$file_path"
            else
                echo -e "$content2" > "$file_path"
            fi

            # Set environment variables for backdating
            GIT_COMMITTER_DATE="$current_date 12:00:00" git commit --date="$current_date 12:00:00" -m "Automated commit on $current_date - Commit $i"
        done
    fi

    # Move to the next day
    current_date=$(date -d "$current_date + 1 day" +%Y-%m-%d)
done

# Push the changes
git push origin main  # or master, depending on your branch
