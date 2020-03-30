extends GridContainer

var budovy
var budouciBudovy

signal BudovyChanged

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

func _on_NejakaBudova_value_changed(value):
	budouciBudovy.Pole = $Pole.value
	budouciBudovy.Lom = $Lom.value
	budouciBudovy.Kamenictvi = $Kamenictvi.value
	budouciBudovy.Hostinec = $Hostinec.value
	budouciBudovy.Kaple = $Kaple.value
	budouciBudovy.Kostel = $Kostel.value
	budouciBudovy.Katedrala = $Katedrala.value

	$lPoleDelta.text = str(budouciBudovy.Pole-budovy.Pole)
	$lLomDelta.text = str(budouciBudovy.Lom-budovy.Lom)
	$lKamenictviDelta.text = str(budouciBudovy.Kamenictvi-budovy.Kamenictvi)
	$lHostinecDelta.text = str(budouciBudovy.Hostinec-budovy.Hostinec)
	$lKapleDelta.text = str(budouciBudovy.Kaple-budovy.Kaple)
	$lKostelDelta.text = str(budouciBudovy.Kostel-budovy.Kostel)
	$lKatedralaDelta.text = str(budouciBudovy.Katedrala-budovy.Katedrala)
	
	emit_signal("BudovyChanged")

func novaHra():
	budovy = budovyVect.new()
	budouciBudovy = budovyVect.new()

func novyTah():
	budovy.copy(budouciBudovy)
	emit_signal("BudovyChanged")

func updateBudouciStav(stav, budouciStav):
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

func _ready():
	novaHra()
