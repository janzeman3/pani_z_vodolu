extends Node

var stav
var budouciStav
var budovy
var budouciBudovy

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

class budovyVect:
	var Pole = 0
	var Lom = 0
	var Kamenictvi = 0
	var Hostinec = 0
	var Kaple = 0
	var Kostel = 0
	var Katedrala = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	stav = stavVect.new(100, 500, 100, 0)
	budouciStav = stavVect.new(0, 0, 0, 0)
	
	budovy = budovyVect.new()
	budouciBudovy = budovyVect.new()
	
	$Stav.updateData(stav)
	updateBudouciStav()

func updateBudouciStav():
	budouciStav.Lidi = stav.Lidi
	budouciStav.Obili = stav.Obili
	budouciStav.Vodolary = stav.Vodolary
	budouciStav.Suroviny = stav.Suroviny
	
	# POLE
	# vynos: +5 obili
	budouciStav.Obili += 5 * budouciBudovy.Pole
	# cena stavby: 20 VD
	budouciStav.Vodolary -= 20 * (budouciBudovy.Pole-budovy.Pole)
	
	#VYZIVA OBYVATEL
	budouciStav.Obili -= budouciStav.Lidi
	$BudouciStav.updateData(budouciStav)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Pole_value_changed(value):
	budouciBudovy.Pole = value
	print(value)
	updateBudouciStav()
