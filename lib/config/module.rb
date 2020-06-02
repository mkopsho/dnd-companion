module Omniscience
  module ClassMethods
    def clear
      self.all.clear
    end

    def urls(url)
      uri_object = API.new(url).parse_json
      object_array = uri_object["results"]
      urls = object_array.map do |hash|
        url + hash["index"].downcase
      end
      urls
    end

    def get_all(url)
      uri_object = API.new(url).parse_json
      object_array = uri_object["results"]
      names = object_array.map do |hash|
        hash['name']
      end
      names
    end
  end
end