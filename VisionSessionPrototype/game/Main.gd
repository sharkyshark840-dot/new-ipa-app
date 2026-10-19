extends Node2D

const SCREEN_HOME := 0
const SCREEN_NOTICE := 1
const SCREEN_FOLLOW := 2
const SCREEN_DISTANCE := 3
const SCREEN_COMPLETE := 4
const SESSION_SECONDS := 18.0
const SYMBOLS := ["C", "E", "F", "H", "K", "P", "T", "V", "Z"]

var screen := SCREEN_HOME
var chosen_session := ""
var session_time := 0.0
var distance_index := 0
var dot_position := Vector2.ZERO
var dot_points := [Vector2(0.2, 0.3), Vector2(0.78, 0.28), Vector2(0.66, 0.62), Vector2(0.3, 0.72), Vector2(0.5, 0.42)]

func _ready() -> void:
	queue_redraw()

func _process(delta: float) -> void:
	if screen == SCREEN_FOLLOW:
		session_time += delta
		update_dot_position()
		if session_time >= SESSION_SECONDS:
			finish_session()
	queue_redraw()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		handle_tap(event.position)
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		handle_tap(event.position)

func handle_tap(tap: Vector2) -> void:
	if screen == SCREEN_HOME:
		if button_rect(0).has_point(tap):
			chosen_session = "Follow the dot"
			screen = SCREEN_NOTICE
		elif button_rect(1).has_point(tap):
			chosen_session = "See far away"
			screen = SCREEN_NOTICE
	elif screen == SCREEN_NOTICE:
		if button_rect(2).has_point(tap):
			start_session()
		elif button_rect(3).has_point(tap):
			screen = SCREEN_HOME
	elif screen == SCREEN_FOLLOW:
		if button_rect(4).has_point(tap):
			finish_session()
	elif screen == SCREEN_DISTANCE:
		if button_rect(5).has_point(tap):
			distance_index += 1
			if distance_index >= SYMBOLS.size():
				finish_session()
		elif button_rect(4).has_point(tap):
			finish_session()
	elif screen == SCREEN_COMPLETE:
		if button_rect(6).has_point(tap):
			screen = SCREEN_HOME

func start_session() -> void:
	session_time = 0.0
	distance_index = 0
	if chosen_session == "Follow the dot":
		screen = SCREEN_FOLLOW
	else:
		screen = SCREEN_DISTANCE

func finish_session() -> void:
	screen = SCREEN_COMPLETE

func update_dot_position() -> void:
	var viewport := get_viewport_rect().size
	var cycle := fmod(session_time / SESSION_SECONDS * float(dot_points.size()), float(dot_points.size()))
	var index := int(floor(cycle))
	var next_index := (index + 1) % dot_points.size()
	var blend := cycle - floor(cycle)
	dot_position = dot_points[index].lerp(dot_points[next_index], blend) * viewport

func button_rect(index: int) -> Rect2:
	var viewport := get_viewport_rect().size
	var width := viewport.x - 80.0
	match index:
		0: return Rect2(40, 330, width, 86)
		1: return Rect2(40, 436, width, 86)
		2: return Rect2(40, 875, width, 76)
		3: return Rect2(40, 973, width, 64)
		4: return Rect2(40, viewport.y - 112, width, 64)
		5: return Rect2(40, 770, width, 80)
		6: return Rect2(40, 875, width, 76)
	return Rect2()

func draw_button(rect: Rect2, label: String, accent := Color("4F46E5")) -> void:
	draw_style_box(make_box(accent, 18.0), rect)
	draw_string(ThemeDB.fallback_font, Vector2(rect.position.x, rect.position.y + rect.size.y * 0.61), label, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 28, Color.WHITE)

func make_box(color: Color, radius: float) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.corner_radius_top_left = int(radius)
	box.corner_radius_top_right = int(radius)
	box.corner_radius_bottom_left = int(radius)
	box.corner_radius_bottom_right = int(radius)
	return box

func text_line(text: String, y: float, size := 28, color := Color.WHITE) -> void:
	draw_string(ThemeDB.fallback_font, Vector2(40, y), text, HORIZONTAL_ALIGNMENT_LEFT, get_viewport_rect().size.x - 80, size, color)

func _draw() -> void:
	var viewport := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, viewport), Color("111827"))
	if screen == SCREEN_HOME:
		draw_home()
	elif screen == SCREEN_NOTICE:
		draw_notice()
	elif screen == SCREEN_FOLLOW:
		draw_follow()
	elif screen == SCREEN_DISTANCE:
		draw_distance()
	else:
		draw_complete()

func draw_home() -> void:
	text_line("Vision Session", 90, 46, Color("A5B4FC"))
	text_line("Adult-only visual-awareness prototype", 138, 24, Color("D1D5DB"))
	text_line("Choose a guided practice session.", 220, 28)
	draw_button(button_rect(0), "Follow the dot")
	draw_button(button_rect(1), "See far away", Color("0F766E"))
	text_line("No camera, microphone, or health data is saved.", 594, 22, Color("9CA3AF"))
	text_line("Not a diagnosis or an eye examination.", 630, 22, Color("FDE68A"))

func draw_notice() -> void:
	text_line(chosen_session, 90, 44, Color("A5B4FC"))
	text_line("Before you start", 168, 32)
	text_line("This is general awareness only.", 238, 27, Color("FDE68A"))
	text_line("It does not diagnose eye conditions or replace", 286, 24, Color("D1D5DB"))
	text_line("an eye examination. Stop if uncomfortable.", 322, 24, Color("D1D5DB"))
	if chosen_session == "Follow the dot":
		text_line("Keep the screen comfortable and follow the dot.", 410, 23)
	else:
		text_line("Move to your chosen distance and identify symbols.", 410, 23)
		text_line("Use the button to advance; answers are not scored.", 448, 23)
	draw_button(button_rect(2), "I understand — start")
	draw_button(button_rect(3), "Back", Color("374151"))

func draw_follow() -> void:
	text_line("Follow the dot", 80, 38, Color("A5B4FC"))
	text_line("Move your eyes comfortably. Stop if uncomfortable.", 122, 21, Color("D1D5DB"))
	var seconds_left := maxf(0.0, SESSION_SECONDS - session_time)
	text_line("Session time: %.0f seconds" % seconds_left, 166, 24)
	draw_circle(dot_position, 42.0, Color("FBBF24"))
	draw_circle(dot_position, 17.0, Color("1F2937"))
	draw_button(button_rect(4), "End session", Color("374151"))

func draw_distance() -> void:
	text_line("See far away", 80, 38, Color("5EEAD4"))
	text_line("At your chosen distance, identify the symbol.", 122, 21, Color("D1D5DB"))
	text_line("This prototype does not calculate a result.", 160, 21, Color("FDE68A"))
	draw_string(ThemeDB.fallback_font, Vector2(0, 470), SYMBOLS[distance_index], HORIZONTAL_ALIGNMENT_CENTER, get_viewport_rect().size.x, 210, Color.WHITE)
	text_line("Say it aloud if you want, then tap Continue.", 660, 22, Color("D1D5DB"))
	draw_button(button_rect(5), "Continue", Color("0F766E"))
	draw_button(button_rect(4), "End session", Color("374151"))

func draw_complete() -> void:
	text_line("Session complete", 130, 44, Color("A5B4FC"))
	text_line("Thanks for completing the guided session.", 228, 27)
	text_line("No diagnosis or clinical result was created.", 280, 24, Color("FDE68A"))
	text_line("If you have concerns about your vision, contact", 370, 23, Color("D1D5DB"))
	text_line("a qualified eye-care professional.", 406, 23, Color("D1D5DB"))
	draw_button(button_rect(6), "Return home")
