htput <br>
*do	$labels\coments   "`vargrup'" "`var'" 
* 1=  "`vargrup'"
* 2= "`var'"



if "`1'"=="c0" & "`2'"=="vtd_" {
 htput <FONT color="#993366"><p>  
htput  
 htput  </p>   </FONT>
}





if "`1'"=="c1" {
 htput <FONT color="#993366"><p>  
htput En primer lugar se presentan un análisis descriptivo de  cada una de las variables separado según el grupo de intervención y el total </p>
htput <p>  Para las variables cualitativas se muestra la frecuencia y el porcentaje con su intervalo de confianza en cada grupo de intervención
htput  Además se muestra la frecuencia y porcentaje
htput total de cada categoría. Para contrastar la existencia de asociación entre las variables cualitativas y el grupo de intervención se utiliza la prueba del chi cuadrado o Exacta
htput de Fisher según corresponda por el número de casos esperados en cada categoria.  </p>
htput Para las variables cuantitativas se muestra las medidas descriptivas, media, desviación típica, Intervalo de confianza al 95%, mediana e intervalo intercuartílico para cada
htput valor de la variable resultado considerada. Para contrastar la existencia de asociación entre las variables cuantitativas y el resultado se utiliza
htput la prueba de Kruskal-Wallis y la prueba t-test según corresponda.  </p>  
htput <p>  Para facilitar la lectura de las tablas se ha marcado el fondo de las celdas para aquellas variables con un p valor inferior al 5% en los tests. 
htput Los análisis han sido efectuados con el programa Stata 13.1
htput  </p>   </FONT>
}

