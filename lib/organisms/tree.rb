require 'colorize'
require_relative 'organism'

class Tree < Organism
  attr_reader :age

  def initialize(location)
    super
    @age = 0
    location.tree = self
  end

  def take_turn
    grow
    spawn_sapling
    @age += 1
  end

  def to_s
    'T'.green
  end

  private

  def grow
    return if mature_period_in_months.nil?
    return if age < mature_period_in_months

    current_location = location
    location.remove_tree
    delete_observer(logger)
    grown_tree = grow_to.new(current_location)
    grown_tree.add_observer(logger)

    true
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

  def spawn_sapling
    return unless spawning_permitted?
    return if rand(100) > spawn_chance

    9.times do
      spawn_location = location.neighbour_location
      next if spawn_location.tree?

      sappling = SaplingTree.new(spawn_location)
      sappling.add_observer(logger)
      changed
      notify_observers(self, :tree_spawned)
      return
    end
  end
end
