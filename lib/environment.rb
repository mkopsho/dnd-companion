#A bunch of class methods should be refactored into a module here
require "colorize"
require "json"
require "net/http"
require "open-uri"

require_relative "../lib/dnd-companion/cli.rb"
require_relative "../lib/dnd-companion/api.rb"
require_relative "../lib/dnd-companion/condition.rb"
require_relative "../lib/dnd-companion/spell.rb"
require_relative "../lib/dnd-companion/equipment.rb"
require_relative "../lib/dnd-companion/character.rb"
require_relative "../lib/dnd-companion/monster.rb"