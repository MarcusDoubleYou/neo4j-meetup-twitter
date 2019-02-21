// get top hash tags
MATCH (n:Hashtag)<-[tr:TAGS]-(t:Tweet)
WITH DISTINCT (n), count(tr) AS taged
RETURN n, taged
  ORDER BY taged DESC
  LIMIT 25

// explore hashtags
MATCH (n:Hashtag {name: 'M53'})<-[tr:TAGS]-(t:Tweet)<-[:TWEETED]-(u:User)
WITH DISTINCT (u), count(tr) AS tags
RETURN u, tags

// explore hashtags
MATCH (n:Hashtag {name: 'M53'})<-[tr:TAGS]-(t:Tweet)<-[:TWEETED]-(u:User)
RETURN u, t, n

// get most influential people
MATCH (t:Tweet)<-[:TWEETED]-(u:User)
WITH DISTINCT (u), sum(toInt(coalesce(t.favoriteCount, 0))) AS liked
RETURN u, liked
  LIMIT 10

// top trending hashtags
MATCH (t:Tweet)--(tag:Hashtag)
WITH DISTINCT (tag), sum(toInt(coalesce(t.favoriteCount, 0))) AS liked
RETURN tag, liked
  ORDER BY liked DESC
  LIMIT 10


// get most influential people and their most popular hashtags
MATCH (t:Tweet)<-[:TWEETED]-(u:User)
WITH DISTINCT (u), sum(toInt(coalesce(t.favoriteCount, 0))) AS liked
WITH u, liked
  ORDER BY liked DESC
  LIMIT 10
MATCH (tag:Hashtag)<-[tr:TAGS]-(t:Tweet)<-[:TWEETED]-(u)
WITH DISTINCT (u), count(tr) AS taged, tag, liked
RETURN u, tag, taged, liked
  ORDER BY taged DESC
  LIMIT 25


// only works with movie graph
MATCH (t:Tweet)<-[:TWEETED]-(u:Actor)
WITH DISTINCT (u), sum(toInt(coalesce(t.favoriteCount, 0))) AS liked
MATCH (u)--(m:Movie)
RETURN u, m.title
  LIMIT 25