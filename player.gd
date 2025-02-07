extends CharacterBody2D

const speed: int = 100
const gravity: int = 30

func _process(delta):
	var direction = Input.get_vector("left","right","up","down")
	
func _physics_process(delta):
	if !is_on_floor():
		velocity.y = gravity
	if velocity.y > 500
	move_and_slide()
	
