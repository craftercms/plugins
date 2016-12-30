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
def authenticationDescriptorId = contentModel.queryValue("authentication/item/key")

if(authenticationDescriptorId) {
    def authDescriptor = siteItemService.getSiteItem(authenticationDescriptorId)

    if(authDescriptor) {

        try {
            def consumerKey = authDescriptor.queryValue("consumerKey")
            def consumerSecret = authDescriptor.queryValue("consumerSecret")
            def accessKey = authDescriptor.queryValue("accessKey")
            def accessSecret = authDescriptor.queryValue("accessSecret")

            ConfigurationBuilder cb = new ConfigurationBuilder()

            cb.setDebugEnabled(false)
            cb.setOAuthConsumerKey(consumerKey)
            cb.setOAuthConsumerSecret(consumerSecret)
            cb.setOAuthAccessToken(accessKey)
            cb.setOAuthAccessTokenSecret(accessSecret)

            //logger.info("[${consumerKey}] [${consumerSecret}] [${accessKey}] [${accessSecret}] ")

            TwitterFactory tf = new TwitterFactory(cb.build())
            Twitter twitter = tf.getInstance()

            Paging paging = new Paging(1, itemsPerPage)

            List<Status> statuses = twitter.getUserTimeline(feedId, paging)
            templateModel.feed = (statuses) ? statuses : []
        }
        catch(err) {
            templateModel.errorMessage = "Unabled to retrieve feed "
            logger.error("Feed retrieval failed: ", err)
        }
    }
    else {
        templateModel.errorMessage = "Unabled to retrieve feed "
        logger.error("Feed retrieval failed, unable to load auth item (${authenticationDescriptorId})")
    }
}
else {
    templateModel.errorMessage = "Please configure authentication for feed."
}