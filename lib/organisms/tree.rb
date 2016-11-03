require 'colorize'
require_relative 'organism'

class Tree < Organism
  def initialize(location)
    super
    @age = 0
    location.tree = self
  end

  def take_turn
    return if grow
    spawn_sapling
    @age += 1
  end

  def lumber
    raise NotImplementedError,
          "#lumber must be implemented in #{self.class}"
  end

  def to_s
    'T'.green
  end

  private

  attr_reader :age

  def grow
    return false if mature_period_in_months.nil?
    return false if age < mature_period_in_months

    current_location = location
    location.remove_tree
    delete_observer(logger)
    grown_tree = grow_to.new(current_location)
    grown_tree.add_observer(logger)

    true
  end

  def spawn_sapling
    return unless spawning_permitted?
    return if rand(100) > spawn_chance

    8.times do
      spawn_location = location.neighbour_location
      next if spawn_location.tree? || spawn_location.lumberjack?

      sappling = SaplingTree.new(spawn_location)
      sappling.add_observer(logger)
      changed
      notify_observers(self, :tree_spawned)
      break
    end
  end

  def mature_period_in_months
    raise NotImplementedError,
          "#mature_period_in_months must be implemented in #{self.class}"
  end

  def spawning_permitted?
    raise NotImplementedError,
          "#spawning_permitted? must be implemented in #{self.class}"
  end

  def spawn_chance
    raise NotImplementedError,
          "#spawn_chance must be implemented in #{self.class}"
  end

  def grow_to
    raise NotImplementedError,
          "#grow_to must be implemented in #{self.class}"
  end
end
