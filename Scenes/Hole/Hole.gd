extends Node2D

signal holeSelected( pos )
signal holeReleased()

onready var button := $Button

func _on_Button_button_down():
    emit_signal("holeSelected", position + Vector2( button.rect_size.x / 2 + button.rect_position.x, 0 ) )


func _on_Button_button_up():
    emit_signal("holeReleased")
