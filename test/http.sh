#!/bin/sh

sbprefix="https://"
httplist="list/http.list"
resppage="rcrd/page/resp.page"
timepage="rcrd/page/time.page"
respdrct="rcrd/data/resp"
timedrct="rcrd/data/time"

echo "[$(date +%Y%m%d-%H%M%S%Z)] Starting status checks"

cat $httplist | while read line
do
    filename=${line#"$sbprefix"}
    respfile="$respdrct/$filename.resp"
    timefile="$timedrct/$filename.json"
    echo "[$(date +%Y%m%d-%H%M%S%Z)] Writing response status for $line"
    curl -so /dev/null -Iw "@$resppage" $line > $respfile
    echo "[$(date +%Y%m%d-%H%M%S%Z)] Writing reachability time for $line"
    curl -so /dev/null -Iw "@$timepage" $line > $timefile
done

echo "[$(date +%Y%m%d-%H%M%S%Z)] Concluding status checks"
