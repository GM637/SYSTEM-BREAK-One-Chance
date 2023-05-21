extends Sprite

func kill():
	if frame == 0 :
		frame = 1
		$Click.play()
		$Text.text = "! ON !"
		for n in get_child_count() :
			if get_child(n).has_method("open") :
				get_child(n).open()
		return
	if frame == 1 :
		frame = 0
		"- OFF -"
		$Click.play()
		for n in get_child_count() :
			if get_child(n).has_method("close") :
				get_child(n).close()
