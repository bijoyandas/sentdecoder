#Client for Streaming Tweets
import socket
import string
from textblob import TextBlob
from pyspark import SparkConf,SparkContext
from pyspark.streaming import StreamingContext
sc=SparkContext(conf=SparkConf().setAppName("Stream Tweets"))
sc.setLogLevel('ERROR')
ssc=StreamingContext(sc,14)

def mymap(line):
	for char in string.punctuation:
		line = line.replace(char,' ')
	blob = TextBlob(line)
	sum=0
	n=0
	for sentence in blob.sentences:
		sum+=sentence.sentiment.polarity
		n+=1
	if (n>0):
		return (sum/n)*100
	else:
		return 0

def myprint(rdd):
	for emotion in rdd.collect():
		print(emotion)	

tweetstream=ssc.socketTextStream(socket.gethostname(),9025)
tweetstream = tweetstream.map(mymap)
tweetstream.foreachRDD(lambda rdd:myprint(rdd))
ssc.start()
ssc.awaitTermination()
