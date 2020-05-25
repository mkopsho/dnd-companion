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
    puts "A fine choice, traveler. Which spell would you like more information on?".colorize(:light_blue)
  end

  def conditions_menu
    puts "A fine choice, traveler. Which condition would you like more information on?".colorize(:light_blue)
    puts
    conditions = Condition.get_all("http://www.dnd5eapi.co/api/conditions/")
    conditions.each_with_index do |condition, index| 
      print "#{index + 1}. #{condition} | ".colorize(:blue)
    end
  end

  def equipment_menu
    puts "A fine choice, traveler. Which equipment would you like more information on?".colorize(:light_blue)
  end

end
