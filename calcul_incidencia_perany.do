
******* VARIABLES DISPONIBLES

!* date_tx:  Fecha de origen del seguimento
!* date_last_muestra: Fecha de fin de seguimiento 
!* resultado  al fin de seguimiento 0: no evento 1: evento 
!* nhc: Numero de historia clinica o identificador del sujeto si no existe  ejecutar  gen nhc=_n

***** GENERA LAS FECHAS EN CONTINUO PARA OLVIDARSE DE que son fechas 
generate data_tx = year(date_de_tx)+ doy(date_de_tx)/doy(mdy(12,31,year(date_de_tx)))
generate data_last_muestra = year(date_last_muestra)+ doy(date_last_muestra)/doy(mdy(12,31,year(date_last_muestra)))



******* CALCULO DE LA SUPERVIENCIA GLOBAL O INCIDENCIA ( el id es necesario para usar stptime que calcula incidencia). 
******* lo que hace es que el tiempo de seguimento es data_last_muestr-date_tx=0. 

stset data_last_muestra, failure(resultado) origin(date_tx) id(nhc) 

*********** EL COMANDO CALCULA  LA INCIDENCIA, PERSONAS TIEMPO 
stptime


***  SI NO HAY MAS DE UN REGISTRO SE PUEDE OBVIAR Y USAR DIRECTAMENTE NHC, COMO NO MOLESTA MEJOR HACERLO.

gen id=_n


*** GENERAMOS UNA VARIABLE  PARA CONSERVAR EL VERDADERO ORIGEN

gen data_ini= data_tx

*** GENERAMOS UNA VARIABLE PARA CONSERVAR EL VERDADERO FIN

gen data_fin= data_last_muestra


*** AHORA USAMOS COMO TIEMPO DE SEGUIMIENTO EL CALENDARIO . El punto 0 es el nacimiento de Cristo. Usamos entrada retrasada
*** El sujeto entra el dia del diagnostico y finaliza al final

stset data_fin , failure(resultado)  id(id)  time0(date_tx)

**** CORTAMOS EL SEGUIMIENTO  EN LOS PUNTOS DE CORTE QUE QUERAMOS

stsplit periode_any, at(2008 2010   2012)

****************** SI QUEREMOS CADA AÑO PONEMOS 1 stsplit periode_any, every(1)
*** EL PROGRAMA GENERA UN REGISTRO POR CADA AÑO CON UNA FECHA DE ENTRADA Y OTRA DE SALIDA EN ESE AÑO Y LA 
*** VARIABLE periode_any valdra 0 para antes de 2008, 2008 para el año 2008-09, 2010 para 2010-11 y 2012 para 2012+


*** LA VARIABLE resultado SOLO ESTA EN EL ULTIMO REGISTRO Y RENOMBRAMOS LA VARIABLE INTERNA _d QUE ESTA EN TODOS 

rename _d result_nou

**** Indico el fin e inicio de cada registro, el resultado al final de es registro y el origen del seguimento para cada sujeto

stset data_fin  f(result_vir) id(nhc) origin(date_tx)  time0(data_ini)


**** ETIQUETO LA VARIABLE Y SI QUIERO RECODIFICO LOS VALORES

label var periode_any "Año-calendario"

**** CALCULO LA INCIDENCIA GLOBAL
stptime

**** CALCULO LA INCIDENCIA POR PERIODO DEL CALENDARIO

stptime ,by(periode_any) 

***** CALCULO COX ME PERMITE VER DIFERENCIAS EN EL RIESGO POR AÑO

xi:stcox i.periode_any