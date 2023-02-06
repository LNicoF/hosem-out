extends Control

func setPts( pts : int ) :
    $Pts.text += String( pts )

func _on_Play_pressed():
    var err = get_tree().change_scene("res://Scenes/Main/Main.tscn")
    if err != 0 :
        print( "ERROR: ", err )
