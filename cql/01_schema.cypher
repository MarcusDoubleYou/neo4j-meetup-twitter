CREATE CONSTRAINT ON (u:User) assert u.name is  unique

CREATE CONSTRAINT ON (u:User) assert u.twitterName is  unique

CREATE CONSTRAINT ON (n:Tweet) assert n.tweetId is  unique