require 'minitest/autorun'
require 'minitest/pride'
require 'cloud_formation'
require 'json'

require 'factories/factory_helpers'

include FactoryHelpers

def load_fixture path
  JSON.parse File.read("test/templates/#{path}.json")
end
