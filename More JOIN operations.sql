//Table: movie : id	title	yr	director	budget	gross
//Table: actor : id	name
//Table: casting : movieid	actorid	ord

//1.List the films where the yr is 1962 [Show id, title]
Select id, title
FROM movie
WHERE yr = 1962

//2.When was Citizen Kane released?
Select yr
FROM movie
WHERE title = 'Citizen Kane'

//3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
Select id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr

//4.
What id number does the actor 'Glenn Close' have?
Select id
FROM actor
WHERE name = 'Glenn Close'

//5.
What is the id of the film 'Casablanca'
Select id
FROM movie
WHERE title= 'Casablanca'

//6.
Obtain the cast list for 'Casablanca'.
what is a cast list?
The cast list is the names of the actors who were in the movie.
Use movieid=11768, (or whatever value you got from the previous question)

Select name
FROM actor JOIN casting ON (actor.id = actorid)
WHERE movieid=(Select id
FROM movie
WHERE title= 'Casablanca')

//7.
//Obtain the cast list for the film 'Alien'

Select name
FROM actor JOIN casting ON (actor.id = actorid)
WHERE movieid=(Select id
FROM movie
WHERE title= 'Alien')

//8.
//List the films in which 'Harrison Ford' has appeared
SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
WHERE actorid = (Select actor.id
FROM actor
WHERE name= 'Harrison Ford')

//(Alternative way)
SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';

//9.
//List the films where 'Harrison Ford' has appeared - but not in the starring role. 
//[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'
AND casting.ord!=1

//10.
List the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE movie.yr = 1962
AND casting.ord=1

//11.
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) >= 2

//12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT movie.title, actor.name
FROM movie JOIN casting
ON casting.movieid = movie.id AND ord = 1
JOIN actor
ON actor.id = casting.actorid
WHERE movie.id IN (SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE actor.name='Julie Andrews'))

//13.
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT actor.name
FROM casting
JOIN actor
ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*)>=15
ORDER BY actor.name

//14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT movie.title,COUNT(*)
FROM movie
JOIN casting
ON movie.id = casting.movieid
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY COUNT(*) DESC,movie.title

//15.
List all the people who have worked with 'Art Garfunkel'.

Select DISTINCT actor.name
FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON movie.id = casting.movieid
WHERE movie.id IN (Select movieid FROM casting JOIN actor ON actor.id = actorid where actor.name = 'Art Garfunkel') AND actor.name != 'Art Garfunkel'
