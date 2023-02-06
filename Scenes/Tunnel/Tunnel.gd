#tool
extends Node2D

enum State { ATTACKING, ON_FLOWER, RETREATING, IDLE, INTERCEPTED }

signal finishedAttack
signal atePlant

var aux := 0

export var distance = 800

var state = State.IDLE
var speed = 300

onready var body := $Body
onready var rabbit := $Body/Rabbit

signal bodyEntered( tunnel, body )

func _ready() :
    rabbit.speed = speed
    resetPos()

func _physics_process(delta):
    editorProcess()
    runningPProcess( delta )

func editorProcess() :
    if Engine.editor_hint :
        body.position.x = -distance

func runningPProcess( delta: float ) :
    if Engine.editor_hint :
        return
    if state == State.ATTACKING :
        if body.position.x >= -25 :
            body.position.x = -25
            state = State.ON_FLOWER
            printt( rabbit.position )
            rabbit.attack()
        else:
            body.position.x += speed * delta
    elif state == State.RETREATING :
        if body.position.x <= -distance :
            aux += 1 ; print( aux )
            resetPos()
            emit_signal("finishedAttack")
        else :
            body.position.x -= speed * 4 * delta

func resetPos() :
    state = State.IDLE
    body.position.x = -distance
    rabbit.position.x = -450

func attack() :
    state = State.ATTACKING
    
func retreat() :
    state = State.RETREATING

func pourWater( pos: Vector2 ) :
    if is_instance_valid( rabbit ) :
        if rabbit.global_position.y > pos.y :
            $Timer.start()

func setSpeed( newSpeed: float ) :
    speed = newSpeed
    rabbit.speed = newSpeed

func _on_Area2D_body_entered( body_ ):
    emit_signal( "bodyEntered", self, body_ )

func _on_Rabbit_exitedScreen():
    retreat()

func _on_Rabbit_atePlant():
    emit_signal("atePlant")

func _on_Timer_timeout():
    state = State.INTERCEPTED
    rabbit.retreat()
    pass
