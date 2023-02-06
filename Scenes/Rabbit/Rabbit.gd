extends KinematicBody2D

signal exitedScreen
signal atePlant

enum State { IDLE, ATTACKING, RETREATING }
var state = State.IDLE

var onScreen := false
var speed : float = 100
var auxSpeed : float

func _physics_process(delta):
    if position.x >= -75 :
        position.x = -75
        eat()
    if state == State.ATTACKING :
        auxSpeed = lerp( auxSpeed, 1, .01)
        position.x += auxSpeed * delta
    if state == State.RETREATING :
        position.x -= speed * 2 * delta

func eat() :
    emit_signal("atePlant")
    retreat()

func attack() :
    auxSpeed = speed
    state = State.ATTACKING

func retreat() :
    scale.x = -1
    state = State.RETREATING
    
func resetPos() :
    state = State.IDLE
    scale.x = 1

func _on_VisibilityNotifier2D_screen_exited():
    onScreen = false
    resetPos()
    emit_signal("exitedScreen")

func _on_VisibilityNotifier2D_screen_entered():
    onScreen = true
