class Condition
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

  def self.urls(url)
    conditions_urls = []
    conditions = API.new(url).parse_json
    conditions_array = conditions["results"]
    conditions_array.each do |hash|
      conditions_urls << url + hash["name"].downcase
    end
    conditions_urls
  end

  def self.create_all(url)
    conditions_tableau = []
    conditions = urls(url)
    conditions.each do |condition|
      conditions_tableau << API.new(condition).parse_json
    end
    conditions_tableau.each do |tableau|
      name = tableau["name"]
      description = tableau["desc"]
      Condition.new(name, description)
    end
  end
    

#  def self.get_all(url)
#    condition_names = []
#    conditions = API.new(url).parse_json
#    conditions_array = conditions["results"]
#    conditions_array.each do |hash| 
#      hash.collect do |key, value|
#        if key == "name"
#          condition_names << value
#        end
#      end
#    end
#    condition_names
#  end
end
