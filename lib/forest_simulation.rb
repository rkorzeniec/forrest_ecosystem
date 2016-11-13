require_relative 'services/forest_populator'
require_relative 'services/forest_fixings'
require_relative 'services/logger'
require_relative 'services/quotas_applier'
require_relative 'strategies/quotas/bear_quotas'
require_relative 'strategies/quotas/lumberjack_quotas'
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

  def forest_populator
    @_forest_populator ||= ForestPopulator.new(forest, logger)
  end

  def logger
    @_logger ||= Logger.new
  end

  private

  attr_reader :time

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
    quotas_applier.quota = LumberjackQuotas.new(logger)
    quotas_applier.apply(:lumberjack)
  end

  def check_bears_quota
    quotas_applier.quota = BearQuotas.new(logger)
    quotas_applier.apply(:bear)
  end

  def quotas_applier
    @_quotas_applier ||= QuotasApplier.new(self)
  end
end
