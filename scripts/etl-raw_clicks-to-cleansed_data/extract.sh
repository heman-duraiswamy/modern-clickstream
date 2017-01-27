#!/bin/bash

echo "Extract step: 0%..."
hadoop fs -get /demo/clickstream/rawclicks/clickstream-feed-generated.tsv.gz infile.tsv.gz
echo "Extract step: 90%..."
gzip -d infile.tsv.gz

echo "Extract step completed successfully!!"
