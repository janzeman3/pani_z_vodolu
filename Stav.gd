extends GridContainer

func updateData(inStavVect):
	$Stav/Lidi.text = str(inStavVect.Lidi)
	$Stav/Vodolary.text = str(inStavVect.Vodolary)
	$Stav/Obili.text = str(inStavVect.Obili)
	$Stav/Suroviny.text = str(inStavVect.Suroviny)

func zmenTitulek(novyTitulek):
	$Titulek.text = novyTitulek
