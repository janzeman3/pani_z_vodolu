extends Node


# Declare member variables here. Examples:
var nObili = 200
var nSuroviny = 0
var nLidi = 100
var nVodolary = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	stavReset()

func stavReset():
	nObili = 200
	nSuroviny = 0
	nLidi = 100
	nVodolary = 100
	stavRefresh()

func stavRefresh():
	$Stav/Lidi.text = str(nLidi)
	$Stav/Vodolary.text = str(nVodolary)
	$Stav/Obili.text = str(nObili)
	$Stav/Suroviny.text = str(nSuroviny)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
