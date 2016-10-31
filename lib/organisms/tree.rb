require 'colorize'
require_relative 'organism'

class Tree < Organism
  attr_reader :age

  def initialize(location)
    @age = 0
    super
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

    grown_tree = grow_to.new(location)
    location.tree = grown_tree
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

      if spawn_location.tree_free?
        spawn_location.tree = SaplingTree.new(location)
        return
      end
    end
  end
end
