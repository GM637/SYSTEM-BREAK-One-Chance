extends Sprite

signal clicked

func kill():
	frame = 1
	$Text.text = "HACKED OPEN >;P"
	$Click.play()
	emit_signal("clicked")
	for n in get_child_count() :
		if get_child(n).has_method("open") :
			get_child(n).open()
