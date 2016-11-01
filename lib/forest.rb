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
    take_turns(find_organisms)
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

  def initialize_locations
    @locations = Array.new(size) do |i|
      Array.new(size) { |j| Location.new(forest: self, x: i, y: j) }
    end
  end

  def find_organisms
    organisms = []
    locations.each do |location_row|
      location_row.each do |location|
        organisms += location.organisms unless location.free?
      end
    end
    organisms
  end

  def take_turns(organisms)
    organisms.map(&:take_turn)
  end
end
