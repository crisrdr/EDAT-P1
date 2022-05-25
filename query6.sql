WITH delay
     AS (SELECT flights.flight_no,
                Avg(flights.actual_arrival - flights.scheduled_arrival) AS
                delay_avg
         FROM   flights
         GROUP  BY flights.flight_no
         ORDER  BY delay_avg DESC)
SELECT flights.flight_no,
       Avg(flights.actual_arrival - flights.scheduled_arrival) AS delay_avg
FROM   flights
       natural JOIN delay
WHERE  delay_avg = (SELECT ( Max(delay_avg) )
                    FROM   delay)
GROUP  BY flights.flight_no
ORDER  BY delay_avg DESC  
