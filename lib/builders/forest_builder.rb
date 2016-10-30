require_relative '../forest'
require_relative '../organisms/lumberjack'
require_relative '../organisms/bear'
require_relative '../factories/tree_factory'

class ForestBuilder
  attr_reader :forest

  def initialize(size)
    @size = size
    @forest = Forest.new(size: size)
  end

  def add_trees
    trees.times do
      location = random_free_location
      forest.assign_location(
        TreeFactory.tree(Random.rand(3), forest, location), location
      )
      forest.trees_count += 1
    end
  end

  def add_lumberjacks
    lumberjacks.times do
      location = random_free_location
      forest.assign_location(Lumberjack.new(forest, location), location)
      forest.lumberjacks_count += 1
    end
  end

  def add_bears
    bears.times do
      location = random_free_location
      forest.assign_location(Bear.new(forest, location), location)
      forest.bears_count += 1
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
      return { x: x, y: y } if forest.free_location?(x, y)
    end
  end
end
