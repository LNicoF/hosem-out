extends Node2D

var tunnelSpeed = 300
var speedIncFactor = 1.1
var selectedPlant

onready var ui := $UI
onready var hose := $Hose
onready var tunnels := $Tunnels.get_children()
onready var plants := $Plants.get_children()
onready var randGen := RandomNumberGenerator.new()

func _ready():
    applyTunnelSpeed()
    start()

func start() :
    ui.start()
    selectHole()

func applyTunnelSpeed() :
    for t in tunnels :
        t.setSpeed( tunnelSpeed )

func incrementSpeed() :
    tunnelSpeed *= speedIncFactor
    applyTunnelSpeed()

func selectHole() :
    plants = $Plants.get_children()
    var n := plants.size() - 1
    randGen.randomize()
    selectedPlant = randGen.randi_range( 0, n )
    var i = plants[ selectedPlant ].index
    tunnels[ i ].attack()
    incrementSpeed()

func _on_Hole_holeSelected( pos ):
    hose.startDigging( pos )

func _on_Hole_holeReleased():
    hose.exit()

func _on_Tunnel_bodyEntered(tunnel, body):
    if body == hose :
        hose.pourWater( tunnel )

func _on_Tunnel_finishedAttack():
    selectHole()

func _on_Tunnel_atePlant():
    plants[ selectedPlant ].eat()
    ui.takePlant()

#
# Water Code
#
