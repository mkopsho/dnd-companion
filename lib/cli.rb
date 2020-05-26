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
    puts "1. 𝕤𝕡𝕖𝕝𝕝𝕤 | 2. 𝕖𝕢𝕦𝕚𝕡𝕞𝕖𝕟𝕥 | 3. 𝕔𝕠𝕟𝕕𝕚𝕥𝕚𝕠𝕟𝕤 | 4. 𝕔𝕙𝕒𝕣𝕒𝕔𝕥𝕖𝕣 𝕘𝕖𝕟𝕖𝕣𝕒𝕥𝕠𝕣 | 5. 𝕖𝕩𝕚𝕥".colorize(:blue)
    puts
    user_input = gets.chomp.strip
    case user_input 
    when "1"
      self.spells_menu
    when "2"
      self.equipment_menu
    when "3"
      self.conditions_menu
    when "4"
      self.character_menu
    when "5"
      puts "Farewell, traveler!".colorize(:light_green)
    else
      puts "Had a bunch of grog, I see! Please try again: "
      self.menu
    end
  end

  def spells_menu
    spells = Spell.get_all("http://www.dnd5eapi.co/api/spells/")
    puts "A fine choice, traveler. I know some arcana about #{spells.length} spells because I got double degrees in magic school.".colorize(:light_green)
    puts
    Spell.create_all("http://www.dnd5eapi.co/api/spells/") unless Spell.all.length > 0
    puts "Would you rather I:".colorize(:light_green)
    puts
    puts "1. List them all? | 2. Provide information by spell name?".colorize(:blue)
    puts
    user_input = gets.chomp.strip
    if user_input == "1"
      puts "Ah, another fine choice. Here are all the spells I know about:"
      Spell.all.each do |spell|
        puts "- #{spell.name}".colorize(:blue)
      end
      puts end_menu
    elsif user_input == "2"
      puts "Pragmatic! Please provide the name of the spell and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Spell.all.each do |spell|
        if user_input == spell.name
          puts "Ah, #{spell.name} is one of my favorite spells! A fine choice, traveler.\nHere's everything I know about #{spell.name}:\n".colorize(:light_green)
          # Make this nicer to look at. Like a page out of the PHB...
          puts "
          Material: #{spell.materials}\n
          Components: #{spell.components}\n
          Casting Time: #{spell.casting_time}\n
          Duration: #{spell.duration}\n
          Description: #{spell.description}"
        end
      end
      puts
      end_menu
    else
      puts
      end_menu
    end
  end
  
  def equipment_menu
    equipment = Equipment.get_all("http://www.dnd5eapi.co/api/equipment/")
    puts "A fine choice, traveler. I know about #{equipment.length} equipable items.".colorize(:light_green)
    puts
    Equipment.create_all("http://www.dnd5eapi.co/api/equipment/") unless Equipment.all.length > 0
    puts "Would you rather:".colorize(:light_green)
    puts
    puts "1. Hear about them all? | 2. Search by name?".colorize(:light_green)
    puts
    user_input = gets.chomp.strip
    if user_input == "1"
      Equipment.all.each do |item|
        puts "- #{item.name}".colorize(:blue)
      end
      puts end_menu
    elsif user_input == "2"
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Equipment.all.each do |item|
        if user_input == item.name
          puts "Ah, the #{item.name} is one of my favorite items! A fine choice, traveler.\nHere's everything I know about #{item.name}:\n".colorize(:light_green)
          # Make this nicer to look at. Like a page out of the PHB...
          puts "
          Category: #{item.equipment_category}
          Category Range: #{item.category_range}
          Cost: #{item.cost}
          Damage: #{item.damage}
          Weight: #{item.weight}
          Range: #{item.range}
          Properties: #{item.props}"
        end
      end
      puts
      end_menu
    else
      puts
      end_menu
    end
  end

  def conditions_menu
    puts "Which condition would you like more information on?".colorize(:light_green)
    puts
    Condition.create_all("http://www.dnd5eapi.co/api/conditions/") unless Condition.all.length > 0
    Condition.all.each do |condition|
      puts "- #{condition.name}".colorize(:blue)
    end
    puts
    user_input = gets.chomp.strip.capitalize
    Condition.all.each do |condition|
      if user_input == condition.name
        puts "Ah, #{condition.name} is one of my favorite conditions! A fine choice, traveler.\nHere's everything I know about #{condition.name}:\n".colorize(:light_green)
        puts condition.description.join("\n").colorize(:light_green)
      end
    end
    #validator?
    #puts "I don't know about that condition. Want to have another go?".colorize(:light_blue)
    puts
    end_menu
  end

  def character_menu
    puts "Character gen!"
  end

  def end_menu
    puts
    puts "Need anything else, traveler?".colorize(:light_green)
    puts
    puts "1. Yes | 2. No".colorize(:blue)
    puts
    user_input = gets.chomp.strip
    case user_input
    when "1"
      self.menu
    else
      puts "Farewell, traveler!".colorize(:light_green)
    end
  end
end