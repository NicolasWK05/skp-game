extends Node

# We need to:
# 1. Share the world of the first viewport with the second viewport.
# 2. Create a remote transform attached to each player that pushes their position to the camera.
# This data structure helps us to do that conveniently. See the _ready() function below.
@onready var players := {
	"1": {
		viewport = $HBoxContainer2/SubViewportContainer/SubViewport,
		camera = $HBoxContainer2/SubViewportContainer/SubViewport/Player1Camera,
		player = $HBoxContainer2/SubViewportContainer/SubViewport/Game/Player1
	},
	"2": {
		viewport = $HBoxContainer2/SubViewportContainer2/SubViewport,
		camera = $HBoxContainer2/SubViewportContainer2/SubViewport/Player2Camera,
		player = $HBoxContainer2/SubViewportContainer/SubViewport/Game/Player2
	}
}

func _ready() -> void:
	# The world_2d object of the viewport contains information about what to
	# render. Here, it's our game level. We need to pass it from the first to
	# the second viewport for both of them to render the same level.
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	# For each player, we create a remote transform that pushes the character's
	# position to the corresponding camera.
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
