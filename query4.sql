WITH empty_total
     AS (SELECT occupied.flight_id,
                total_seats.seats,
                occupied.purchased,
                ( total_seats.seats - occupied.purchased ) AS empty
         FROM   (SELECT flights.flight_id,
                        Count(*) AS purchased
                 FROM   ticket_flights
                        natural JOIN flights
                 GROUP  BY flights.flight_id
                 ORDER  BY Count(*) ASC) AS occupied,
                (SELECT flights.flight_id,
                        Count(*) AS seats
                 FROM   seats
                        natural JOIN aircrafts_data
                        natural JOIN flights
                 GROUP  BY flights.flight_id) AS total_seats
         WHERE  occupied.flight_id = total_seats.flight_id)
SELECT occupied.flight_id,
       total_seats.seats,
       occupied.purchased,
       ( total_seats.seats - occupied.purchased ) AS empty
FROM   (SELECT flights.flight_id,
               Count(*) AS purchased
        FROM   ticket_flights
               natural JOIN flights
        GROUP  BY flights.flight_id
        ORDER  BY Count(*) ASC) AS occupied,
       (SELECT flights.flight_id,
               Count(*) AS seats
        FROM   seats
               natural JOIN aircrafts_data
               natural JOIN flights
        GROUP  BY flights.flight_id) AS total_seats
WHERE  occupied.flight_id = total_seats.flight_id
       AND total_seats.seats - occupied.purchased = (SELECT( Max(empty) )
                                                     FROM   empty_total) 
