class API
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def parse_json
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
