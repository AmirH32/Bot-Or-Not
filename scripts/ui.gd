extends Control


var levels := {
	"Level 1": "level_1",
	"Level 2": "level_2",
	"Level 3": "level_3",
	"Level 4": "level_4"
}

signal open_level(level_file_name: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	activate_level_select()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	$TitleScreen.hide()
	# $GamemodeSelect.show()
	$LevelSelect.show()
	


func _on_survival_pressed():
	pass # Replace with function body.


func _on_escape_pressed():
	$GamemodeSelect.hide()
	$LevelSelect.show()

func activate_level_select():
	for level_name in levels.keys():
		var button = Button.new()
		button.text = level_name
		button.pressed.connect(select_level.bind(levels[level_name]))
		$LevelSelect/VBoxContainer/ScrollContainer/VBoxContainer.add_child(button)

func select_level(level_filename: String):
	$LevelSelect.hide()
	open_level.emit(level_filename)


func _on_level_select_pressed():
	$WinScreen.hide()
	$DeathScreen.hide()
	$LevelSelect.show()

func win():
	$WinScreen.show()

func die():
	$DeathScreen.show()
