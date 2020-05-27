class Spell
  attr_accessor :name, :description, :higher_level, :range, :components, :materials, :casting_time, :duration, :ritual, :concentration, :level, :klasses, :school

  @@all = []

  def initialize(name = nil, description = nil, higher_level = nil, range = nil, components = nil, materials = nil, casting_time = nil, duration = nil, ritual = nil, concentration = nil, level = nil, klasses = nil, school = nil)
    @name = name
    @description = description
    @higher_level = higher_level
    @range = range
    @components = components
    @materials = materials
    @casting_time = casting_time
    @duration = duration
    @ritual = ritual
    @concentration = concentration
    @level = level
    @klasses = klasses
    @school = school
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.urls(url)
    spells_urls = []
    spells = API.new(url).parse_json
    spells_array = spells["results"]
    spells_array.each do |hash|
      spells_urls << url + hash["index"].downcase
    end
    spells_urls
  end

  def self.create_all(url)
    spells_tableau = []
    spells = urls(url)
    spells.each do |spell|
      spells_tableau << API.new(spell).parse_json
    end
    spells_tableau.each do |tableau|
      name = tableau["name"]
      description = tableau["desc"].join
      higher_level = tableau["higher_level"]
      range = tableau["range"]
      components = tableau["components"]
      materials = tableau["material"]
      casting_time = tableau["casting_time"]
      duration = tableau["duration"]
      ritual = tableau["ritual"]
      concentration = tableau["concentration"]
      level = tableau["level"].to_s
      school = tableau["school"]["name"]
      klasses = []
      tableau["classes"].each { |klass| klasses << klass["name"] }
      Spell.new(name, description, higher_level, range, components, materials, casting_time, duration, ritual, concentration, level, klasses, school)
    end
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
