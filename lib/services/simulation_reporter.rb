require 'forwardable'
require_relative '../strategies/outputters/console_outputter'

class SimulationReporter
  extend Forwardable

  attr_reader :simulation
  attr_accessor :outputter

  def_delegators :simulation, :forest, :logger

  def initialize(simulation)
    @simulation = simulation
    @outputter = ConsoleOutputter.new
  end

  def report
    outputter.output(self)
  end

  def report_items
    [simulation_time_with_forest_size, organisms_log, forest_map, logs]
  end

  private

  def simulation_time_with_forest_size
    "Years: #{years} Months: #{months} | Forest: #{forest.size} x #{forest.size}"
  end

  def organisms_log
    "Trees: #{logger.trees} | Lumberjacks: #{logger.lumberjacks} | Bears: #{logger.bears}"
  end

  def forest_map
    forest.to_s
  end

  def logs
    logs = ''
    logs += total_logs + ' || ' if simulation_finished?
    logs += yearly_logs + ' || ' if year_passed?
    logs += monthly_logs + "\n\n"
    logs += logger.output_logs
    logs
  end

  def years
    (simulation.time / 12).to_i
  end

  def months
    simulation.time % 12
  end

  def year_passed?
    (simulation.time % 12).zero?
  end

  def simulation_finished?
    simulation.time >= simulation.cycles
  end

  def monthly_logs
    monthly = logger.monthly_counts
    "Monthly lumber: #{monthly[:lumber]} | Monthly mauls #{monthly[:mauls]}"
  end

  def yearly_logs
    yearly = logger.yearly_counts
    "Yearly lumber: #{yearly[:lumber]} | Yearly mauls #{yearly[:mauls]}"
  end

  def total_logs
    total = logger.total_counts
    "Total lumber: #{total[:lumber]} | Total mauls #{total[:mauls]}"
  end
end
