#!/bin/bash
start="2026-01-12"
end="2026-04-04"

current="$start"

while [ "$current" != "$(date -I -d "$end + 1 day")" ]
do
  # Random commits per day (1-3)
  commits=$(( (RANDOM % 3) + 1 ))

  for ((i=1; i<=commits; i++))
  do
    time=$(printf "%02d:%02d:00" $((RANDOM % 24)) $((RANDOM % 60)))
    DATE="$current $time"

    echo "Update $DATE" >> log.txt

    GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git add .
    GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit -m "update $DATE"
  done

  current=$(date -I -d "$current + 1 day")
done

git push origin main
