# coding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'webmock/rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each{|f| require f }

Dir[File.join(File.dirname(__FILE__), "..", "lib", "**/*.rb")].each{|f| require f }

RSpec.configure do |config|
end

def fixture(name)
  path = Pathname(File.dirname(__FILE__)) + 'fixtures' + name
  File.open(path, &:read)
end

