class Spell

  @@all = []

  def initialize
    @@all << self
  end

  def self.get_all(url)
    spell_names = []
    spells = API.new(url).parse_json
    spells_array = spells["results"]
    spells_array.each do |hash| 
      hash.collect do |key, value|
        if key == "name"
          spell_names << value
        end
      end
    end
    spell_names
  end
end
