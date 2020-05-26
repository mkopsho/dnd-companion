class Character
  BASE_URL = "http://www.dnd5eapi.co"
  
  attr_accessor :name, :level, :race, :klass, :ability_scores, :skills, :proficiencies, :ac

  @@all = []

  def initialize(name = nil, level = 1)
    @name = name
    @level = level
  end

  def race_urls(race_url)
    races_urls = []
    races = API.new(race_url).parse_json
    races_array = races["results"]
    races_array.each do |hash|
      races_urls << race_url + hash["index"].downcase
    end
  end

  def klass_urls(klass_url)
    klasses_urls = []
    klasses = API.new(klass_url).parse_json
    klasses_array = klasses["results"]
    klasses_array.each do |hash|
      klasses_urls << klass_url + hash["index"].downcase
    end
  end

  def random_character(name, race_url, klass_url)
    race = race_urls(race_url).sample["url"] #Get a random race
    klass = klass_urls(klass_url).sample["url"] #Get a random class

    race_url = BASE_URL + race
    klass_url = BASE_URL + klass

    race_object = API.new(race_url).parse_json
    klass_object = API.new(klass_url).parse_json

    race_attrs = race_object.select do |k, v|
      k == "name" || k == "speed" || k == "ability_bonuses" || k == "size" || k == "starting_proficiencies" || k == "languages" || k == "traits"
    end
    race_attrs["race_name"] = race_attrs.delete "name" #Updating the :name key to prevent duplicates on merge with `klass_attrs`

    klass_attrs = klass_object.select do |k, v|
      k == "name" || k == "hit_die" || k == "proficiencies" || k == "saving_throws" || k == "starting_equipment"
    end
    klass_attrs["class_name"] = klass_attrs.delete "name" #Same here!

    hash = race_attrs.merge(klass_attrs)
    binding.pry
  end
end
