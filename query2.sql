-- QUERY 2
--
-- Precio de una reserva a partir de ticket_flights.amount. 
-- En tres columnas con booking.book_ref, booking.total_amount y el valor calculado.
-- Ordenar de forma ascendente con bookigs.book_ref

SELECT bookings.total_amount,
       bookings.book_ref,
       Sum(ticket_flights.amount) AS precio_booking
FROM   ticket_flights
       natural JOIN tickets
       natural JOIN bookings
GROUP  BY bookings.book_ref
ORDER  BY bookings.book_ref ASC  
