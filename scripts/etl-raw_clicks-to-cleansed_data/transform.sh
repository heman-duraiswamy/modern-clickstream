#!/bin/bash

echo "Transform step: 0%"
INFILE="infile.tsv"
OUTFILE="web-clicks.tsv"
TEMPFILE="clickstream-generation.tmp"
echo "Transform step: 10%..."

grep "|0|0|" $INFILE > $OUTFILE
echo "Transform step: 25%..."

grep "|0|1|" $INFILE >> $OUTFILE
echo "Transform step: 40%..."

grep "|1|0|" $INFILE > $TEMPFILE
cat $TEMPFILE | awk -F "|" '{print $1"|"$2"|"$3"|"$4"|"$1%3%2"|"$6"|"$7"|"$8"|"$9"|"$10'} >> $OUTFILE
echo "Transform step: 70%..."

cat $OUTFILE | sort -n > $TEMPFILE
sed 's#http://www.RL.com##g' $TEMPFILE > $OUTFILE
echo "Transform step: 95%..."

gzip -c $OUTFILE > $OUTFILE.gz
rm -f $TEMPFILE
rm -f $OUTFILE
echo "Transform step completed successfully!!"
