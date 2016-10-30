require_relative '../forest'
require_relative '../services/location'
require_relative '../organisms/lumberjack'
require_relative '../organisms/bear'
require_relative '../factories/tree_factory'

class LocationsBuilder
  attr_reader :locations

  def initialize(size, forest)
    @size = size
    @locations = Array.new(size) { |i| Array.new(size) { |j| Location.new(forest: forest, x: i, y: j) } }
  end

  def add_trees
    trees.times do
      location = random_free_location
      location.tree = TreeFactory.tree(Random.rand(3), location)
    end
  end

  def add_lumberjacks
    lumberjacks.times do
      location = random_free_location
      location.lumberjack = Lumberjack.new(location)
    end
  end

  def add_bears
    bears.times do
      location = random_free_location
      location.bear = Bear.new(location)
    end
  end

  private

  attr_reader :size

  def trees
    ((size * size) * 0.5).to_i
  end

  def lumberjacks
    ((size * size) * 0.1).to_i
  end

  def bears
    ((size * size) * 0.02).to_i
  end

  def random_free_location
    loop do
      x = rand(size)
      y = rand(size)
      return locations[x][y] if locations[x][y].free?
    end
  end
end
