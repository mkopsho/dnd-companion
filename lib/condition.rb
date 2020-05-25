class Condition
  attr_accessor :name
  
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.get_all(url)
    conditions = API.new(url).parse_json
    puts conditions
  end
end
