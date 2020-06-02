class Equipment
  extend Omniscience::ClassMethods

  attr_accessor :name, :equipment_category, :category_range, :cost, :damage, :range, :weight, :props, :armor_class, :armor_category

  @@all = []

  def initialize(attrs)
    attrs.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_all(url)
    equipment = urls(url)
    equipment_tableau = equipment.map { |equipment| API.new(equipment).parse_json }
    equipment_tableau.each do |tableau|
      if tableau["damage"] != nil
        damage_value = tableau["damage"]["damage_dice"] + " " + tableau["damage"]["damage_type"]["name"]
      end
      if tableau["range"] != nil
        range_value = tableau["range"]["normal"].to_s 
        if tableau["range"]["long"] != nil
          range_value = tableau["range"]["normal"].to_s + "/" + tableau["range"]["long"].to_s
        end
      end
      if tableau["properties"] != nil
        props_value = tableau["properties"].map { |prop| prop["name"] }
      end
      if tableau["armor_class"] != nil
        armor_class_value = tableau["armor_class"]["base"].to_s
      end
      if tableau["armor_category"] != nil
        armor_category_value = tableau["armor_category"]
      end
      Equipment.new(name: tableau["name"], equipment_category: tableau["equipment_category"], category_range: tableau["category_range"], cost: tableau["cost"]["quantity"].to_s + tableau["cost"]["unit"], damage: damage_value, range: range_value, weight: tableau["weight"], props: props_value, armor_class: armor_class_value, armor_category: armor_category_value)
    end
  end
end
