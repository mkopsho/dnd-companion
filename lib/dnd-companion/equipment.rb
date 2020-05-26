class Equipment
  attr_accessor :name, :equipment_category, :category_range, :cost, :damage, :range, :weight, :props

  @@all = []

  def initialize(name = nil, equipment_category = nil, category_range = nil, cost = nil, damage = nil, range = nil, weight = nil, props = nil)
    @name = name
    @equipment_category = equipment_category
    @category_range = category_range
    @cost = cost
    @damage = damage
    @range = range
    @weight = weight
    @props = props
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.urls(url)
    equipment_urls = []
    equipment = API.new(url).parse_json
    equipment_array = equipment["results"]
    equipment_array.each do |hash|
      equipment_urls << url + hash["index"].downcase
    end
    equipment_urls
  end

  def self.create_all(url)
    equipment_tableau = []
    equipment = urls(url)
    equipment.each do |equipment|
      equipment_tableau << API.new(equipment).parse_json
    end
    equipment_tableau.each do |tableau|
      name = tableau["name"]
      equipment_category = tableau["equipment_category"]
      category_range = tableau["category_range"] 
      cost = tableau["cost"]["quantity"].to_s + tableau["cost"]["unit"]
      if tableau["damage"] != nil
        damage = tableau["damage"]["damage_dice"] + " " + tableau["damage"]["damage_type"]["name"]
      end
      if tableau["range"] != nil
        range = tableau["range"]["normal"].to_s 
        if tableau["range"]["long"] != nil
          range = tableau["range"]["normal"].to_s + "/" + tableau["range"]["long"].to_s
        end
      end
      weight = tableau["weight"]
      if tableau["properties"] != nil
        props = []
        tableau["properties"].each { |prop| props << prop["name"] }
      end
      Equipment.new(name, equipment_category, category_range, cost, damage, range, weight, props)
    end
  end

  def self.get_all(url)
    equipment_names = []
    equipment = API.new(url).parse_json
    equipment_array = equipment["results"]
    equipment_array.each do |hash| 
      hash.collect do |key, value|
        if key == "name"
          equipment_names << value
        end
      end
    end
    equipment_names
  end
end