

*****************  INTRODUïR EL NOM DE LA BASE DE DADES ON ESTAN LES DATES

use $orig/todos.h1n1.dta,clear

******  data1ing: Data d'entrada primera mesura (i.e. entrada hospital "dataingr")
******  data1sal: Data d'alta primera mesura  (i.e Data alta hospital "dataalta")
*****    data2ing: Data d'entrada segona mesura  (i.e. Data  entrada en uci "dataiuci")
******   data2sal: Data d'alta segona mesura   (i,e  Data d'alta UCI "dataltau")


**** Cal canviar les dates i ficar les que pertoquen

gen    data1ing= dataingr
gen    data1sal= dataalta
gen    data2ing= dataiuci
gen     data2sal=dataltau

 

 
 
 
 
tempfile serie

**** Calcula el nombre d'individus en la base de dades

local Ncasos=_N

**** Obté la data maxima d'alta de la primera mesura a partir de les dades

summarize data1sal
local maxdata=r(max)

*** Si es vol ficar una data concreta per al dibuix caldra executar la següent linia (bastara treure l'asterisk i ficar la data adient en MES, DIA, ANY)

*local maxdata=mdy(10,31,2010)


**** Obté la data mínima d'ingrés  de la primera mesura a partir de les dades
summarize data1ing
local mindata=r(min)



*** Si es vol ficar una data concreta per al dibuix caldra executar la següent linia (bastara treure l'asterisk i ficar la data adient en MES, DIA, ANY)

*local mindata=mdy(3,1,2009)

***  Prepara el fitxer on es guardaran els resultats

postfile grafserie data casos1  casos2  using `serie' 

*** Comença un bucle on s'avalua cada dia des d'el primer fins a l'últim

forvalues i=`mindata'(1) `maxdata' {

*** Identifica el dia iésim

local data=`i'

*** Inicialitza els valors del nombre de casos de la primera i segona mesura 

local ling=0
local luci=0

** Commença un bucle recorrent a tots els subjectes de la base de dades.

forvalues j=1(1)`Ncasos' {

*** Comproba si el subjecte j-ésim estava ingressat per a la primera mesura en la data i-ésima 

if data1ing[`j']<=`data' & data1sal[`j']>=`data' {



** Si estava ingresat suma un cas per a la primera mesura

local ling= `ling' +1 

}

*** Comproba si el subjecte j-ésim estava ingressat per a la segona mesura en la data i-ésima 

 if data2ing[`j']<=`data' & data2sal[`j']>=`data' {

** Si estava ingresat suma un cas per a la segona mesura
 
 local luci= `luci' +1
}
 
}

**** Guarda en la taula de resultats la data , el nombre casos de la primera mesura, el numero de casos de la segona mesura

post  grafserie  (`i')  (`ling') (`luci')


}


*** Guarda la taula en la base de dades serie

postclose  grafserie

**** Obre la base de dades serie i  formatea la data i fica etiquetes a les variables que s'han de canviar segons es vullga

use `serie',clear

format data %td

*** FICAR LES ETIQUETES ADIENTS

label var data "Data del calendari"
label var casos1 "Casos de la primera mesura"
label var casos2 "Casos de la segona mesura"


**** Es gràfiquen per a les dates considerades els nombrs de casos. Caldra canviar el titol i el nombre de punts en l'eix d'abcises que es 10 si es volen mes o menys 


twoway bar casos1 data,color(teal) ||bar casos2  data ,color(sand)||, title("Casos de grip A(N1H1) en hospitalitzats a Vall d'hebron",size(medium)) xlabel(#10,labs(vsmall))


**** Es guarda el gràfic en un fitxer que caldra canviar a gust


*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************


*** si es vol guardar la  base de dades amb la serie caldra ficar un nom on fica `saving' i treure l'asterisk

*  save `saving'  ,replace
