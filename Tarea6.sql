/* 1.- SUBCONSULTAS -------> 3 */
/* 1.1 ----> Muestra todos los servicios y la cantidad de veces que se vendieron que tengan la vocal 'a' en su nombre de servicio */
Select *
from
	( select s.nombre, COUNT(sv.idSerVen) as 'Cantidad'
	from Servicio as s inner join ServiciosVendidos as sv on s.idServicio = sv.idServicio
	group by(s.nombre) ) as GN
where GN.nombre like '%a%'

/* 1.2 ----------------->  */
Select * 
from (
	select h.idHabitacion, h.clase, h.piso, h.costoDiario, r.diasReservados, h.costoDiario * r.diasReservados as precioTotal
	from Habitacion as h left join Reservacion as r
	on h.idHabitacion = r.idHabitacion
) as CH
where CH.precioTotal > 0

/* 1.3 */

/*no tengo la más minima idea de a que se refiere con la subbonsulta de column, o a lo mejor con la de table no sé, solo recuerdo una
estaba jugando tetris*/


/* 2.- SUBONSULTA CON WITH ------> 1 */
/* 2.1 ----> Muestra todos los servicios y la cantidad de veces que se vendieron que tengan la vocal 'a' en su nombre de servicio*/
with Cantidades as (
	select s.nombre, COUNT(sv.idSerVen) as 'Cantidad'
	from Servicio as s inner join ServiciosVendidos as sv on s.idServicio = sv.idServicio
	group by(s.nombre) )
select *
from Cantidades
where Cantidades.nombre like '%a%'

/*esta consulta jala bien chingona*/


/*3.- Vistas -------> 5*/
/* 3.1 */
create view ReporteMensualDeRservaciones as(
	select c.nomComp, sv.fecha, r.fechaEntrada as 'Fecha de reservacion', s.nombre as 'Servicio Comprado'
	from Cliente as c inner join Venta as v on c.idCliente = v.idCliente
		inner join VentaReservaciones as vr on vr.idVenta = v.idVenta
		inner join ServiciosVendidos as sv on sv.idVenta = v.idVenta
		inner join Servicio as s on s.idServicio = sv.idServicio
		inner join Reservacion as r on r.idReservacion = vr.idReservacion
	Where MONTH(r.fechaEntrada) = MONTH(GETDATE()) AND MONTH(sv.fecha) = MONTH(GETDATE())

)

/* 3.2 */

/* 3.3 */

/* 3.4 */

/* 3.5 */



/* 4.- Consulta dinámica -------> 1 */