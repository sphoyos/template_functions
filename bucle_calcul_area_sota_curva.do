

* Bucle en cada una de las medidas que queremos calcular el area
foreach var in medida1 medida1 medida3   {

* Inicializamos en blanco (missing) una varaiable para guardar el AUC de cada medida 
gen auc_`var'=.
format auc_`var' %10.2f

** Identificamos cuantos pacientes hay y los guardamos en una macro local
levels patientid
 local id_levels=r(levels)
 
 * Bucle para cada nivel (lev) de paciente
 
foreach lev in `id_levels' {


* cap indica que continue la ejecucion aunque haya errores
* qui indica que no muestre las salidas
* la instruccion pkexamine calcula el AUC para la variable `var' en cada una de las mediciones (tmeasure) 
* para el paciente del bucle `lev' por el mètodo de los trapecios

    cap   qui pkexamine tmeasure `var' if patientid==`lev' , trapezoid
	
* Si no hay error en la ejecución anterior guarda el resultado para le paciente lev en la varaible generada antes	
    if _rc==0 {
        replace auc_`var'=r(auc) if patientid==`lev'
* cierra el bucle del paciente
	}	
* cierra el bucle de la medida

}	

