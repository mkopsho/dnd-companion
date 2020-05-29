class Equipment
  extend Omniscience::ClassMethods

  attr_accessor :name, :equipment_category, :category_range, :cost, :damage, :range, :weight, :props, :armor_class, :armor_category

  @@all = []

  def initialize(name = nil, equipment_category = nil, category_range = nil, cost = nil, damage = nil, range = nil, weight = nil, props = nil, armor_class = nil, armor_category = nil)
    @name = name
    @equipment_category = equipment_category
    @category_range = category_range
    @cost = cost
    @damage = damage
    @range = range
    @weight = weight
    @props = props
    @armor_class = armor_class
    @armor_category = armor_category
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.create_all(url)
    equipment = urls(url)
    equipment_tableau = equipment.map do |equipment| { API.new(equipment).parse_json }
    equipment_tableau.each do |tableau|
      name = tableau["name"]
      equipment_category = tableau["equipment_category"]
      category_range = tableau["category_range"] 
      cost = tableau["cost"]["quantity"].to_s + tableau["cost"]["unit"]
      weight = tableau["weight"]
      if tableau["damage"] != nil
        damage = tableau["damage"]["damage_dice"] + " " + tableau["damage"]["damage_type"]["name"]
      end
      if tableau["range"] != nil
        range = tableau["range"]["normal"].to_s 
        if tableau["range"]["long"] != nil
          range = tableau["range"]["normal"].to_s + "/" + tableau["range"]["long"].to_s
        end
      end
      if tableau["properties"] != nil
        props = tableau["properties"].map { |prop| prop["name"] }
      end
      if tableau["armor_class"] != nil
        armor_class = tableau["armor_class"]["base"].to_s
      end
      if tableau["armor_category"] != nil
        armor_category = tableau["armor_category"]
      end
      Equipment.new(name, equipment_category, category_range, cost, damage, range, weight, props, armor_class, armor_category)
    end
  end
end
