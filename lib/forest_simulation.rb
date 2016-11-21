require_relative 'services/forest_populator'
require_relative 'services/forest_fixings'
require_relative 'services/logger'
require_relative 'services/quotas_applier'
require_relative 'services/simulation_reporter'
require_relative 'strategies/quotas/bear_quotas'
require_relative 'strategies/quotas/lumberjack_quotas'
require_relative 'strategies/outputters/console_outputter'
require_relative 'strategies/outputters/file_outputter'
require_relative 'forest'

class ForestSimulation
  attr_reader :forest, :time, :cycles

  def initialize(cycles)
    @time = 0
    @cycles = cycles
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
    cycles.times do
      break if logger.trees == 0
      @time += 1
      forest.execute
      check_quotas
      report_monthly_status
      puts "\nPress ENTER to continue\n"
      STDIN.gets
    end
    report_final_status
  end

  def forest_populator
    @_forest_populator ||= ForestPopulator.new(forest, logger)
  end

  def logger
    @_logger ||= Logger.new
  end

  private

  def gridsize
    @_gridsize ||= (10 + Random.rand(1))
  end

  def forest_fixings
    @_forest_fixings ||= ForestFixings.new(gridsize)
  end

  def simulation_reporter
    @_simulation_reporter ||= SimulationReporter.new(self)
  end

  def quotas_applier
    @_quotas_applier ||= QuotasApplier.new(self)
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

  def report_monthly_status
    simulation_reporter.outputter = ConsoleOutputter.new
    simulation_reporter.report
  end

  def report_final_status
    simulation_reporter.outputter = FileOutputter.new
    simulation_reporter.report
  end
end
