extends Node2D


enum RandomType {
	Random,
	Perlin
}

@export var size: Vector2i = Vector2i(10, 10)
@export var random_type: RandomType = RandomType.Random
@export var creature: PackedScene = null
@export var ncreatures: int = 1

@onready var water: TileMapLayer = $Water
@onready var ground: TileMapLayer = $Ground
@onready var trees: TileMapLayer = $Trees

var ground_tiles_ids = {
	"ground": Vector2i(1,1)
}

var water_tiles_ids = {
	"ground": Vector2i(0,0)
}

func _place_character(character: CharacterBody2D):
	character.global_position = Vector2(0,0)
	

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
