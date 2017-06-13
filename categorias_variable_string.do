levelsof   pais_naixement , local(races)
foreach  race of local races {
display _newline(1)  "replace AE_DRUG="J05A    "  if faea=="`race'""

}




levelsof pais_naixement , local(races)
foreach  race of local races {
display _newline(1) "replace ORIGIN=" char(34) " " char(34)     "  if pais_naixement=="char(34) "`race'"char(34)

}



levelsof traslado_a , local(races)
foreach  race of local races {
display _newline(1) "replace DROP_RS=    if  trim(traslado_a)=="char(34) "`race'"char(34)

}


pcpfarm proffarm proffarm2 proffarm3

levelsof pcpfarm , local(races)
foreach  race of local races {
display _newline(1) "replace MED_ID=" char(34) " " char(34)    " if  trim(pcpfarm)=="char(34) "`race'"char(34)

}


levelsof proffarm , local(races)
foreach  race of local races {
display _newline(1) "replace MED_ID=" char(34) " " char(34)    " if  trim(proffarm)=="char(34) "`race'"char(34)

}


levelsof proffarm2 , local(races)
foreach  race of local races {
display _newline(1) "replace MED_ID=" char(34) " " char(34)    " if  trim(proffarm2)=="char(34) "`race'"char(34)

}


levelsof proffarm3 , local(races)
foreach  race of local races {
display _newline(1) "replace MED_ID=" char(34) " " char(34)    " if  trim(proffarm3)=="char(34) "`race'"char(34)

}



levelsof descrip , local(races)
foreach  race of local races {
display _newline(1) "replace AE_ID=" char(34) " " char(34)    " if  trim(descrip)=="char(34) "`race'"char(34)
display _newline(1) "replace AE_SPEC=" char(34) " " char(34)    " if  trim(descrip)=="char(34) "`race'"char(34)
}


levelsof descrip , local(races)
foreach  race of local races {
display _newline(1)  "`race'"

}
