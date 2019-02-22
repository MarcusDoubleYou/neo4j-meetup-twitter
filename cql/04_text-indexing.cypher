// good reference https://graphaware.com/neo4j/2019/01/11/neo4j-full-text-search-deep-dive.html
// input name of index, label, property
CALL db.index.fulltext.createNodeIndex('tweet', ['Tweet'], ['text'])

CALL db.index.fulltext.queryNodes('tweet', 'winner') YIELD node AS tweet
MATCH (tweet)--(u:User)
RETURN tweet.text, u

// with hash tag
CALL db.index.fulltext.queryNodes('tweet', 'winner') YIELD node AS tweet
MATCH (h:Hashtag)--(tweet)--(u:User)
RETURN tweet.text, h.name, u