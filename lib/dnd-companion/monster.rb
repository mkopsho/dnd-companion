class Monster
  extend Omniscience::ClassMethods

  attr_accessor :name, :size, :ac, :hp, :speed, :cr, :actions, :reactions, :legendary_actions, :special_abilities

  @@all = []

  def initialize(attrs)
    attrs.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_all(url)
    monster = urls(url)
    monster_tableau = monster.map { |monster| API.new(monster).parse_json }
    monster_tableau.each do |tableau|
      if tableau["actions"] != nil
        actions_value = tableau["actions"].map do |action|
          action["name"] + ": " + action["desc"]
        end
      end
      if tableau["reactions"] != nil
        reactions_value = tableau["reactions"].map do |reaction|
          reaction["name"] + ": " + reaction["desc"]
        end
      end
      if tableau["special_abilities"] != nil
        special_abilities_value = tableau["special_abilities"].map do |special|
          special["name"] + ": " + special["desc"]
        end
      end
      if tableau["legendary_actions"] != nil
        legendary_actions_value = tableau["legendary_actions"].map do |legendary|
          legendary["name"] + ": " + legendary["desc"]
        end
      end
      Monster.new(name: tableau["name"], size: tableau["size"], ac: tableau["armor_class"].to_s,
      hp: tableau["hit_points"].to_s, speed: tableau["speed"], cr: tableau["challenge_rating"],
      actions: actions_value, reactions: reactions_value, legendary_actions: legendary_actions_value,
      special_abilities: special_abilities_value)
    end
  end
end
