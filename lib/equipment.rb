class Equipment

  @@all = []

  def initialize
    @@all << self
  end

  def self.get_all(url)
    equipment_names = []
    equipment = API.new(url).parse_json
    equipment_array = equipment["results"]
    equipment_array.each do |hash| 
      hash.collect do |key, value|
        if key == "name"
          equipment_names << value
        end
      end
    end
    equipment_names
  end
end
