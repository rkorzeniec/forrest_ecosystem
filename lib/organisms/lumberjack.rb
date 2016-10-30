require 'colorize'
require_relative './organism'
require_relative '../mixins/move'

require 'pry'
require 'rb-readline'

class Lumberjack < Organism
  include Move

  attr_reader :lumber

  def initialize(forest, args = {})
    @lumber = 0
    super(forest, args)
  end

  def take_turn
    moves_per_turn.times do
      new_x = valid_nearby_location_for(x)
      new_y = valid_nearby_location_for(y)

      if forest.organism_at(new_x, new_y).is_a?(ElderTree) || forest.organism_at(new_x, new_y).is_a?(GrownTree)
        chop_tree(new_x, new_y)
        move(new_x, new_y)

        return
      end

      move(new_x, new_y)
    end
  end

  def to_s
    'L'.yellow
  end

  private

  def moves_per_turn
    3
  end

  def chop_tree(target_x, target_y)
    # binding.pry
    @lumber += 1
    forest.trees_count -= 1
    forest.assign_location(nil, x: target_x, y: target_y)
  end
end
