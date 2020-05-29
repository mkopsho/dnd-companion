class Spell
  extend Memorable::ClassMethods

  attr_accessor :name, :description, :higher_level, :range, :components, :materials, :casting_time, :duration, :ritual, :concentration, :level, :klasses, :school

  @@all = []

  def initialize(name = nil, description = nil, higher_level = nil, range = nil, components = nil, materials = nil, casting_time = nil, duration = nil, ritual = nil, concentration = nil, level = nil, klasses = nil, school = nil)
    #spell_hash
    #@name = spell_hash[:name]
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

  def self.create_all(url)
    spells = urls(url)
    spells_tableau = spells.map do |spell|
      API.new(spell).parse_json
    end
    #binding.pry
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
      klasses = tableau["classes"].map { |klass| klass["name"] }
      Spell.new(name, description, higher_level, range, components, materials, casting_time, duration, ritual, concentration, level, klasses, school)
    end
  end
end
