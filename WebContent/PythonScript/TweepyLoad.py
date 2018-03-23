#Server for Streaming Tweets
import tweepy
import sys
from tweepy import OAuthHandler
from tweepy import Stream
from tweepy.streaming import StreamListener
import socket
import json
import time

#Please change with your own consumer key, consumer secret, access token and access secret
consumer_key = 'PglM3T2NoBzq0ktWTUBelJTHg'
consumer_secret = 'aDKWrqZQAwje0fJBBVufrxJWE5KY3T8cSlUUGuRyvuvYznGQOC'
access_token = '624310916-N9aUtUrr1BjnNhOPV6vPz0Aty1OZ1utIyF3hm4Cm'
access_secret = 'VyJCNbvceb6RpPXRLVo8e2sysJXwQ59AEc9KAQfQfNRoO'
class TweetsListener(StreamListener):
	def __init__(self,csocket):
		self.client_socket = csocket
		super(TweetsListener, self).__init__()
	def on_data(self, data):
		try:
			msg = json.loads(data)
			#print(msg['text'].encode('utf-8'))
			#Send the tweet through the socket
			self.client_socket.send(msg['text'].encode('utf-8'))
			return True
		except BaseException as e:
			print("Error on_data: %s" %str(e))
			self.client_socket.close()
			return False
	
def sendData(c_socket,args):
	auth = OAuthHandler(consumer_key,consumer_secret)
	auth.set_access_token(access_token,access_secret)
	query=str(args[1]).replace('#','')
	qlist=['default']
	qlist[0] = '#'+query
	twitter_stream = Stream(auth,TweetsListener(c_socket))
	twitter_stream.filter(track=qlist)
if __name__ == "__main__":
	args = sys.argv
	s=socket.socket()
	host=socket.gethostname()
	port=9025
	s.bind((host,port))
	print("Listening on port : %s" % str(port))
	s.listen(1)
	c,addr = s.accept()
	print("Received request from "+str(addr))
	sendData(c,args)
