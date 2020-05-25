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
    puts "1. Spells | 2. Conditions | 3. Equipment | 4. Exit".colorize(:blue)
    puts
    user_input = gets.chomp.strip
    case user_input 
    when "1"
      self.spells_menu
    when "2"
      self.conditions_menu
    when "3"
      self.equipment_menu
    when "4"
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
    puts "Would you rather:".colorize(:light_green)
    puts
    puts "1. Hear about them all? | 2. Search by name?".colorize(:blue)
    puts
    user_input = gets.chomp.strip
    if user_input == "1"
      spells.each_with_index do |spell, index|
        puts "#{index + 1}. #{spell}".colorize(:blue)
      end
      #user input
      #info method to go here
    else
      puts "Pragmatic! Please provide the name of the spell and I will tell you all I know:".colorize(:light_green)
      #search method to go here
      #user input
      #info method to go here
      puts end_menu
    end
  end

  def conditions_menu
    puts "Which condition would you like more information on?".colorize(:light_green)
    puts
    Condition.create_all("http://www.dnd5eapi.co/api/conditions/")
    Condition.all.each do |condition|
      puts "- #{condition.name}".colorize(:blue)
    end
    puts
    user_input = gets.chomp.strip.capitalize
    Condition.all.each do |condition|
      if user_input == condition.name
        puts "Ah, #{condition.name} is one of my favorite conditions! A fine choice, traveler.\nHere's everything I know:\n".colorize(:light_green)
        puts condition.description.join("\n").colorize(:light_green)
      end
    end
    #puts "I don't know about that condition. Want to have another go?".colorize(:light_blue)
    puts
    end_menu
  end

  def equipment_menu
    equipment = Equipment.get_all("http://www.dnd5eapi.co/api/equipment/")
    puts "A fine choice, traveler. I know about #{equipment.length} equipable items.".colorize(:light_green)
    puts 
    puts "Would you rather:".colorize(:light_green)
    puts
    puts "1. Hear about them all? | 2. Search by name?".colorize(:blue)
    puts
    user_input = gets.chomp.strip
    if user_input == "1"
      equipment.each_with_index do |equipment, index|
        puts "#{index + 1}. #{equipment}".colorize(:blue)
      end
      #user input
      #info method to go here
    else
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_green)
      #search method to go here
      #user input
      #info method to go here
      puts
      end_menu
    end
  end

  def end_menu
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