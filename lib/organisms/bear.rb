require 'colorize'
require_relative 'organism'

class Bear < Organism
  def initialize(location)
    super
    location.bear = self
  end

  def take_turn
    moves_per_turn.times do
      if move
        maul if location.lumberjack?
        break
      end
    end
  end

  def to_s
    'B'.cyan
  end

  private

  def move
    new_location = location.neighbour_location
    return if new_location.bear?

    location.remove_bear
    @location = new_location
    location.bear = self
  end

  def moves_per_turn
    5
  end

  def maul
    return unless location.remove_lumberjack

    changed
    notify_observers(self, :remove_lumberjack)
  end
end
