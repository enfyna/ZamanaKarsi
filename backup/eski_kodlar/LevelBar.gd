extends TextureProgressBar

var anlikxp =  Global.Save.get_save()["oyuncu"]["xp"]
@onready var label = $Label

func _ready():
	label.text = str( Global.Save.get_save()["oyuncu"]["lvl"])
	value = anlikxp
	renk()

func xparttir():
	if not label.text == str( Global.Save.get_save()["oyuncu"]["lvl"]):
		label.text = str( Global.Save.get_save()["oyuncu"]["lvl"])
		$levelup.play()
		renk()
	var tween : Tween = create_tween()
	tween.tween_property(
		self, "anlikxp",  Global.Save.get_save()["oyuncu"]["xp"], 0.25
	).set_trans(Tween.TRANS_LINEAR)

func _on_Tween_tween_step(_object, _key, _elapsed, _value):
	value = anlikxp
	pass

func _on_Tween_tween_completed(_object, _key):
	anlikxp =  Global.Save.get_save()["oyuncu"]["xp"]
	pass

func renk():
	if int( Global.Save.get_save()["oyuncu"]["lvl"]) < 10:
		tint_progress = Color(1, 1, 1, 1)
		$Label.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	elif int( Global.Save.get_save()["oyuncu"]["lvl"]) < 25:
		tint_progress = Color(0.6, 0.2, 0, 1)
		$Label.add_theme_color_override("font_color", Color(0.6, 0.2, 0, 1))
	elif int( Global.Save.get_save()["oyuncu"]["lvl"]) < 50:
		tint_progress = Color(0.6, 0.6, 0.6, 1)
		$Label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))
	elif int( Global.Save.get_save()["oyuncu"]["lvl"]) < 100:
		tint_progress = Color(1, 1, 0, 1)
		$Label.add_theme_color_override("font_color", Color(1, 1, 0, 1))
	elif int( Global.Save.get_save()["oyuncu"]["lvl"]) < 500:
		tint_progress = Color(0, 1, 1, 1)
		$Label.add_theme_color_override("font_color", Color(0, 1, 1, 1))
	else :
		tint_progress = Color(0.6, 0, 1, 1)
		$Label.add_theme_color_override("font_color", Color(0.6, 0, 1, 1))