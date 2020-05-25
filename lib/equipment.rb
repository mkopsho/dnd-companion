class Equipment
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def get_all(url)
    conditions = API.new(url).parse_json
    conditions.each { |k| puts k }
  end
end
