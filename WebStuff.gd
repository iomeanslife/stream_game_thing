extends Node

@export var websocket_url = "wss://eventsub.wss.twitch.tv/ws"

var socket = WebSocketPeer.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	var err = socket.connect_to_url(websocket_url)
	if !err == OK:
		print("unable to connect")
		set_process(false)
	else:
		await get_tree().create_timer(2).timeout
	
	socket.send_text("text")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	
	match state:
		WebSocketPeer.STATE_OPEN:
			while socket.get_available_packet_count():
				print("got data from server: ",socket.get_packet().get_string_from_utf8())
			pass
		WebSocketPeer.STATE_CLOSING:
			pass
		WebSocketPeer.STATE_CLOSED:
			var code = socket.get_close_code()
			print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
			set_process(false) # Stop processing.
