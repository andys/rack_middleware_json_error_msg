require 'minitest/unit'
require 'json'
require 'minitest/autorun'  
require "rack/test"
require "#{File.dirname(__FILE__)}/../lib//rack/middleware/json-error-msg"

module ActionDispatch
  module ParamsParser
    class ParseError < Exception
    end
  end
end

class TestJsonErrorMsg < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def test_error
    app = proc { raise ActionDispatch::ParamsParser::ParseError.new("parse error") }
    request = Rack::MockRequest.new(Rack::Middleware::JsonErrorMsg.new(app))
    response = request.get('/', {'HTTP_ACCEPT' => 'application/json'})
    assert_equal 400, response.status
    assert_match /parse error/, response.body
  end
  
  def test_no_error
    app = proc { [200, {}, ['']] }
    request = Rack::MockRequest.new(Rack::Middleware::JsonErrorMsg.new(app))
    response = request.get('/', {'HTTP_ACCEPT' => 'application/json'})
    assert_equal 200, response.status
  end

  def test_non_json
    app = proc { raise ActionDispatch::ParamsParser::ParseError.new("parse error") }
    request = Rack::MockRequest.new(Rack::Middleware::JsonErrorMsg.new(app))
    assert_raises(ActionDispatch::ParamsParser::ParseError) do
      request.get('/')
    end
  end

end

