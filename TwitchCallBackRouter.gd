class_name TwitchCallBackRouter extends HttpRouter

# Handle a GET request
func handle_get(request: HttpRequest, response: HttpResponse) -> void:
	response.send(200, "Response aquired")
	twitch_response.emit(request)

signal twitch_response(request )
