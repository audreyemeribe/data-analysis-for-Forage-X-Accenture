/* Analysis to find Social Buzz's top 5 most popular categories of content */
/* Do data cleaning and join tables to obtain relevant information needed for the analysis */

/* Start by joining the user and location tables on the key 'User_ID' to identify user location */
DROP TABLE IF EXISTS users;
CREATE TABLE users AS
SELECT user.MyUnknownColumn, user.User_ID, user.Email, user.Name, location.Address
FROM user
INNER JOIN location ON location.User_ID = user.User_ID;

/* Joining the users and session tables on the key 'User_ID' to identify time spent on contents */
DROP TABLE IF EXISTS user_session;
CREATE TABLE user_session AS
SELECT users.MyUnknownColumn, users.User_ID, users.Email, users.Name, users.Address, session.Device, session.Duration
FROM users
INNER JOIN session ON session.User_ID = users.User_ID;

/* Join the reactions and reaction_types tables on the key 'Type' to identify types of user reaction */
DROP TABLE IF EXISTS reactions_type;
CREATE TABLE reactions_type AS
SELECT reactions.MyUnknownColumn, 
       reactions.User_ID,
       reactions.Content_ID, 
       reactions.Datetime, 
       reactions.Type,
	   reaction_types.Sentiment,
       reaction_types.Score
FROM reactions
INNER JOIN reaction_types ON reactions.Type = reaction_types.Type;

/* Join the reactions_type and content tables on the key 'Content_ID' to identify user reactions to different contents */
DROP TABLE IF EXISTS content_reactions;
CREATE TABLE content_reactions AS
SELECT reactions_type.MyUnknownColumn, 
       reactions_type.User_ID,
       reactions_type.Content_ID, 
       reactions_type.Datetime, 
       reactions_type.Type AS reaction,
	   reactions_type.Sentiment,
       reactions_type.Score,
       content.Type AS content_type,
       content.Category 
FROM reactions_type
INNER JOIN content ON reactions_type.Content_ID = content.Content_ID;

/* Join the content_reactions and users tables on the key 'User_ID' to identify user name, location and reactions to different contents */
DROP TABLE IF EXISTS social;
CREATE TABLE social AS
SELECT content_reactions.MyUnknownColumn,
       user_session.Name,
       user_session.Address,
       user_session.Email,
       content_reactions.Content_ID, 
       content_reactions.content_type,
       content_reactions.Category,
       user_session.Device,
       user_session.Duration,
       content_reactions.Datetime, 
       content_reactions.reaction,
	   content_reactions.Sentiment,
       content_reactions.Score
FROM content_reactions
INNER JOIN user_session ON user_session.User_ID = content_reactions.User_ID;









