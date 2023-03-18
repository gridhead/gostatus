#!/bin/sh

sbprefix="https://"
httplist="list/http.list"
resppage="rcrd/page/resp.page"
respdrct="/var/tmp/resp"

echo "[$(date +%Y%m%d-%H%M%S%Z)] Starting status checks"
mkdir $respdrct

cat $httplist | while read line
do
    filename=${line#"$sbprefix"}
    respfile="$respdrct/$filename.resp"
    echo "[$(date +%Y%m%d-%H%M%S%Z)] Writing response code for $line"
    curl -so /dev/null -Iw "@$resppage" $line > $respfile
done

echo "[$(date +%Y%m%d-%H%M%S%Z)] Concluding status checks"
