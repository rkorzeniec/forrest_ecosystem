require 'colorize'
require_relative './organism'
require_relative '../mixins/move'

require 'pry'
require 'rb-readline'

class Bear < Organism
  include Move

  attr_reader :mauls

  def initialize(forest, args = {})
    @mauls = 0
    super(forest, args)
  end

  def take_turn
    moves_per_turn.times do
      new_x = valid_nearby_location_for(x)
      new_y = valid_nearby_location_for(y)

      if forest.organism_at(new_x, new_y).is_a?(Lumberjack)
        maul(new_x, new_y)
        move(new_x, new_y)

        return
      end

      move(new_x, new_y)
    end
  end

  def to_s
    'B'.cyan
  end

  private

  def moves_per_turn
    5
  end

  def maul(target_x, target_y)
    # binding.pry
    @mauls += 1
    forest.lumberjacks_count -= 1
    forest.assign_location(nil, x: target_x, y: target_y)
  end
end
