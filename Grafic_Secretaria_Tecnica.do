

twoway bar  fiacumulat20102015  id ,bcolor(teal) || bar fiacumulat20102015 id if codi==42 , bcolor(red) ///
|| bar fiacumulat20102015 id if codi==43 , bcolor(ltblue) ///
|| bar fiacumulat20102015 id if codi==24 , bcolor(orange) ///
|| bar fiacumulat20102015 id if codi==40 , bcolor(olive)  ///
||, legend (label(1 "Serveis") label(2 "Pediatria General") label(3 "Q25")  label(4 "Q50")  label(5 "Q75"))  ///
title( Factor d'Impacte Acumulat)
