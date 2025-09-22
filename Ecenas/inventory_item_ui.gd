class_name InventoryItemUI extends Panel

signal inventory_item_used(item_type:Item.ItemType)

var item_type: Item.ItemType

func initialize(type:Item.ItemType, texture:CompressedTexture2D, quantity:int):
	item_type = type
	$TextureRect.texture = texture
	$Label.text = str(quantity)
	
func set_quantity(quantity:int):
	$Label.text = str(quantity)

func _input(event):  
	if event is InputEventMouseButton and event.is_released():
		if mouse_over:
			inventory_item_used.emit(item_type)

var mouse_over:bool = false

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false
