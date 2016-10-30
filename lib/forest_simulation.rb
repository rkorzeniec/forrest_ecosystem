require_relative 'builders/forest_builder'
require_relative './forest'

class ForestSimulation
  attr_reader :forest

  def initialize
    @time = 0
  end

  def setup
    @forest = Forest.new
    locations_builder = LocationsBuilder.new(gridsize, forest)
    locations_builder.add_trees
    locations_builder.add_lumberjacks
    locations_builder.add_bears
    forest.locations = locations_builder.locations
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
