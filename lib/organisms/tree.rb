require 'colorize'
require_relative './organism'

require 'pry'
require 'rb-readline'

class Tree < Organism
  attr_reader :age

  def initialize(forest, args = {})
    @age = 0
    super(forest, args)
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

    grown_tree = grow_to.new(forest, x: x, y: y)
    forest.assign_location(grown_tree, x: x, y: y)
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
      new_x = valid_nearby_location_for(x)
      new_y = valid_nearby_location_for(y)

      if forest.free_location?(new_x, new_y)
        # binding.pry
        args = { x: new_x, y: new_y }
        forest.assign_location(SaplingTree.new(forest, args), args)
        forest.trees_count += 1

        return
      end
    end
  end
end
