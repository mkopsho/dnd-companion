class Spell
  extend Omniscience::ClassMethods

  attr_accessor :name, :description, :higher_level, :range, :components, :materials, :casting_time, :duration, :level, :klasses, :school

  @@all = []

  def initialize(attrs)
    attrs.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_all(url)
    spells = urls(url)
    spells_tableau = spells.map { |spell| API.new(spell).parse_json }
    spells_tableau.each do |tableau|
      Spell.new(name: tableau["name"], description: tableau["desc"].join, range: tableau["range"], components: tableau["components"], materials: tableau["material"], casting_time: tableau["casting_time"], duration: tableau["duration"], level: tableau["level"], school: tableau["school"]["name"], klasses: tableau["classes"].map { |klass| klass["name"] })
    end
  end
end
