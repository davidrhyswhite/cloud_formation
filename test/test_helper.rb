require 'minitest/autorun'
require 'minitest/pride'
require 'cloud_formation'
require 'json'

def load_fixture path
  JSON.parse File.read("test/templates/#{path}.json")
end
