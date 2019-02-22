// optional twitter data can be combined with movie sample graph in neo4j browser
// when used with the sample movie graph in the neo4j browser
MATCH (p:Person)
SET p:User
SET p:Actor
REMOVE p:Person

// explore data
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/mbejda/9c3353780270e7298763/raw/1bfc4810db4240d85947e6aef85fcae71f475493/Top-1000-Celebrity-Twitter-Accounts.csv'
AS l
RETURN l
  LIMIT 10

// create all actors and twitter
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/mbejda/9c3353780270e7298763/raw/1bfc4810db4240d85947e6aef85fcae71f475493/Top-1000-Celebrity-Twitter-Accounts.csv'
AS l
MERGE (u:User {name: l.name})
SET u.twitterName = l.twitter


LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/MarcusDoubleYou/neo4j-meetup-twitter/master/data/tweets-sample.csv'
AS l
MATCH (u:User {twitterName: l.user})
MERGE (t:Tweet {tweetId: l.id})<-[:TWEETED]-(u)
SET t.text = l.text, t.favoriteCount = coalesce(l.favorite_count, 0), t.retweeted = l.retweeted,
t.created_at_sec = l.created_at_in_seconds

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/MarcusDoubleYou/neo4j-meetup-twitter/master/data/tweets-sample.csv'
AS l
WITH l
  WHERE l.hashtags IS NOT NULL
WITH split(l.hashtags, '||') AS tags, l.id AS tweetId
UNWIND tags AS t
MATCH (tweet:Tweet {tweetId: tweetId})
MERGE (tag:Hashtag {name: t})
MERGE (tag)<-[:TAGS]-(tweet)








