import com.sun.syndication.fetcher.impl.HttpURLFeedFetcher

def url = contentModel.feedUrl


def feed = null
try {
    def fetcher = new HttpURLFeedFetcher()
    feed = fetcher.retrieveFeed(new URL(url))
}
catch(err) {
    logger.error("error getting RSS feed: "+err)
    model.err = err
}


model.feed = feed
model.url= url