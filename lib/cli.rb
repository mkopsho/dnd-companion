require "colorize"

class CLI
  def start
    puts "Hey there, weary traveler. What would you like to see?".colorize(:light_blue)
    self.menu
  end

  def menu
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
      puts "Farewell, traveler!".colorize(:light_blue)
    else
      puts "Had a bunch of grog, I see! Please try again: "
      self.menu
    end
  end

  def spells_menu
    spells = Spell.get_all("http://www.dnd5eapi.co/api/spells/")
    puts "A fine choice, traveler. I know about #{spells.length} spells.".colorize(:light_blue)
    puts 
    puts "Would you rather:".colorize(:light_blue)
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
      puts "Pragmatic! Please provide the name of the spell and I will tell you all I know:".colorize(:light_blue)
      #search method to go here
      #user input
      #info method to go here
    end
  end

  def conditions_menu
    puts "A fine choice, traveler. Which condition would you like more information on?".colorize(:light_blue)
    puts
    conditions = Condition.get_all("http://www.dnd5eapi.co/api/conditions/")
    conditions.each_with_index do |condition, index| 
      print "#{index + 1}. #{condition} | ".colorize(:blue)
    end
    #info method to go here
  end

  def equipment_menu
    equipment = Equipment.get_all("http://www.dnd5eapi.co/api/equipment/")
    puts "A fine choice, traveler. I know about #{equipment.length} equipable items.".colorize(:light_blue)
    puts 
    puts "Would you rather:".colorize(:light_blue)
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
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_blue)
      #search method to go here
      #user input
      #info method to go here
    end
  end
end