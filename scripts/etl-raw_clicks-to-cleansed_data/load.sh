#!/bin/bash

echo "Load step: 0%..."
hadoop fs -rm /demo/clickstream/weblogs/web-clicks.tsv.gz
echo "Load step: 40%..."
hadoop fs -put web-clicks.tsv.gz /demo/clickstream/weblogs/
echo "Load step: 95%..."

rm -f infile.tsv
rm -f web-clicks.tsv.gz
echo "Load step completed successfully!!"
