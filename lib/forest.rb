require_relative 'services/location'

class Forest
  attr_accessor :trees_count, :lumberjacks_count, :bears_count, :locations, :size

  def initialize(size)
    @size = size
    initialize_default_counts
    initialize_locations
  end

  def location(args = {})
    locations[args[:x]][args[:y]]
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
        grid += "#{location} | "
      end
      grid += "\n"
    end
    grid
  end

  private

  def initialize_default_counts
    @trees_count = 0
    @lumberjacks_count = 0
    @bears_count = 0
  end

  def initialize_locations
    @locations = Array.new(size) do |i|
      Array.new(size) { |j| Location.new(forest: self, x: i, y: j) }
    end
  end

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
