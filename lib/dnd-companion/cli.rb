class CLI
  def start
    self.title_card
    self.menu
  end

  def title_card
    puts
    puts '
8888b.  88b 88 8888b.      dP""b8  dP"Yb  8b    d8 88""Yb   db    88b 88 88  dP"Yb  88b 88 
 8I  Yb 88Yb88  8I  Yb    dP   `" dP   Yb 88b  d88 88__dP  dPYb   88Yb88 88 dP   Yb 88Yb88 
 8I  dY 88 Y88  8I  dY    Yb      Yb   dP 88YbdP88 88"""  dP__Yb  88 Y88 88 Yb   dP 88 Y88 
8888Y"  88  Y8 8888Y"      YboodP  YbodP  88 YY 88 88    dP""""Yb 88  Y8 88  YbodP  88  Y8 '
    puts
    puts "(...for novice DMs who haven't memorized anything and hate disrupting the flow of play to look things up)"
    puts
  end

  def menu
    puts
    puts "What would you like to learn about?".colorize(:light_green)
    puts
    puts "1. ⚡𝚂𝚙𝚎𝚕𝚕𝚜 ⚡| 2. ⚔️ 𝙴𝚚𝚞𝚒𝚙𝚖𝚎𝚗𝚝 ⚔️ | 3. ☠ 𝙲𝚘𝚗𝚍𝚒𝚝𝚒𝚘𝚗𝚜 ☠ | 4. 𝙼𝚘𝚗𝚜𝚝𝚎𝚛𝚜 | 5. ↗ 𝙴𝚡𝚒𝚝 ↗".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input 
    when "1"
      generate(Spell)
      spells_menu
    when "2"
      generate(Equipment)
      equipment_menu
    when "3"
      generate(Condition)
      conditions_menu
    when "4"
      generate(Monster)
      monster_menu
    when "5"
      puts "Farewell, traveler!".colorize(:light_green)
    else
      puts "Had a bunch of grog, I see! Please try again:".colorize(:light_green)
      menu
    end
  end
  
  def generate(klass)
    class_string = klass.to_s.downcase
    case class_string
    when "spell"
      url = "spells/"
    when "equipment"
      url = "equipment/"
    when "condition"
      url = "conditions/"
    when "monster"
      url = "monsters/"
    end
    objects = klass.get_all("http://www.dnd5eapi.co/api/" + url)
    puts "A fine choice, traveler. I know stuff about #{objects.length} #{class_string}".colorize(:light_green) + "s ".colorize(:light_green) + "because I got double degrees in Dungeon Master school.".colorize(:light_green)
    puts
    puts "Please wait while I rack my brain...".colorize(:light_green) #Building objects takes forever!
    klass.create_all("http://www.dnd5eapi.co/api/" + url) unless klass.all.length > 0
  end
  
  def spells_menu
    puts
    puts "⚡𝚂𝚙𝚎𝚕𝚕𝚜 ⚡".colorize(:blue)
    puts "Select your preference:".colorize(:light_green)
    puts
    puts "1. The full list of spells | 2. Information by spell name | 3. List by class and level | 4. Back to main menu".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input
    when "1"
      puts
      puts "Ah, another fine choice. Here are all the spells I know about:".colorize(:light_green)
      Spell.all.each do |spell|
        puts "- #{spell.name}"
      end
      spells_menu
    when "2"
      puts
      puts "Pragmatic! Please provide the name of the spell and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Spell.all.each do |spell|
        if user_input == spell.name
          puts
          puts "Ah, #{spell.name} is one of my favorite spells! A fine choice, traveler.\nHere's everything I know about the #{spell.name} spell:\n".colorize(:light_green)
          puts "\tLevel: #{spell.level}\n
        Material: #{spell.materials}\n
        Components: #{spell.components.join(", ")}\n
        Casting Time: #{spell.casting_time}\n
        Duration: #{spell.duration}\n
        Classes: #{spell.klasses.join(", ")}\n
        School: #{spell.school}\n
        Description: #{spell.description}"
        end
      end
      spells_menu
    when "3"
      puts
      puts "Wonderful! Give me the name of the class:".colorize(:light_green)
      user_input_klass = gets.chomp.strip.capitalize
      puts
      puts "Great. Now give me the name of the desired level (0 for cantrips):".colorize(:light_green)
      user_input_level = gets.chomp.strip
      puts
      puts "Fantastic. Here are all the spells I've found for the #{user_input_klass} class at level #{user_input_level}:".colorize(:light_green)
      Spell.all.each do |spell|
        if spell.klasses.include?(user_input_klass) && spell.level == user_input_level
          puts "- #{spell.name} (#{spell.level})"
        end
      end
      spells_menu
    when "4"
      menu
    else
      puts "Had a bunch of grog, I see! Please try again:".colorize(:light_green)
      spells_menu
    end
  end

  def equipment_menu
    puts
    puts "⚔️ 𝙴𝚚𝚞𝚒𝚙𝚖𝚎𝚗𝚝 ⚔️".colorize(:blue)
    puts "Select your preference:".colorize(:light_green)
    puts
    puts "1. View the full list | 2. Information by item name | 3. Search by category | 4. Back to main menu".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input
    when "1"
      Equipment.all.each do |item|
        puts "- #{item.name}"
      end
      equipment_menu
    when "2"
      puts
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Equipment.all.each do |item|
        if user_input == item.name
          puts
          puts "Ah, the #{item.name} is one of my favorite items! A fine choice, traveler.\nHere's everything I know about the #{item.name}:\n".colorize(:light_green)
          puts "\tCategory: #{item.equipment_category}
        Armor Category: #{item.armor_category}
        Armor Class: #{item.armor_class}
        Category Range: #{item.category_range}
        Damage: #{item.damage}
        Range: #{item.range}
        Weight: #{item.weight}
        Cost: #{item.cost}
        Properties: #{item.props}"
        end
      end
      equipment_menu
    when "3"
      puts "Alright, traveler. Please enter a category from this list:\n".colorize(:light_green)
      equipment_categories = Equipment.all.map do |item|
        item.equipment_category
      end
      equipment_categories.uniq.each { |category| puts "- #{category}"}
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      puts
      puts "Another fine choice! Here are all of the items from the #{user_input} category:\n".colorize(:light_green)
      Equipment.all.select do |item|
        if item.equipment_category == user_input
          puts "- #{item.name}"
        end
      end
      equipment_menu
    when "4"
      menu
    else
      puts "Had a bunch of grog, I see! Please try again:".colorize(:light_green)
      equipment_menu
    end
  end

  def conditions_menu
    puts
    puts "☠ 𝙲𝚘𝚗𝚍𝚒𝚝𝚒𝚘𝚗𝚜 ☠".colorize(:blue)
    puts "Select your preference:".colorize(:light_green)
    puts
    puts "1. View the full list | 2. Search by name | 3. Back to main menu".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input
    when "1"
      Condition.all.each do |condition|
        puts "- #{condition.name}"
      end
      conditions_menu
    when "2"
      puts
      puts "Pragmatic! Please provide the name of the item and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.capitalize
      Condition.all.each do |condition|
        if user_input == condition.name
          puts
          puts "Ah, #{condition.name} is one of my favorite conditions! A fine choice, traveler.\nHere's everything I know about #{condition.name}:\n".colorize(:light_green)
          puts "\t" + condition.description.join("\n\t")
        end
      end
      conditions_menu
    when "3"
      menu
    else
      puts "Had a bunch of grog, I see! Please try again: ".colorize(:light_green)
      conditions_menu
    end
  end

  def monster_menu
    puts
    puts "𝙼𝚘𝚗𝚜𝚝𝚎𝚛𝚜".colorize(:blue)
    puts "1. View the full list | 2. Information by monster name | 3. Search by CR | 4. Back to main menu".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input
    when "1"
      Monster.all.each do |monster|
        puts "- #{monster.name}"
      end
      monster_menu
    when "2"
      puts
      puts "Pragmatic! Please provide the name of the monster and I will tell you all I know:".colorize(:light_green)
      user_input = gets.chomp.strip.split(" ")
      user_input = user_input.collect { |word| word.capitalize }
      user_input = user_input.join(" ")
      Monster.all.each do |monster|
        if user_input == monster.name
          puts
          puts "Here's everything I know about the #{user_input} monster:\n".colorize(:light_green)
          puts "\tName: #{monster.name}
        Size: #{monster.size}
        Speed: #{monster.speed}
        Armor Class: #{monster.ac}
        Hit Points: #{monster.hp}
        Challenge Rating: #{monster.cr}\n
        Actions: #{monster.actions}\n
        Special Abilities: #{monster.special_abilities}\n
        Reactions: #{monster.reactions}\n
        Legendary Actions: #{monster.legendary_actions}"
        end
      end
      monster_menu
    when "3"
      puts
      puts "A fine choice, traveler. Give me your desired CR rating (0.00 - 30):".colorize(:light_green)
      user_input = gets.chomp.strip
      puts
      Monster.all.collect do |monster|
        if monster.cr == user_input
          puts "- #{monster.name} (CR #{monster.cr})"
        end
      end
      monster_menu
    when "4"
      menu
    else
      puts "Had a bunch of grog, I see! Please try again: ".colorize(:light_green)
      monster_menu
    end
  end

  def end_menu
    puts
    puts "Need anything else, traveler?".colorize(:light_green)
    puts
    puts "1. Yes | 2. No".colorize(:blue)
    user_input = gets.chomp.strip
    case user_input
    when "1"
      menu
    else
      puts "Farewell, traveler!".colorize(:light_green)
    end
  end
end
