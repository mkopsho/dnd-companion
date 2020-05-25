class Condition
  attr_accessor :name
  
  @@all = []

  def initialize
    @@all << self
  end

  def self.get_all(url)
    conditions = API.new(url).parse_json
    condition_names = []
    conditions_array = conditions["results"]
    conditions_array.each do |hash| 
      hash.collect do |key, value|
        if key == "name"
          condition_names << value
        end
      end
    end
    condition_names
  end
end
