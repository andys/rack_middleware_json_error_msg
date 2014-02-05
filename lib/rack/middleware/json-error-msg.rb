require 'json-error-msg/railtie' if defined?(Rails)

module Rack
  module Middleware
    class JsonErrorMsg
      class Error < StandardError; end

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          @app.call(env)
        rescue ActionDispatch::ParamsParser::ParseError => error
          if env['HTTP_ACCEPT'] =~ /json/
            error_output = "There was a problem in the request you submitted: #{error}"
            return [
              400, { 'Content-Type' => 'application/json' },
              [ { request_id: env['action_dispatch.request_id'], error: error_output }.to_json ]
            ]
          else
            raise error
          end
        end
      end
    end
  end
end

