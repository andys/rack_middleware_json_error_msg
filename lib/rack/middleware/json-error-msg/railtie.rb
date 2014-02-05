module Rack
  module Middleware
    module JsonErrorMsg
      class Railtie < Rails::Railtie
        initializer "json-error-msg.configure_rails_initialization" do |app|
          app.middleware.insert_before ActionDispatch::ParamsParser, "Rack::Middleware::JsonErrorMsg::JsonErrorMsg"
        end
      end
    end
  end
end
