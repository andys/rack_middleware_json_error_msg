require 'echoe'

Echoe.new("rack_middleware_json_error_msg") do |p|
  p.author = "Andrew Snow"
  p.email = 'andrew@modulus.org'
  p.summary = "Rails middleware to catch JSON parse errors and return error in JSON format"
  p.url = "https://github.com/andys/rack_middleware_json_error_msg"
  p.runtime_dependencies = ['railties']
  p.development_dependencies = ['minitest', 'rake']
end

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.verbose = true
end

task default: :test
