extends ScrollContainer

var swiping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []

func _input(ev):
	if ev is InputEventMouseButton and get_local_mouse_position().x < size.x and get_local_mouse_position().y < size.y and get_local_mouse_position().x > 0 and get_local_mouse_position().y > 0:
		if ev.pressed:
			swiping = true
			swipe_start = Vector2(get_h_scroll(), get_v_scroll())
			swipe_mouse_start = ev.position
			swipe_mouse_times = [Time.get_ticks_msec()]
			swipe_mouse_positions = [swipe_mouse_start]
		else :
			swipe_mouse_times.append(Time.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			var source = Vector2(get_h_scroll(), get_v_scroll())
			var idx = swipe_mouse_times.size() - 1
			var now = Time.get_ticks_msec()
			var cutoff = now - 100
			for i in range(swipe_mouse_times.size() - 1, - 1, - 1):
				if swipe_mouse_times[i] >= cutoff:idx = i
				else :break
			var flick_start = swipe_mouse_positions[idx]
			var flick_dur = min(0.3, (ev.position - flick_start).length() / 1000)
			if flick_dur > 0.0:
				var tween = Tween.new()
				add_child(tween)
				var delta = ev.position - flick_start
				var target = source - delta * flick_dur * 15.0
				tween.interpolate_method(self, "set_h_scroll", source.x, target.x, flick_dur, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_method(self, "set_v_scroll", source.y, target.y, flick_dur, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.interpolate_callback(tween, flick_dur, "queue_free")
				tween.start()
			swiping = false
	elif swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
		set_h_scroll(swipe_start.x - delta.x)
		set_v_scroll(swipe_start.y - delta.y)
		swipe_mouse_times.append(Time.get_ticks_msec())
		swipe_mouse_positions.append(ev.position)
