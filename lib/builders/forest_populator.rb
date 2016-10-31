require_relative '../organisms/lumberjack'
require_relative '../organisms/bear'
require_relative '../factories/tree_factory'

class ForestPopulator
  attr_reader :forest

  def initialize(forest)
    @forest = forest
  end

  def populate
    populate_trees
    populate_lumberjacks
    populate_bears
  end

  private

  def populate_trees
    trees.times do
      location = random_free_location
      location.tree = TreeFactory.tree(Random.rand(3), location)
      forest.trees_count += 1
    end
  end

  def populate_lumberjacks
    lumberjacks.times do
      location = random_free_location
      location.lumberjack = Lumberjack.new(location)
      forest.lumberjacks_count += 1
    end
  end

  def populate_bears
    bears.times do
      location = random_free_location
      location.bear = Bear.new(location)
      forest.bears_count += 1
    end
  end

  def size
    @_size ||= forest.size
  end

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
      return forest.locations[x][y] if forest.locations[x][y].free?
    end
  end
end
