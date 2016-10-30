require_relative 'builders/forest_builder'

class ForestSimulation
  attr_reader :forest

  def initialize
    @time = 0
  end

  def setup
    forest_builder = ForestBuilder.new(gridsize)
    forest_builder.add_trees
    forest_builder.add_lumberjacks
    forest_builder.add_bears
    @forest = forest_builder.forest
  end

  def execute
    4800.times do
      forest.tick
      to_s
      @time += 1
      sleep(2)
    end
  end

  def to_s
    print %x{clear}
    puts "Time: #{time} | Forest: #{forest.size} x #{forest.size} | " \
         "Trees: #{forest.trees_count} | " \
         "Lumberjacks: #{forest.lumberjacks_count} | " \
         "Bears: #{forest.bears_count}"
    puts forest.to_s
  end

  private

  attr_reader :time

  def gridsize
    @gridsize ||= (10 + Random.rand(20))
  end
end
