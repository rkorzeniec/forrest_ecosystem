require 'colorize'
require_relative 'organism'

class Bear < Organism
  def initialize(location)
    super
    location.bear = self
  end

  def take_turn
    moves_per_turn.times do
      new_location = location.neighbour_location

      if move(new_location)
        maul if location.lumberjack?
        return
      end
    end
  end

  def to_s
    'B'.cyan
  end

  private

  def move(new_location)
    return false if new_location.bear?

    location.bear = nil
    @location = new_location
    location.bear = self
  end

  def moves_per_turn
    5
  end

  def maul
    location.lumberjack = nil
    changed
    notify_observers(self, :remove_lumberjack)
  end
end
