require "net/http"
require "open-uri"
require "json"
require "pry"

class API
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def get_response_body
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def parse_json
    JSON.parse(self.get_response_body)
  end
end

#conditions = API.new("http://www.dnd5eapi.co/api/conditions/")
#spells = API.new("http://www.dnd5eapi.co/api/spells/")
#equipment = API.new("http://www.dnd5eapi.co/api/equipment/")
#binding.pry
