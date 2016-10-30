require 'pry'
require 'rb-readline'

class Forest
  attr_accessor :trees_count, :lumberjacks_count, :bears_count, :size

  def initialize(args = {})
    @trees_count = 0
    @lumberjacks_count = 0
    @bears_count = 0
    @size = args[:size] || 10
    @locations = Array.new(size) { Array.new(size) }
  end

  def gridsize
    @gridsize ||= (10 + Random.rand(40))
  end

  def free_location?(x, y)
    locations[x][y].nil?
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
    locations.size.times do |i|
      locations.size.times do |j|
        grid += free_location?(i, j) ? '  | ' : "#{locations[i][j]} | "
      end
      grid += "\n"
    end
    grid
  end

  private

  attr_reader :locations

  def find_organisms
    organisms = []
    locations.each do |x|
      x.each do |y|
        organisms << y unless y.nil?
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
