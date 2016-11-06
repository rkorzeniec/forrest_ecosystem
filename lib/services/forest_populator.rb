require_relative '../organisms/lumberjack'
require_relative '../organisms/bear'
require_relative '../factories/tree_factory'

class ForestPopulator
  def initialize(forest, logger)
    @forest = forest
    @logger = logger
  end

  def populate_all(args = {})
    populate_trees(args[:trees])
    populate_lumberjacks(args[:lumberjacks])
    populate_bears(args[:bears])
  end

  def populate_lumberjacks(lumberjacks_number)
    lumberjacks_number.times do
      Lumberjack.new(random_free_location, logger)
    end
  end

  def populate_bears(bears_number)
    bears_number.times do
      Bear.new(random_free_location, logger)
    end
  end

  private

  attr_reader :forest, :logger

  def populate_trees(trees_number)
    trees_number.times do
      TreeFactory.tree(Random.rand(3), random_free_location, logger)
    end
  end

  def size
    @_size ||= forest.size
  end

  def random_free_location
    loop do
      x = rand(size)
      y = rand(size)
      return forest.locations[x][y] if forest.locations[x][y].free?
    end
  end
end
