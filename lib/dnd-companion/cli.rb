require "colorize"

class CLI
  def start
    puts "Hey there, weary traveler.".colorize(:light_green)
    self.menu
  end

  def menu
    puts
    puts "What would you like to learn about?".colorize(:light_green)
    puts
    puts "1. ⚡𝚂𝚙𝚎𝚕𝚕𝚜 ⚡| 2. ⚔️ 𝙴𝚚𝚞𝚒𝚙𝚖𝚎𝚗𝚝 ⚔️ | 3. ☠ 𝙲𝚘𝚗𝚍𝚒𝚝𝚒𝚘𝚗𝚜 ☠ | 4. ？𝙲𝚑𝚊𝚛𝚊𝚌𝚝𝚎𝚛 𝙶𝚎𝚗𝚎𝚛𝚊𝚝𝚘𝚛 ？| 5. ↗ 𝙴𝚡𝚒𝚝 ↗".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input 
    when "1"
      generate_spells
      spells_menu
    when "2"
      generate_equipment
      equipment_menu
    when "3"
      generate_conditions
      conditions_menu
    when "4"
      character_menu
    when "5"
      puts "Farewell, traveler!".colorize(:light_green)
    else
      puts "Had a bunch of grog, I see! Please try again: ".colorize(:light_green)
      menu
    end
  end
  
  def generate_spells
    spells = Spell.get_all("http://www.dnd5eapi.co/api/spells/")
    puts
    puts "A fine choice, traveler. I know some arcana about some #{spells.length} spells because I got double degrees in magic school.".colorize(:light_green)
    puts
    puts "Please wait while I rack my brain...".colorize(:light_green) #Building objects takes forever!
    Spell.create_all("http://www.dnd5eapi.co/api/spells/") unless Spell.all.length > 0
  end
  
  def spells_menu
    puts
    puts "⚡𝚂𝚙𝚎𝚕𝚕𝚜 ⚡".colorize(:blue)
    puts "Select your preference:".colorize(:light_green)
    puts
    puts "1. The full list of spells | 2. Information by spell name | 3. Back to main menu".colorize(:blue)
    user_input = gets.chomp.strip
    if user_input == "1"
      puts
      puts "Ah, another fine choice. Here are all the spells I know about:"
      Spell.all.each do |spell|
        puts "- #{spell.name}"
      end
      spells_menu
    elsif user_input == "2"
      puts
      puts "Pragmatic! Please provide the name of the spell and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Spell.all.each do |spell|
        if user_input == spell.name
          puts
          puts "Ah, #{spell.name} is one of my favorite spells! A fine choice, traveler.\nHere's everything I know about the #{spell.name} spell:\n".colorize(:light_green)
          puts "\tMaterial: #{spell.materials}\n
        Components: #{spell.components}\n
        Casting Time: #{spell.casting_time}\n
        Duration: #{spell.duration}\n
        Description: #{spell.description}"
        end
      end
      spells_menu
    elsif user_input == "3"
      menu
    end
  end
  
  def generate_equipment
    equipment = Equipment.get_all("http://www.dnd5eapi.co/api/equipment/")
    puts "A fine choice, traveler. I know about #{equipment.length} equipable items.".colorize(:light_green)
    puts
    puts "Please wait while I rack my brain...".colorize(:light_green) #Building objects takes forever!
    Equipment.create_all("http://www.dnd5eapi.co/api/equipment/") unless Equipment.all.length > 0
  end

  def equipment_menu
    puts
    puts "⚔️ 𝙴𝚚𝚞𝚒𝚙𝚖𝚎𝚗𝚝 ⚔️".colorize(:blue)
    puts "Select your preference:".colorize(:light_green)
    puts
    puts "1. View the full list | 2. Search by name | 3. Search by category | 4. Back to main menu".colorize(:blue)
    user_input = gets.chomp.strip
    if user_input == "1"
      Equipment.all.each do |item|
        puts "- #{item.name}".colorize(:blue)
      end
      equipment_menu
    elsif user_input == "2"
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Equipment.all.each do |item|
        if user_input == item.name
          puts
          puts "Ah, the #{item.name} is one of my favorite items! A fine choice, traveler.\nHere's everything I know about the #{item.name}:\n".colorize(:light_green)
          puts "\tCategory: #{item.equipment_category}
        Category Range: #{item.category_range}
        Cost: #{item.cost}
        Damage: #{item.damage}
        Weight: #{item.weight}
        Range: #{item.range}
        Properties: #{item.props}"
        end
      end
      equipment_menu
    elsif user_input == "3"
      puts "Alright, traveler. Please enter a category from this list:".colorize(:light_green)
      equipment_categories = []
      Equipment.all.each do |item|
        equipment_categories << item.equipment_category
      end
      equipment_categories.uniq.each { |category| puts "- #{category}"}
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      puts
      puts "Another fine choice! Here are all of the items from the #{user_input} category:".colorize(:light_green)
      Equipment.all.select do |item|
        if item.equipment_category == user_input
          puts "- #{item.name}"
        end
      end
      equipment_menu
    elsif user_input == "4"
      menu
    end
  end
  
  def generate_conditions
    Condition.create_all("http://www.dnd5eapi.co/api/conditions/") unless Condition.all.length > 0
  end

  def conditions_menu
    puts
    puts "☠ 𝙲𝚘𝚗𝚍𝚒𝚝𝚒𝚘𝚗𝚜 ☠".colorize(:blue)
    puts "1. View the full list | 2. Search by name | 3. Back to main menu".colorize(:light_green)
    puts
    user_input = gets.chomp.strip
    if user_input == "1"
      Condition.all.each do |condition|
        puts "- #{condition.name}"
      end
      conditions_menu
    elsif user_input == "2"
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.capitalize
      Condition.all.each do |condition|
        if user_input == condition.name
          puts "Ah, #{condition.name} is one of my favorite conditions! A fine choice, traveler.\nHere's everything I know about #{condition.name}:\n".colorize(:light_green)
          puts "\t" + condition.description.join("\n\t")
        end
      end
      conditions_menu
    elsif user_input == "3"
      menu
    end
  end

  def character_menu
    puts "A fine choice, traveler. Simply give a name for your new character:".colorize(:light_green)
    puts
    user_input = gets.chomp.strip.split(" ")
    user_input = user_input.collect { |word| word.capitalize }
    user_input = user_input.join(" ")
    puts
    puts "Ah, #{user_input}? This is a noble name, a strong name.".colorize(:light_green)
    puts
    character = Character.new
    character.random_character(user_input, "https://www.dnd5eapi.co/api/races/", "https://www.dnd5eapi.co/api/classes/")
    puts "Here are your random character's stats:".colorize(:light_green)
    puts
    Character.all.each do |character|
      if user_input == character.name
        puts "\tName: #{character.name}
        Race: #{character.race}
        Class: #{character.klass}
        Size: #{character.size}
        Speed: #{character.speed}
        Proficiencies: #{character.proficiencies}"
      end
    end
    end_menu
  end

  def end_menu
    puts
    puts "Need anything else, traveler?".colorize(:light_green)
    puts
    puts "1. Yes | 2. No".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input
    when "1"
      self.menu
    else
      puts "Farewell, traveler!".colorize(:light_green)
    end
  end
end