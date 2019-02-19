// get top hash tags
MATCH (n:Hashtag)<-[tr:TAGS]-(t:Tweet)
WITH DISTINCT (n), count(tr) AS taged
RETURN n, taged
  ORDER BY taged DESC
  LIMIT 25


MATCH (n:Hashtag {name: 'M53'})<-[tr:TAGS]-(t:Tweet)
RETURN n, t

MATCH (n:Hashtag {name: 'M53'})<-[tr:TAGS]-(t:Tweet)--(u:User)
WITH DISTINCT (u), count(tr) AS tags
RETURN u, tags


// user with most hashtags
MATCH (n:Hashtag)<-[tr:TAGS]-(t:Tweet)<-[:TWEETED]-(u:User)
WITH DISTINCT (u), count(tr) AS taged
RETURN u, taged
  ORDER BY taged DESC
  LIMIT 25


// get most influential people
MATCH (t:Tweet)<-[:TWEETED]-(u:User)
WITH DISTINCT (u), sum(toInt(coalesce(t.favoriteCount, 0))) AS liked
RETURN u, liked
  LIMIT 10

// user with most hashtags
MATCH (t:Tweet)--(tag:Hashtag)
WITH DISTINCT (tag), sum(toInt(coalesce(t.favoriteCount, 0))) AS liked
RETURN tag, liked
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