class Character
  BASE_URL = "http://www.dnd5eapi.co"
  
  attr_accessor :name, :level, :race, :klass, :size, :speed, :proficiencies

  @@all = []

  def initialize(name = nil, level = 1, race = nil, klass = nil, size = nil, speed = nil, proficiencies = nil)
    @name = name
    @level = level
    @race = race
    @klass = klass
    @size = size
    @speed = speed
    @proficiencies = proficiencies
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
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
      k == "name" || k == "speed" || k == "size"
    end
    race_attrs["race_name"] = race_attrs.delete "name" #Updating the :name key to prevent duplicate keys on merge with `klass_attrs`

    klass_attrs = klass_object.select do |k, v|
      k == "name" || k == "proficiencies"
    end
    klass_attrs["class_name"] = klass_attrs.delete "name" #Same here as above!

    generator = klass_attrs.merge(race_attrs)
    race = generator["race_name"]
    klass = generator["class_name"]
    size = generator["size"]
    speed = generator["speed"]
    proficiency = generator["proficiencies"]
    proficiencies = []
    proficiency.select do |prof|
      proficiencies << prof["name"]
    end
    Character.new(name, level, race, klass, size, speed, proficiencies)
  end
end
