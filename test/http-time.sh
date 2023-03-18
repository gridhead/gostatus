#!/bin/sh

sbprefix="https://"
httplist="list/http.list"
timepage="rcrd/page/time.page"
timedrct="/var/tmp/time"

echo "[$(date +%Y%m%d-%H%M%S%Z)] Starting status checks"
mkdir $timedrct

cat $httplist | while read line
do
    filename=${line#"$sbprefix"}
    timefile="$timedrct/$filename.json"
    echo "[$(date +%Y%m%d-%H%M%S%Z)] Writing reachability time for $line"
    curl -so /dev/null -Iw "@$timepage" $line > $timefile
done

echo "[$(date +%Y%m%d-%H%M%S%Z)] Concluding status checks"
