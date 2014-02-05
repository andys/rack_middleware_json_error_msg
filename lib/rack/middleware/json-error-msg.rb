
module Rack
  module Middleware
    class JsonErrorMsg
      class Error < StandardError; end

      if defined?(Rails)
        class Railtie < Rails::Railtie
          initializer "json-error-msg.configure_rails_initialization" do |app|
            app.middleware.insert_before ActionDispatch::ParamsParser, "Rack::Middleware::JsonErrorMsg"
          end
        end
      end

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

