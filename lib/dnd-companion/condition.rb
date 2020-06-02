class Condition
  extend Omniscience::ClassMethods

  attr_accessor :name, :description
  
  @@all = []

  def initialize(attrs)
    attrs.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_all(url)
    conditions = urls(url)
    conditions_tableau = conditions.map { |condition| API.new(condition).parse_json }
    conditions_tableau.each do |tableau|
      Condition.new(name: tableau["name"], description: tableau["desc"])
    end
  end
end
