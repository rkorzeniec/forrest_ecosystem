require_relative 'services/forest_populator'
require_relative 'services/logger'
require_relative 'forest'

class ForestSimulation
  attr_reader :forest

  def initialize
    @time = 0
    @forest = Forest.new(gridsize)
  end

  def setup
    forest.add_observer(logger)
    populator = ForestPopulator.new(forest, logger)
    populator.populate
  end

  def execute
    4800.times do
      print `clear`
      forest.tick
      print_status
      @time += 1
      STDIN.gets
    end
  end

  def print_status
    puts "Time: #{time} | Forest: #{forest.size} x #{forest.size}"
    puts logger.organism_counts
    puts forest.to_s
    puts logger.output
  end

  private

  attr_reader :time

  def gridsize
    @_gridsize ||= (10 + Random.rand(1))
  end

  def logger
    @_logger ||= Logger.new
  end
end
