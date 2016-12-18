import groovy.util.XmlSlurper

def url = contentModel.queryValue("feedUrl")
def rssFeed = url.toURL().text


def xmlSlurper = new XmlSlurper()
def rss = xmlSlurper.parseText(rssFeed)

def feed = []

rss.channel.item.each{ item ->
    def entry = [:]
    entry.title = item.title
    entry.description = item.description
    entry.link = item.link
    entry.pubDate = item.pubDate

    feed.add(entry)
}

templateModel.feed = feed
