Beginner level
Question 1. Retrieve all crime reports from july 28,2021
SELECT *
FROM crime_scene_reports
WHERE year = 2021
AND month = 7 
AND day = 28;

Question 2. Find all people who live on Humphery level
DESCRIBE people;

Question 3.list all interviews conducted on the same day as the crime
SELECT *
FROM interviews 
WHERE year = 2021
AND month = 7  
AND day = 28

Question 4.Show all ATM transactions made on that day
USE filtyvile;
SELECT *
FROM atm_transactions
WHERE year = 2021
AND month = 7 
AND day = 28;

Question 5. Find all flight departing from fiftyvile on that day
SELECT f.id AS flight_id,f.hour,f.minute,
     a.city AS departure_city
FROM flights f
JOIN airports a 
     ON f. origin_airport_id = a.id
WHERE f. year = 2021
   AND f. month = 7
   AND f. day = 28
   AND a.city = 'fiftyville';

Intermiediate level
question 1: find the names people who made ATM withdrawls on the day of the crime
SELECT name
FROM people
WHERE id IN (
    SELECT person_id
    FROM bank_accounts
    WHERE account_number IN (
         SELECT account_number
         FROM atm_transactions
    WHERE year = 2021
     AND month = 7
      AND day =28
      AND transaction_type = 'withdraw'
	)
    );

question 2: list all phone calls made on that day that lasted less than 60 seconds  
  SELECT *
  FROM phone_calls
  WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration <60;
    
Question 3: identify all passengers on flights leaving filtyvile on july 29,2021
SELECT *
FROM passengers
WHERE flight_id = flight_id;
 
 question 4: find people who were interviewed and also appear in the people table
 SELECT DISTINCT p.id, p.name
 FROM people p 
 JOIN interviews i ON p.name = i.name;
 
 question 5: show all bank accounts linked to people who made ATM withdrawls that day
SELECT account_number
FROM atm_transactions
WHERE year = 2021
AND month = 7 
AND day = 28 
AND transaction_type = 'withdraw';

Advanced level
Question 1: Identify people who made a withdrawl and a short phone call
SELECT DISTINCT name
FROM people 
WHERE id IN (
SELECT person_id
FROM bank_accounts
WHERE account_number IN (
    SELECT account_number
	FROM atm_transactions
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND transaction_type = 'withdraw'
	)
)
SELECT name
FROM people 
JOIN phone_calls
ON people.phone_number = phone_calls.caller
WHERE phone_calls.year = 2021
AND phone_calls.month =7 
AND phone_calls.duration < 60;

Question 2:Find suspects who left filtyvile on july 29 on the earliest level
SELECT name
FROM people 
JOIN passengers ON people.passport_number = passengers.passport_number
JOIN flights ON passengers.flight_id = flights.id
ORDER BY flights.hour, flights.minute
LIMIT 1;

question 3: identify the earliest flight leaving filtyvile on july 29
SELECT flights.id, airports.city
FROM flights
JOIN airports
ON flights.destination_airport_id = airports.id
ORDER BY flights.hour,flights.minute
LIMIT 1;

Question 4:find all passengers on that earliest flight
SELECT name
FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
JOIN flights ON passengers.flight_id = flights.id
WHERE flights.id = 36;

Question 5: combine clues to find the prime suspect
SELECT name
FROM people 
WHERE phone_number IN (
      SELECT caller 
      FROM phone_calls
      WHERE year = 2021 AND month = 7 AND DAY = 28
      AND duration < 60
      
      )
      
EXPERT LEVEL
Question 1: Who committed the crime
SELECT description
FROM crime_scene_reports
WHERE year = 2021
AND month = 7
AND day = 28;
SELECT name, transcript
FROM interviews
WHERE year = 2021
AND month = 7
AND day = 28;

Question 2 : where did they escape to
SELECT f.id
FROM flights f
JOIN airports a ON f.origin_airport_id = a.id
WHERE f.year = 2021
AND f.month = 7
AND f.day = 29
ORDER BY f.hour, f.minute
LIMIT 1;

Question 3: who was their accomplice
SELECT DISTINCT P.name, c.duration
FROM phone_calls c
JOIN people p ON c.receiver = p.phone_number
WHERE c.year = 2021 
AND c.month = 7 AND c.day = 28
AND c. duration < 60; 