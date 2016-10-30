require 'pry'
require 'rb-readline'

class Forest
  attr_accessor :trees_count, :lumberjacks_count, :bears_count, :locations

  def initialize(args = {})
    @trees_count = 0
    @lumberjacks_count = 0
    @bears_count = 0
    @locations = args[:locations]
  end

  def size
    locations.size
  end

  def location(args = {})
    locations[args[:x]][args[:y]]
  end

  def assign_location(organism, args = {})
    locations[args[:x]][args[:y]] = organism
  end

  def organism_at(x, y)
    return locations[x][y] unless locations[x][y].nil?
  end

  def tick
    take_turns(find_organisms)
    check_lumberjacks_quota
    check_bears_quota
  end

  def to_s
    grid = ''
    locations.each do |locations_row|
      locations_row.each do |location|
        grid += location.free? ? '  | ' : "#{location} | "
      end
      grid += "\n"
    end
    grid
  end

  private

  attr_reader :locations

  def find_organisms
    organisms = []
    locations.each do |location_row|
      location_row.each do |location|
        organisms << location.tree unless location.tree_free?
        organisms << location.bear unless location.bear_free?
        organisms << location.lumberjack unless location.lumberjack_free?
      end
    end
    organisms
  end

  def take_turns(organisms)
    organisms.map(&:take_turn)
  end

  def check_bears_quota

  end

  def check_lumberjacks_quota

  end
end
