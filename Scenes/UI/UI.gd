extends Control

var plantN := 5
var iTime := 0
var running := false
var time: int = 0

onready var gameOverScene := load("res://Scenes/Game Over/Game Over.tscn")

onready var vegLabel := $Veggies
onready var ptsLabel := $Pts
onready var vegLSize = vegLabel.text.length()

func _physics_process(delta):
    if running :
        updatePts()

func start() :
    running = true
    iTime = Time.get_ticks_msec()

func gameOver() :
    get_tree().change_scene("res://Scenes/Game Over/Game Over.tscn")

func takePlant() :
    print( "locura ", plantN )
    plantN -= 1
    vegLabel.text[ vegLSize - 1 ] = String( plantN )
    if plantN == 0 :
        gameOver()

func updatePts() :
    time = ( Time.get_ticks_msec() - iTime ) / 100
    ptsLabel.text = "Pts:" + String( time )

