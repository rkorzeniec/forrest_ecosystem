require_relative 'services/forest_populator'
require_relative 'services/forest_fixings'
require_relative 'services/logger'
require_relative 'forest'

class ForestSimulation
  attr_reader :forest

  def initialize
    @time = 0
    @forest = Forest.new(gridsize)
  end

  def setup
    forest_populator.populate_all(
      trees: forest_fixings.trees,
      lumberjacks: forest_fixings.lumberjacks,
      bears: forest_fixings.bears
    )
  end

  def execute
    4800.times do
      @time += 1
      forest.execute
      print_status
      sleep(2)
    end
  end

  private

  attr_reader :time

  def forest_populator
    @_forest_populator ||= ForestPopulator.new(forest, logger)
  end

  def print_status
    print `clear`
    puts "Years: #{years} Months: #{months} | Forest: #{forest.size} x #{forest.size}"
    puts logger.organism_counts
    puts forest.to_s
    puts logger.output_yearly_logs if year_passed?
    puts logger.output_monthly_logs
    puts logger.output_logs
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

  def year_passed?
    (time % 12).zero?
  end

  def forest_fixings
    @_forest_fixings ||= ForestFixings.new(forest)
  end
end
