extends Node

var websocket_url :String
var session_id

var subscribed_to_channel :bool
var client_id :String
var client_secret :String
var socket = WebSocketPeer.new()
var access_token :String
@onready var http_request = $HTTPRequest
signal twitch_ready

func parse_data(data :Variant):
    if data["metadata"]["message_type"] == "session_welcome":
        session_id = data["payload"]["session"]["id"]
        print(session_id)

func _twitch_response(request):
    print(request)
    var headers = ["Authorization: Bearer { }".format(access_token), 
    "Client-Id: { }".format(client_id)]
    var url = "https://api.twitch.tv/helix/users?login=iomeanslife"
    http_request.request(url, headers, HTTPClient.METHOD_GET)

func _on_request_completed(response):
  print(response)
   # pass

# Called when the node enters the scene tree for the first time.
func _ready():
    #var headers = ["Content-Type: application/json"]
  
   
    #broadcaster_id=123456&moderator_id=654321")
#	http_request.request("https://api.twitch.tv/helix/chat/chatters?broadcaster_id=123456&moderator_id=654321")
    #'https://api.twitch.tv/helix/chat/chatters?broadcaster_id=123456&moderator_id=654321' \
#-H 'Authorization: Bearer kpvy3cjboyptmiacwr0c19hotn5s' \
#-H 'Client-Id: hof5gwx0su6owfn0nyan9c87zr6t'


    http_request.request_completed.connect(_on_request_completed)
    
    var server = HttpServer.new()
    var router =  TwitchCallBackRouter.new()
    router.twitch_response.connect(_twitch_response)
    server.port = 3000
    server.register_router("/", router )
    add_child(server)
    server.start()

    #client_id = "qgmf0q1vpsnljxxlq654nr17rm2jcq"
    #client_secret = "dy14juq80tog0o9l3qo6d7id51hylc"
    #websocket_url =  "wss://eventsub.wss.twitch.tv/ws"
    #var err = socket.connect_to_url(websocket_url)
    #if !err == OK:
        #print("unable to connect")
        #set_process(false)
    #else:
        #await get_tree().create_timer(2).timeout
    
    # socket.send_text("text")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if access_token != "" && access_token != null:
        $HTTPRequest.request("https://api.github.com/repos/godotengine/godot/releases/latest")

    
    pass
    #socket.poll()
    #var state = socket.get_ready_state()
    #
    #match state:
        #WebSocketPeer.STATE_OPEN:
            #while socket.get_available_packet_count():
                #var dataText = socket.get_packet().get_string_from_utf8()
                #var json_data = JSON.parse_string(dataText)
                #print("got data from server: ",dataText)
                #parse_data(json_data)
            #
            #
            #if !subscribed_to_channel:
                ## socket.send_text("{\"type\":\"channel.fo\"1\",}")
                #var message = """{
                    #"type": "channel.follow",
                    #"version": "2",
                    #"condition": {
                    #"broadcaster_user_id": "1337",
                    #"moderator_user_id": "1337"
                    #},
                    #"transport": {
                    #"method": "websocket",
                     #"session_id": "{id}"
                    #}
                #}""".format(([["id",session_id]]))
#
                ##socket.send_text(message)
        #
            #pass
        #WebSocketPeer.STATE_CLOSING:
            #pass
        #WebSocketPeer.STATE_CLOSED:
            #var code = socket.get_close_code()
            #print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
            #set_process(false) # Stop processing.
    #

        
        
        
        
        
        
        
        
        
#https://dev.twitch.tv/docs/eventsub/eventsub-reference/#conditions:~:text=Channel%20Follow%20Condition

#// User acces token apis:
#https://dev.twitch.tv/docs/api/reference/#get-chatters
#https://dev.twitch.tv/docs/api/reference/#get-channel-followers
#https://dev.twitch.tv/docs/api/reference/#get-user-chat-color


#https://dev.twitch.tv/docs/authentication/getting-tokens-oauth/#device-code-grant-flow
