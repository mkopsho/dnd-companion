class Character
  BASE_URL = "http://www.dnd5eapi.co"
  
  attr_accessor :name, :level, :ability_scores, :skills, :proficiencies, :klass, :race

  @@all = []

  def initialize(name = nil, level = 1)
    @name = name
    @level = level
  end

  #choose a race (traits)
  #choose a klass (level, hp, hd, prof)
  #ability scores
  #describe
  #equipment (ac, weapons)
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
      k == "speed" || k == "ability_bonuses" || k == "size" || k == "starting_proficiencies" || k == "languages" || k == "traits"
    end

    klass_attrs = klass_object.each do |k, v|
      puts k
    end
  end

  def character(name)
  end
end