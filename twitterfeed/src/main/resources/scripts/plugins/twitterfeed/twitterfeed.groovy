@Grapes(
        @Grab(group='org.twitter4j', module='twitter4j-core', version='4.0.5')
)

import twitter4j.Status
import twitter4j.Twitter
import twitter4j.TwitterException
import twitter4j.TwitterFactory
import twitter4j.Paging
import twitter4j.conf.ConfigurationBuilder

def feedId = contentModel.queryValue("feedId")
def itemsPerPage = contentModel.queryValue("itemsPerPage_i").toInteger()

def consumerKey = siteConfig.getString("twitter.consumerKey")
def consumerSecret = siteConfig.getString("twitter.consumerSecret")
def accessKey = siteConfig.getString("twitter.accessKey")
def accessSecret = siteConfig.getString("twitter.accessSecret")

ConfigurationBuilder cb = new ConfigurationBuilder()

cb.setDebugEnabled(false)
cb.setOAuthConsumerKey(consumerKey)
cb.setOAuthConsumerSecret(consumerSecret)
cb.setOAuthAccessToken(accessKey)
cb.setOAuthAccessTokenSecret(accessSecret)

TwitterFactory tf = new TwitterFactory(cb.build())
Twitter twitter = tf.getInstance()

Paging paging = new Paging(1, itemsPerPage)

List<Status> statuses = twitter.getUserTimeline(feedId, paging)

templateModel.feed = statuses