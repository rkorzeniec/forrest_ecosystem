require_relative 'services/location'

class Forest
  attr_accessor :locations, :size

  def initialize(size)
    @size = size
    initialize_locations
  end

  def location(args = {})
    locations[args[:x]][args[:y]]
  end

  def execute
    find_organisms
    take_turns
  end

  def find_random_lumberjaack
    @organisms.each do |organism|
      return organism if organism.is_a?(Lumberjack)
    end
  end

  def find_random_bear
    @organisms.each do |organism|
      return organism if organism.is_a?(Bear)
    end
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

  attr_reader :organisms

  def initialize_locations
    @locations = Array.new(size) do |i|
      Array.new(size) { |j| Location.new(forest: self, x: i, y: j) }
    end
  end

  def find_organisms
    @organisms = []
    locations.each do |location_row|
      location_row.each do |location|
        @organisms += location.organisms unless location.free?
      end
    end
  end

  def take_turns
    @organisms.each do |organism|
      organism.take_turn if organism.can_take_turn?
    end
  end
end
