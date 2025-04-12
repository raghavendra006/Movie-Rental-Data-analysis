use sakila;

-- Task 1) Display full names of actors available in database?
select concat(first_name,' ',last_name) 
from actor 
order by concat(first_name,' ',last_name)  asc; 
/* Full name of all actors are ADAM GRANT,ADAM HOPPER,BURT POSEY, CAMERON STREEP,
CHRISTIAN GABLE,FRED COSTNER and so on.*/

-- task 2 i) Display the number of times each First name appears in the database
select first_name,count(first_name) 
from actor group by first_name
order by count(first_name)  desc;
/*Query displays the first names and number of times first name repeated ,
 some of them are PENELOPE,JULIA,KENNETH,ED , so on.*/

-- task 2 ii)What is the Count of actors that have unique first names in database? and Display first name of these actors?
create view view2 as
select first_name,count(first_name) from actor 
group by first_name  
having count(first_name)=1  
order by count(first_name) desc;

select count(first_name) from view2;

-- Above Query Displays Count of Unique first name , There are 76 Unique first name of actors.

select first_name from view2
order by first_name asc;

-- Unique First Names of actors are AL,ALAN,ANGELINA,ANNE,BETTE and so on.

-- task 3 i) Display the number of times each Last name appears in the database

select last_name,count(last_name) 
from actor 
group by last_name 
order by count(last_name)  desc;

-- Query displays the Last names and number of times Last name repeated , In a descending Order of count.

-- task 3 ii) Display the Unique last names in the database
select last_name,count(last_name) 
from actor 
group by last_name 
having count(last_name)=1 
order by last_name asc;
-- Query Display Unique last names of actors, they are ASTAIRE,BACALL,BALL and so on.

-- task 4 i) Display List of records for the movies with the rating "R" 
select title,rating from film where rating='R';
-- Movies with rating "R" are AIRPORT POLLOCK,ALONE TRIP,AMELIE HELLFIGHTERS and so on.

-- task 4 ii) Display the list of records for the movies that are not rated "R"
select title,rating  from film where rating!='R';

-- Movies that are not rated "R" are ACADEMY DINOSAUR,ACE GOLDFINGER,ADAPTATION HOLES,AFFAIR PREJUDICE,AFRICAN EGG and so on.

-- task 4 iii) Display the list of records for the movies that are suitable for audience below 13 years of age
select title  from film join film_category using(film_id) 
join category using(category_id)
where rating!='R' and name='Children';
-- Query displays records of movies that are suitable for children below 13 years .These movies have Children film Category and doesnt have rating "R" 

-- task 5 i) Display the list of records for the movies where replacement cost is up to $11.
select title,replacement_cost from film where replacement_cost<=11;
-- Query displays list of records for the movies where replacement cost is up to $11.Movies are ALIEN CENTER,AMISTAD MIDSUMMER and so on.

-- task 5 ii) Display the list of records for the movies where replacement cost is between to $11 and $20.
select title,replacement_cost from film where replacement_cost between 11 and 20 ;
-- Query displays list of records for the movies where replacement cost is between to $11 and $20.Movies are ACE GOLDFINGER,ADAPTATION HOLES and so on.

-- task 5 iii) Display the list of records for all the movies in descending order of their replacement costs.
select title,replacement_cost  from film order by replacement_cost desc;
-- Movies with highest replacement costs are ARABIA DOGMA,BALLROOM MOCKINGBIRD followed by BLINDNESS GUN and so on.

-- task 6 display the names of top 3 movies with greatest number of actors
select title,count(actor_id) 
from film join  film_actor using(film_id) 
group by film_id 
order by count(actor_id)  desc
limit 3;  

-- Top 3 movies with greatest number of actors are LAMBS CINCINATTI , CHITTY LOCK , BOONDOCK BALLROOM.

-- task 7: Display title of movie title starting with K and Q
select title from film where title like 'K%' or title like 'Q%';
-- Query displays movie title starting with K and Q. Some of the movies are KANE EXORCIST,KARATE MOON,QUEEN LUKE,QUEST MUSSOLINI and soo on.
 
-- task 8) Display the Name of actors appearing in film 'Agent Truman'
select title,concat(first_name,' ',last_name) 
from film join  film_actor using(film_id)
join actor using(actor_id) 
where title='Agent Truman';
/* Name of actors appearing in film 'Agent Truman' are KIRSTEN PALTROW,SANDRA KILMER,JAYNE NEESON,WARREN NOLTE,MORGAN WILLIAMS,KENNETH HOFFMAN,
REESE WEST */

-- task 9) Identify movies Categorized as family films
select title,name from film join film_category using(film_id) 
join category using(category_id) 
where category.name='Family';
-- Some of the family films are AFRICAN EGG,APACHE DIVINE,ATLANTIS CAUSE,BAKED CLEOPATRA,BANG KWAI,BEDAZZLED MARRIED and so on.

-- task 10 i) Display maximum,minimum,average rental rates of movies based on their ratings
select rating,max(rental_rate) ,min(rental_rate) , avg(rental_rate) from film 
group by rating
order by avg(rental_rate) desc;
-- PG Rating has more average rental rates followed by PG-13.

-- task 10 ii) Display Movies in descending order of their rental frequencies
select title,count(title)  from film 
join inventory using(film_id)  
join rental using(inventory_id)
group by film_id 
order by count(title) desc;
-- Most frequenctly rented movies are BUCKET BROTHERHOOD,ROCKETEER MOTHER,FORWARD TEMPLE,GRIT CLOCKWORK,JUGGLER HARDLY,RIDGEMONT SUBMARINE and so on.

-- task 11)How many film Categories have average film replacement cost & average film rental rate greater than 15?
select name,avg(replacement_cost),avg(rental_rate) from film 
join film_category using(film_id) join category using(category_id) 
group by name
having avg(replacement_cost)-avg(rental_rate)>15;
-- 16 Categories have average difference between  replacement cost & rental rate greater than 15
-- Categories are Travel,Sports,Sci-Fi,New,Music,Horror,Games,Foreign,Action,Animation,Children,Classics,Comedy,Documentary,Drama,Family.

-- task 12) Display the Movie Categories in which the number of movies is greater than 70
select name,count(name)  from category 
join film_category using(category_id) 
join film using(film_id)
group by category_id 
having count(name)>70
order by count(name) desc;
-- Categories in which the number of movies is greater than 70 are Sports , Foreign