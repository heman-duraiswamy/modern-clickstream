# modern-clickstream
At a very high level, the following demo walks through a modern clickstream architecture that leverages NiFi for realtime streaming of click data and uses Hadoop+Hive for data processing. It also uses zeppelin as a tool to analyse and refine data.

Below is the flow of the current demo
* A script will push the click data to a TCP port (the script will eventually be replaced with a bunch of webpages, and the java script will be embedded with each button click so as to push the click data to the pre-configured TCP port)
* Nifi's 'ListenTCP' processor will listen to the configured TCP port and pull the click data in real-time
* The flow-file will then go through 2 streams - the first will merge the flow-file content and then write to HDFS in a certain frequency (this will also push to other NoSql / Analytical databases, if the need be); the second stream will be more of a real time decisioning engine, which looks at certain parameters and make a real-time decision - in this example, the processor looks if the click data suggests if the page has been exited by the customer. If exited, then it will FTP the details to the ad provider with needed details, to start promoting a discount/promo code in real-time so as to lure the customer back to making a purchase.
* Once the Nifi lands the click data as a raw data in the HDFS folder, it goes through a series of data transformation and data cleansing
* A Hive external table is built on the cleansed file
* A set of pre-canned queries are provided on Zeppelin. Few of these queries are: Customer single view, Path to purchase, Page abandonment report, Error page report, Gender and age distribution of the visitors
![Alt text](images/ClickStream-Reference-Architecture.jpg?raw=true)

Below is how the files are organized:
* Nifi directory has the nifi template
* Zeppelin directory has the exported notebook pre saved queries such as path to purchase, page abandonment, etc..
* sql directory has all the needed sql queries, as well as hive ddl to create needed tables
* data directory has the needed data. You may be most interested in clickstream-feed-generated.tsv.gz, products.tsv.gz, and users.tsv.gz
* script directory has a main file generate-clickstream-data.sh that generates the clickstream-feed-generated.tsv.gz file from a raw file. The scripts folder also has two sub directories, one will push the click data to a TCP port for the nifi to consume, and other will have some basic transformation scripts that would convert (mimick the conversion) from raw click data to cleansed click data
