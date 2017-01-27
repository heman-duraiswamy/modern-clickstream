#!/bin/bash

rm clickstream-feed-generated.tsv

filename="filtered-omniture-raw.tsv"
x=0
y=`cat $filename | wc -l`

while IFS= read -r line; do
    shopflag=0
    errorflag=0

    val1=`echo $line | awk -F "|" '{print $1}'`
    val2=`echo $line | awk -F "|" '{print $3}'`
    val3=`echo $line | awk -F "|" '{print $4}'`
    val4=`gshuf -i 1-10 -n 1`
    randNum=$((val2/val1*val4 + val3/val1*val4*val4))

    pageId=$(($((randNum % 31)) + 1))
    if [ $pageId -eq 1 ]; then
        url="http://www.RL.com/video/1001"
    elif [ $pageId -eq 2 ]; then
        url="http://www.RL.com/video/1002"
    elif [ $pageId -eq 3 ]; then
        url="http://www.RL.com/video/1003"
    elif [ $pageId -eq 4 ]; then
        url="http://www.RL.com/reco/2001"
    elif [ $pageId -eq 5 ]; then
        url="http://www.RL.com/reco/2002"
    elif [ $pageId -eq 6 ]; then
        url="http://www.RL.com/review/3001"
    elif [ $pageId -eq 7 ]; then
        url="http://www.RL.com/review/3002"
    elif [ $pageId -eq 8 ]; then
        url="http://www.RL.com/review/3003"
    elif [ $pageId -eq 9 ]; then
        url="http://www.RL.com/review/3004"
    elif [ $pageId -eq 10 ]; then
        url="http://www.RL.com/review/3005"
    elif [ $pageId -eq 11 -o $pageId -eq 21 ]; then
        url="http://www.RL.com/product/4001"
        shopflag=1
    elif [ $pageId -eq 12 -o $pageId -eq 22 ]; then
        url="http://www.RL.com/product/4002"
        shopflag=1
    elif [ $pageId -eq 13 -o $pageId -eq 23 ]; then
        url="http://www.RL.com/product/4003"
        shopflag=1
    elif [ $pageId -eq 14 -o $pageId -eq 24 ]; then
        url="http://www.RL.com/product/4004"
        shopflag=1
        errorflag=1
    elif [ $pageId -eq 15 -o $pageId -eq 25 ]; then
        url="http://www.RL.com/product/4005"
        shopflag=1
    else
        url="http://www.RL.com/"
    fi

    if [ $shopflag -eq 1 -a $((randNum % 4)) -eq 1 ]; then
        isPurchased=1
    else
        isPurchased=0
    fi

    if [ $errorflag -eq 1 -a $isPurchased -eq 0 -a $((randNum % 3)) -eq 1 ]; then
        isError=1
    else
        isError=0
    fi

    print1=`echo $line | awk -F "|" '{print $1"|"$2"|"$5}'`
    print2=`echo $line | awk -F "|" '{print $7"|"$8"|"$9"|"$10}'`
    echo $print1"|"$url"|"$isPurchased"|"$isError"|"$print2  >> clickstream-feed-generated.tsv

    x=$((x+1))
    echo "processing line "$x" of "$y"..."
    sleep 0.05

done < "$filename"

