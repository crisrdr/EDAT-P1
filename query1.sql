-- QUERY 1
--
-- Reservas con billete de ida y vuelta (1 dep_air = 2 ariv_air)

SELECT DISTINCT aux1.departure_airport,
                Count(*) AS tickets
FROM   (SELECT bookings.book_ref,
               flights.ticket_no,
               bookings.passenger_name,
               flights.arrival_airport,
               flights.departure_airport
        FROM   (SELECT bookings.book_ref,
                       tickets.ticket_no,
                       tickets.passenger_name
                FROM   bookings
                       natural JOIN tickets) AS bookings,
               (SELECT ticket_flights.ticket_no,
                       flights.arrival_airport,
                       flights.departure_airport
                FROM   ticket_flights
                       natural JOIN flights) AS flights
        WHERE  flights.ticket_no = bookings.ticket_no
        ORDER  BY bookings.book_ref) AS aux1
       JOIN (SELECT bookings.book_ref,
                    flights.ticket_no,
                    bookings.passenger_name,
                    flights.arrival_airport,
                    flights.departure_airport
             FROM   (SELECT bookings.book_ref,
                            tickets.ticket_no,
                            tickets.passenger_name
                     FROM   bookings
                            natural JOIN tickets) AS bookings,
                    (SELECT ticket_flights.ticket_no,
                            flights.arrival_airport,
                            flights.departure_airport
                     FROM   ticket_flights
                            natural JOIN flights) AS flights
             WHERE  flights.ticket_no = bookings.ticket_no
             ORDER  BY bookings.book_ref) AS aux2
         ON aux1.book_ref = aux2.book_ref
            AND aux1.departure_airport = aux2.arrival_airport
GROUP  BY aux1.departure_airport
ORDER  BY aux1.departure_airport ASC 