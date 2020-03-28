extends Node

var stav
var budouciStav
var delta
var budovy
var budouciBudovy
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



class budovyVect:
	var Pole = 0
	var Lom = 0
	var Kamenictvi = 0
	var Hostinec = 0
	var Kaple = 0
	var Kostel = 0
	var Katedrala = 0
	
	func copy(inVal):
		Pole = inVal.Pole
		Lom = inVal.Lom
		Kamenictvi = inVal.Kamenictvi
		Hostinec = inVal.Hostinec
		Kaple = inVal.Kaple
		Kostel = inVal.Kostel
		Katedrala = inVal.Katedrala

# Called when the node enters the scene tree for the first time.
func _ready():
	newGame()

func updateView():
	$Stav.updateData(stav)
	updateBudouciStav()
	updateSkoreATahy()

func updateBudouciStav():
	budouciStav.copy(stav)
	
	# POLE
	# vynos: +5 obili
	budouciStav.Obili += 5 * budouciBudovy.Pole
	# cena stavby: 20 VD
	budouciStav.Vodolary -= 20 * (budouciBudovy.Pole-budovy.Pole)
	
	#LOM
	# vynos: +5 surovin -1 lidi
	budouciStav.Suroviny += 5 * budouciBudovy.Lom
	budouciStav.Lidi -= 1 * budouciBudovy.Lom
	# cena stavby: 100 VD + 2 lidi
	budouciStav.Vodolary -= 100 * (budouciBudovy.Lom-budovy.Lom)
	budouciStav.Lidi -= 2 * (budouciBudovy.Lom-budovy.Lom)

	#KAMENICTVI
	# vynos: +100 vodolaru -5 surovin
	budouciStav.Vodolary += 100 * budouciBudovy.Kamenictvi
	budouciStav.Suroviny -= 5 * budouciBudovy.Kamenictvi
	# cena stavby: 30 surovin + 1 lidi
	budouciStav.Suroviny -= 30 * (budouciBudovy.Kamenictvi-budovy.Kamenictvi)
	budouciStav.Lidi -= 1 * (budouciBudovy.Kamenictvi-budovy.Kamenictvi)

	#HOSTINEC
	# vynos: +100 vodolaru -5 surovin
	budouciStav.Vodolary += 10 * budouciBudovy.Hostinec
	budouciStav.Lidi += 1 * budouciBudovy.Hostinec
	# cena stavby: 30 surovin + 1 lidi
	budouciStav.Vodolary -= 100 * (budouciBudovy.Hostinec-budovy.Hostinec)
	budouciStav.Lidi -= 1 * (budouciBudovy.Hostinec-budovy.Hostinec)
	
	#KAPLE
	# vynos: -20 vodolaru +10 lidí
	budouciStav.Vodolary -= 20 * budouciBudovy.Kaple
	budouciStav.Lidi += 10 * budouciBudovy.Kaple
	# cena stavby: 40 surovin
	budouciStav.Suroviny -= 40 * (budouciBudovy.Kaple-budovy.Kaple)

	#KOSTEL
	# vynos: -50 vodolaru +20 lidí
	budouciStav.Vodolary -= 50 * budouciBudovy.Kostel
	budouciStav.Lidi += 20 * budouciBudovy.Kostel
	# cena stavby: 110 surovin + 500VD
	budouciStav.Suroviny -= 110 * (budouciBudovy.Kostel-budovy.Kostel)
	budouciStav.Vodolary -= 500 * (budouciBudovy.Kostel-budovy.Kostel)

	#KATEDRALA
	# vynos: -150 vodolaru +50 lidí
	budouciStav.Vodolary -= 150 * budouciBudovy.Katedrala
	budouciStav.Lidi += 50 * budouciBudovy.Katedrala
	# cena stavby: 230 surovin + 2000VD
	budouciStav.Suroviny -= 230 * (budouciBudovy.Katedrala-budovy.Katedrala)
	budouciStav.Vodolary -= 2000 * (budouciBudovy.Katedrala-budovy.Katedrala)
	
	#VYZIVA OBYVATEL
	# pokud neni obili, pomrou lidi
	if budouciStav.Obili < budouciStav.Lidi:
		budouciStav.Lidi = budouciStav.Obili
	budouciStav.Obili -= budouciStav.Lidi

	#DANE
	budouciStav.Vodolary += budouciStav.Lidi

	$BudouciStav.updateData(budouciStav)
	delta.fillByDelta(budouciStav,stav)
	$Delta.updateData(delta)
	
	

func updateSkoreATahy():
	var skore = stav.Lidi*100 + stav.Vodolary
	$Skore.text = "Scóre: " + str(skore)
	$Tah.text = "Tah: " + str(tah) + " z " + str(tahMax)

func _on_Pole_value_changed(value):
	budouciBudovy.Pole = $Stavby/Pole.value
	budouciBudovy.Lom = $Stavby/Lom.value
	budouciBudovy.Kamenictvi = $Stavby/Kamenictvi.value
	budouciBudovy.Hostinec = $Stavby/Hostinec.value
	budouciBudovy.Kaple = $Stavby/Kaple.value
	budouciBudovy.Kostel = $Stavby/Kostel.value
	budouciBudovy.Katedrala = $Stavby/Katedrala.value
	updateBudouciStav()

func _on_Tahni_pressed():
	tah += 1 
	stav.copy(budouciStav)
	budovy.copy(budouciBudovy)
	updateView()
	if tah > tahMax:
		endGame()

func newGame():
	tah = 1
	stav = stavVect.new(100, 500, 100, 0)
	budouciStav = stavVect.new(0, 0, 0, 0)
	delta = stavVect.new(0, 0, 0, 0)
	
	budovy = budovyVect.new()
	budouciBudovy = budovyVect.new()

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
