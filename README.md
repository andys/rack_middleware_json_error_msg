### Rails rack middleware to catch JSON parse errors

Put this in your rails app's Gemfile:

    gem 'rack_middleware_json_error_msg'

If ActionDispatch::ParamsParser::ParseError gets thrown, it will send back a
HTTP 400 response with a JSON-format error message.

