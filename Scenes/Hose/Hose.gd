extends KinematicBody2D

const Y_OUT = -30
enum State{ IDLE, ENTERING, EXITING, POURING }

export var speed = 100000

var state = State.IDLE
var velocity := Vector2()

func _physics_process( delta: float ):
    if state == State.ENTERING and position.y < 1800 :
        move_and_slide( velocity * delta )
        
    if state == State.EXITING :
        if position.y > Y_OUT :
            move_and_slide( velocity * delta )
        else :
            state = State.IDLE
            position.y = Y_OUT

func startDigging( pos: Vector2 ) :
    if state != State.IDLE :
        return
    position.x = pos.x
    state = State.ENTERING
    velocity = Vector2( 0, 1 ) * speed
    
func pourWater( tunnel ):
    if state == State.ENTERING:
        state = State.POURING
        $Position2D.start_pouring()
        tunnel.pourWater( position )
    
func exit():
    $Position2D.stop_pouring()
    state = State.EXITING
    velocity = Vector2( 0, -1 ) * speed
