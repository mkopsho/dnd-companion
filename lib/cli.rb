class CLI
  def start
    puts "Hey there, weary traveler. What would you like to see?"
    self.menu
  end

  def menu
    puts "1. Spells | 2. Conditions | 3. Equipment | 4. Exit"
    puts
    user_input = gets.chomp.strip
    case user_input 
    when "1"
      puts "Spells go here!"
    when "2"
      puts "Conditions go here!"
    when "3"
      puts "Equipment goes here!"
    when "4"
      puts "Farewell, traveler!"
    else
      puts "Had a bunch of grog, I see! Please try again: "
      self.menu
    end
  end
end
