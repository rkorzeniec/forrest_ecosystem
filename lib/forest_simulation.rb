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
      check_quotas
      print_status
      sleep(2)
    end
  end

  private

  attr_reader :time

  def forest_populator
    @_forest_populator ||= ForestPopulator.new(forest, logger)
  end

  def forest_fixings
    @_forest_fixings ||= ForestFixings.new(forest)
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

  def check_quotas
    forest_populator.populate_lumberjacks(1) if logger.lumberjacks < 1
    return unless year_passed?
    check_lumberjacks_quota
    check_bears_quota
  end

  def check_lumberjacks_quota
    if logger.yearly_lumber >= logger.lumberjacks
      hire_lumberjacks
    elsif logger.lumberjacks > 1
      OrganismRemover.new(forest.find_random_lumberjaack).remove(:lumberjack)
    end
  end

  def check_bears_quota
    if logger.yearly_mauls > 0
      OrganismRemover.new(forest.find_random_bear).remove(:bear)
    else
      forest_populator.populate_bears(1)
    end
  end

  def hire_lumberjacks
    forest_populator.populate_lumberjacks(
      forest_fixings.premium_lumberjacks(
        logger.lumberjacks, logger.yearly_lumber
      )
    )
  end
end
