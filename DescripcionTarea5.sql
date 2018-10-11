/*SUBCONSULTA (mal)*/

Select *
from
	( select s.nombre, COUNT(sv.idSerVen) as 'Cantidad'
	from Servicio as s inner join ServiciosVendidos as sv on s.idServicio = sv.idServicio
	group by(s.nombre) ) as GN
where GN.nombre like '%a%'
/*SE PUEDE HACER UNA SUBCONSULTA DENTRO DE OTRA DENTRO DE OTRA DENTRO DE OTRA, PERO ESO ES CONFUSO Y NOE S EFICIENTE EN CUANTO
A PROCESAMIENTO DEBIDO A QUE UNA SUBCONSULTA SE EJECUTA UNA VEZ POR CADA REGISTRO DE LA CONSULTA SIGUIENTE EN LA CUAL SE
ENCUENTRA ANIDADADA, POR LO TANTO, AL EJECUTAR UNA SUBSCONSULTA, SE EJECUTARÁ MUCHAS VECES REDUCIENDO EL PROCESAMIENTO.
PARA RESOLVER ESTE PROBLEMA SE PUEDEN USAR EL GROUP BY Y HAVING O LAS SUBCONSULTAS CON WITH*/




/* SUBCONSULTA CON WITH (bien) */

with Cantidades as (
	select s.nombre, COUNT(sv.idSerVen) as 'Cantidad'
	from Servicio as s inner join ServiciosVendidos as sv on s.idServicio = sv.idServicio
	group by(s.nombre) )
select *
from Cantidades
where Cantidades.nombre like '%a%'

/*LAS SUBCONSULTAS SOLAMENTE SE NECESITAN PARA CANTIDADES MASIVAS DE INFORMACIÓN*/






/*VISTAS*/
create view ReporteMensual as (
	select s.nombre, COUNT(sv.idSerVen) as 'Cantidad'
	from Servicio as s inner join ServiciosVendidos as sv on s.idServicio = sv.idServicio
	where MONTH(sv.fecha) = MONTH(GETDATE())	
	group by (s.nombre)
)


select * from ReporteMensual


/*	LAS VISTAS SON CONSULTAS GUARDADAS UTILIZADAS PARA QUE CUANDO NOSOTROS LAS NECESITEMOS SOLAMENTE LAS UTILICEMOS, A LAS VISTAS
SE LES PUEDEN CREAR INDICES*/





/*CONSULTAS DINAMICAS*/
declare @query nvarchar(MAX)
set @query = 'select * from Empleado'

exec(@query)

/* ESTAS CONSULTAS DINAMICAS SON MUY SUCEPTIBLES A SQLINJECTIONS DEBIDO A QUE SU USO PRINCIPAL ES PARA  QUE EL USUARIO PUEDA INTRODUCIR SUS VALORES
EN EL QUERY, Y ESTO ES SUCEPTIBLE*/



/*tarea
3 SUBCONSULTAS
	1 SUB CONSULTA COLUMN
	1 SUBCONSULTA TABLA
	1 SUBBONSULTA LIBRE

1 SUBCONSULTA CON WITH

5 VISTAS
	DEBEN SER REPORTES DE SU APLICACION
		-JOIN
		-FN AGREGACION


NO ES NECESARIO SUBIR EL RESPALDO DE LA BASE DE DATOS, SOLAMENTE LAS CONSULTAS

*/