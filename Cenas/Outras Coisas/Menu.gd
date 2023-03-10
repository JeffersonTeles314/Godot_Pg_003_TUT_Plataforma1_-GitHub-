extends Control


func _on_Comear_pressed():
	get_tree().change_scene_to_file("res://Cenas/Fases/Mundo1.tscn")
	pass # Replace with function body.


func _on_Sair_pressed():
	get_tree().quit
	pass # Replace with function body.
