-- QUERY 3
--
-- Muestra codigo aeropuerto y nº pasajeros recibido (arrival), en orden ascendente. Con tarjeta de embarque

SELECT airports_data.airport_code,
       Count(flights.arrival_airport) AS passengers
FROM   boarding_passes
       natural JOIN ticket_flights
       natural JOIN flights
       natural JOIN airports_data
WHERE  flights.arrival_airport = airports_data.airport_code
GROUP  BY airports_data.airport_code
ORDER  BY passengers DESC  