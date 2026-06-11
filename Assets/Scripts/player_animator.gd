extends Node2D

@export var player_controller: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Miroir du sprite verticalement en fonction de la direction du Player
	if player_controller.direction == 1:
		sprite.flip_h = false
		sprite.offset.x = 0
	elif player_controller.direction == -1:
		sprite.flip_h = true
		sprite.offset.x = -23
	
	# Fait jouer l'animation de course si le Player est en mouvement
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("move")
	else:
		animation_player.play("idle")
	
	# Joue l'animation du saut
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
		
