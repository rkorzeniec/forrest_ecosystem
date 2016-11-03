require_relative 'services/forest_populator'
require_relative 'services/logger'
require_relative 'forest'

class ForestSimulation
  attr_reader :forest

  def initialize
    @time = 0
  end

  def setup
    @forest = Forest.new(gridsize)
    populator = ForestPopulator.new(forest, logger)
    populator.populate
  end

  def execute
    4800.times do
      @time += 1
      forest.execute
      print_status
      sleep(1)
    end
  end

  private

  attr_reader :time

  def print_status
    print `clear`
    puts "Years: #{years} Months: #{months} | Forest: #{forest.size} x #{forest.size}"
    puts logger.organism_counts
    puts forest.to_s
    puts logger.output
  end

  def gridsize
    @_gridsize ||= (10 + Random.rand(1))
  end

  def logger
    @_logger ||= Logger.new
  end

  def years
    time / 12
  end

  def months
    time % 12
  end
end
