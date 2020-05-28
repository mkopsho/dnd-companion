class Monster
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

  def self.urls(url)
    monster_urls = []
    monster = API.new(url).parse_json
    monster_array = monster["results"]
    monster_array.each do |hash|
      monster_urls << url + hash["index"].downcase
    end
    monster_urls
  end

  def self.create_all(url)
    monster_tableau = []
    monster = urls(url)
    monster.each do |monster|
      monster_tableau << API.new(monster).parse_json
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
        actions = []
        monster["actions"].each do |action|
          actions << action["name"] + ": " + action["desc"]
        end
      end
      if monster["reactions"] != nil
        reactions = []
        monster["reactions"].each do |reaction|
          reactions << reaction["name"] + ": " + reaction["desc"]
        end
      end
      if monster["special_abilities"] != nil
        special_abilities = []
        monster["special_abilities"].each do |special|
          special_abilities << special["name"] + ": " + special["desc"]
        end
      end
      if monster["legendary_actions"] != nil
        legendary_actions = []
        monster["legendary_actions"].each do |legendary|
          legendary_actions << legendary["name"] + ": " + legendary["desc"]
        end
      end
      Monster.new(name, size, ac, hp, hd, speed, cr, actions, reactions, legendary_actions, special_abilities)
    end
  end

  def self.get_all(url)
    monster_names = []
    monster = API.new(url).parse_json
    monster_array = monster["results"]
    monster_array.each do |hash| 
      hash.collect do |key, value|
        if key == "name"
          monster_names << value
        end
      end
    end
    monster_names
  end
end