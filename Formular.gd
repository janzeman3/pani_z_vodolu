extends Node

var stav
var budouciStav
var delta
var tah = 1
var tahMax = 20

class stavVect:
	var Lidi = 0
	var Obili = 0
	var Vodolary = 0
	var Suroviny = 0
	
	func _init(inLidi, inObili, inVodolary, inSuroviny):
		Lidi = inLidi
		Obili = inObili
		Vodolary = inVodolary
		Suroviny = inSuroviny

	func copy(inVal):
		Lidi = inVal.Lidi
		Obili = inVal.Obili
		Vodolary = inVal.Vodolary
		Suroviny = inVal.Suroviny

	func fillByDelta(Val1, Val2):
		Lidi = Val1.Lidi - Val2.Lidi
		Obili = Val1.Obili - Val2.Obili
		Vodolary = Val1.Vodolary - Val2.Vodolary
		Suroviny = Val1.Suroviny - Val2.Suroviny

# Called when the node enters the scene tree for the first time.
func _ready():
	newGame()

func updateView():
	$Stav.updateData(stav)
	$Stavby.updateBudouciStav(stav, budouciStav)
	
	$BudouciStav.updateData(budouciStav)
	delta.fillByDelta(budouciStav,stav)
	$Delta.updateData(delta)

	updateSkoreATahy()


func updateSkoreATahy():
	var skore = stav.Lidi*100 + stav.Vodolary
	$Skore.text = "Scóre: " + str(skore)
	$Tah.text = "Tah: " + str(tah) + " z " + str(tahMax)

func _on_Stavby_BudovyChanged():
	$Stavby.updateBudouciStav(stav, budouciStav)

	$BudouciStav.updateData(budouciStav)
	delta.fillByDelta(budouciStav,stav)
	$Delta.updateData(delta)


func _on_Tahni_pressed():
	tah += 1 
	stav.copy(budouciStav)
	$Stavby.novyTah()
	updateView()
	if tah > tahMax:
		endGame()

func newGame():
	tah = 1
	stav = stavVect.new(100, 500, 100, 0)
	budouciStav = stavVect.new(0, 0, 0, 0)
	delta = stavVect.new(0, 0, 0, 0)
	
	$Stavby.novaHra()

	updateView()
	
	$Tahni.visible = true
	$BudouciStav.visible = true
	$Tah.visible = true
	$Delta.visible = true
	$Stavby.visible = true

	$NovaHra.visible = false
	$Konec.visible = false

func endGame():
	$Tahni.visible = false
	$BudouciStav.visible = false
	$Tah.visible = false
	$Delta.visible = false
	$Stavby.visible = false

	$NovaHra.visible = true
	$Konec.visible = true


func _on_NovaHra_pressed():
	newGame()
