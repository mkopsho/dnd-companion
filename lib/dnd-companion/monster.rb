class Monster
  extend Memorable::ClassMethods

  attr_accessor :name, :size, :ac, :hp, :hd, :speed, :cr, :actions, :reactions, :legendary_actions, :special_abilities

  @@all = []

  def initialize(name = nil, size = nil, ac = nil, hp = nil, hd = nil, speed = nil, cr = nil, actions = nil, reactions = nil, legendary_actions = nil, special_abilities = nil)
    @name = name
    @size = size
    @ac = ac
    @hp = hp
    @hd = hd
    @speed = speed
    @cr = cr
    @actions = actions
    @reactions = reactions
    @legendary_actions = legendary_actions
    @special_abilities = special_abilities
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def self.create_all(url)
    monster = urls(url)
    monster_tableau = monster.map do |monster|
      API.new(monster).parse_json
    end
    monster_tableau.each do |monster|
      name = monster["name"]
      size = monster["size"]
      ac = monster["armor_class"].to_s
      hp = monster["hit_points"].to_s
      hd = monster["hit_dice"]
      speed = monster["speed"]
      cr = monster["challenge_rating"].to_s
      legendary_actions = monster["legendary_actions"]
      if monster["actions"] != nil
        actions = monster["actions"].map do |action|
          action["name"] + ": " + action["desc"]
        end
      end
      if monster["reactions"] != nil
        reactions = monster["reactions"].map do |reaction|
          reaction["name"] + ": " + reaction["desc"]
        end
      end
      if monster["special_abilities"] != nil
        special_abilities = monster["special_abilities"].map do |special|
          special["name"] + ": " + special["desc"]
        end
      end
      if monster["legendary_actions"] != nil
        legendary_actions = monster["legendary_actions"].map do |legendary|
          legendary["name"] + ": " + legendary["desc"]
        end
      end
      Monster.new(name, size, ac, hp, hd, speed, cr, actions, reactions, legendary_actions, special_abilities)
    end
  end
end