extends Area2D

@export var proximo_mundo # (String, FILE,"*.tscn")

func _physics_process(delta):
	var corpos = get_overlapping_bodies()
	
	for corpo in corpos:
		if corpo.name == "Jogador":
			get_tree().change_scene_to_file(proximo_mundo)
	pass
