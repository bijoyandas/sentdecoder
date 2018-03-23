#Fetching Tweets... Last 100

import tweepy
import time
import json
import sys
import re
import pickle

from datetime import date,timedelta
from tweepy import OAuthHandler
from textblob import TextBlob

#Please change with your own consumer key, consumer secret, access token and access secret
consumer_key = 'PglM3T2NoBzq0ktWTUBelJTHg'
consumer_secret = 'aDKWrqZQAwje0fJBBVufrxJWE5KY3T8cSlUUGuRyvuvYznGQOC'
access_token = '624310916-N9aUtUrr1BjnNhOPV6vPz0Aty1OZ1utIyF3hm4Cm'
access_secret = 'VyJCNbvceb6RpPXRLVo8e2sysJXwQ59AEc9KAQfQfNRoO'
 
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)
args = sys.argv[1:];
api = tweepy.API(auth,timeout=10)

list_tweets = []

with open("/home/bijoyan/workspace/sentdecoder/WebContent/PythonScript/geomapping.pickle","rb") as f:
    country_map = pickle.load(f)


query = args[0]
if len(args) == 1:
    for status in tweepy.Cursor(api.search,q=query+" -filter:retweets",lang='en',result_type='recent').items(100):
        list_tweets.append(status.text)
if len(args) == 2:
    if args[1].lower() not in country_map.values():
        for status in tweepy.Cursor(api.search, q=query+" "+args[1]+" -filter:retweets",lang='en',result_type='recent').items(100):
            list_tweets.append(status.text)
    else:
        for status in tweepy.Cursor(api.search, q=query+" -filter:retweets",lang='en',result_type='recent',geocode=country_map[args[1].lower()]+",500km"):
            list_tweets.append(status.text)    


for tweet in list_tweets:
    tweet = re.sub(r"^https://t.co/[a-zA-Z0-9]*\s", " ", tweet)
    tweet = re.sub(r"\s+https://t.co/[a-zA-Z0-9]*\s", " ", tweet)
    tweet = re.sub(r"\s+https://t.co/[a-zA-Z0-9]*$", " ", tweet)
    tweet = tweet.lower()
    tweet = re.sub(r"that's","that is",tweet)
    tweet = re.sub(r"there's","there is",tweet)
    tweet = re.sub(r"what's","what is",tweet)
    tweet = re.sub(r"where's","where is",tweet)
    tweet = re.sub(r"it's","it is",tweet)
    tweet = re.sub(r"who's","who is",tweet)
    tweet = re.sub(r"i'm","i am",tweet)
    tweet = re.sub(r"she's","she is",tweet)
    tweet = re.sub(r"he's","he is",tweet)
    tweet = re.sub(r"they're","they are",tweet)
    tweet = re.sub(r"who're","who are",tweet)
    tweet = re.sub(r"ain't","am not",tweet)
    tweet = re.sub(r"wouldn't","would not",tweet)
    tweet = re.sub(r"shouldn't","should not",tweet)
    tweet = re.sub(r"can't","can not",tweet)
    tweet = re.sub(r"couldn't","could not",tweet)
    tweet = re.sub(r"won't","will not",tweet)
    tweet = re.sub(r"\W"," ",tweet)
    tweet = re.sub(r"\d"," ",tweet)
    tweet = re.sub(r"\s+[a-z]\s+"," ",tweet)
    tweet = re.sub(r"\s+[a-z]$"," ",tweet)
    tweet = re.sub(r"^[a-z]\s+"," ",tweet)
    tweet = re.sub(r"\s+"," ",tweet)
    blob = TextBlob(tweet)
    sum=0
    n=0
    for sentence in blob.sentences:
        sum+=sentence.sentiment.polarity
        n+=1
    print((sum/n)*100)
