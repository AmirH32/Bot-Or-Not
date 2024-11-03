extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass


var num_bamboozled: int = 0


signal die


func on_death():
    die.emit()

func on_bamboozle():
    num_bamboozled += 1