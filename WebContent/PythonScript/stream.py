#Server for Streaming Tweets
import tweepy
import sys
from tweepy import OAuthHandler
from tweepy import Stream
from tweepy.streaming import StreamListener
import json
import time
from textblob import TextBlob
import re

#Please change with your own consumer key, consumer secret, access token and access secret
consumer_key = 'PglM3T2NoBzq0ktWTUBelJTHg'
consumer_secret = 'aDKWrqZQAwje0fJBBVufrxJWE5KY3T8cSlUUGuRyvuvYznGQOC'
access_token = '624310916-N9aUtUrr1BjnNhOPV6vPz0Aty1OZ1utIyF3hm4Cm'
access_secret = 'VyJCNbvceb6RpPXRLVo8e2sysJXwQ59AEc9KAQfQfNRoO'
class TweetsListener(StreamListener):
	def __init__(self):
		super(TweetsListener, self).__init__()
	def on_data(self, data):
		try:
			msg = json.loads(data)
			tweet = str(msg['text'].encode('utf-8'))
			blob = TextBlob(tweet)
			sum=0
			n=0
			for sentence in blob.sentences:
				sum+=sentence.sentiment.polarity
				n+=1
			print((sum/n)*100)			
			return True
		except BaseException as e:
			print("Error on_data: %s" %str(e))
			return False
	
def sendData(args):
	auth = OAuthHandler(consumer_key,consumer_secret)
	auth.set_access_token(access_token,access_secret)
	query=str(args[1]).replace('#','')
	qlist=['default']
	qlist[0] = '#'+query
	twitter_stream = Stream(auth,TweetsListener())
	twitter_stream.filter(track=qlist)
if __name__ == "__main__":
	args = sys.argv
	sendData(args)
