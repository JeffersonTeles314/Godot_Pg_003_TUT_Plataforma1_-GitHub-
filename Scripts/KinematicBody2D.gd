extends CharacterBody2D
@onready var Coyote_Jumping_Timer = $"Coyote_Jumping_Timer"


const cima = Vector2(0, -1)
const gravidade = 10
const Aceleracao = 50
const pulo = -400
const Velocidade_Max = 500
var movimento = Vector2()
func _physics_process(_delta):
	
	#=-=-=Código Gravidade=-=-=
	movimento.y += gravidade
	#=-=-=Código Gravidade=-=-=
	
	#=-=-=Codigo Mov.Direita=-=--=
	if Input.is_action_pressed("Ir_Dir"):
		movimento.x = min(movimento.x + Aceleracao , Velocidade_Max)
		$Sprite2D.flip_h = false
		if  is_on_floor() == true:
			$Sprite2D.play("Correndo")
	#=-=-=Codigo Mov.Direita=-=--=
	
	#=-=-=Codigo Mov.Esquerda=-=-=
	elif Input.is_action_pressed("Ir_Esq"):
		movimento.x = max(movimento.x - Aceleracao , -Velocidade_Max)
		$Sprite2D.flip_h = true
		if  is_on_floor() == true:
			$Sprite2D.play("Correndo")
	#=-=-=Codigo Mov.Esquerda=-=-=
	
	#=-=-=Codigo Parado=-=-=
	else:
		$Sprite2D.play("Parado")
	#=-=-=Codigo Parado=-=-=
	
	#=-=-=Código Atrito=-=-=
	if is_on_floor():
		movimento.x = lerp(movimento.x, 0.0, 0.2)
	else:
		movimento.x = lerp(movimento.x, 0.0, 0.08)
	#=-=-=Código Atrito=-=-=
	
	#=-=-=Código de Pulo=-=-=
	if (Coyote_Jumping_Timer.time_left > 0.0 or is_on_floor()) and Input.is_action_pressed("Pular"):
		movimento.y = pulo
		get_node("Sprite2D").play("Pulando")
	if not is_on_floor() and movimento.y > 0:
		get_node("Sprite2D").play("Caindo")
	elif not is_on_floor() and movimento.y < 0:
		get_node("Sprite2D").play("Pulando")
	#=-=-=Código de Pulo=-=-=
	
	set_velocity(movimento)
	set_up_direction(cima)
	
	#=-=-=Pulo do Coyote - (Parte 1)=-=-=
	#Essa Parte Vem Antes do "Move_and_Slide
	var is_onchao = is_on_floor()
	#=-=-=Pulo do Coyote - (Parte 1)=-=-=
	
	move_and_slide()
	
	#=-=-=Pulo do Coyote - (Parte 2)=-=-=
	#Essa Parte Vem Depois do "Move_and_Slide
	var just_left_dochao = is_onchao and not is_on_floor() and velocity.y >= 0
	if just_left_dochao:
		Coyote_Jumping_Timer.start()
	#=-=-=Pulo do Coyote - (Parte 2)=-=-=
	
	
	movimento = velocity
	pass
