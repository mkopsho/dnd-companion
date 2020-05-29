class Condition
  extend Memorable::ClassMethods
  
  attr_accessor :name, :description
  
  @@all = []

  def initialize(name = nil, description = nil)
    @name = name
    @description = description
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.create_all(url)
    conditions = urls(url)
    conditions_tableau = conditions.map do |condition|
      API.new(condition).parse_json
    end
    conditions_tableau.each do |tableau|
      name = tableau["name"]
      description = tableau["desc"]
      Condition.new(name, description)
    end
  end
end
