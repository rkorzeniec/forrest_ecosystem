require 'colorize'
require_relative 'organism'

require 'pry'
require 'rb-readline'

class Lumberjack < Organism
  def initialize(location)
    super
    location.lumberjack = self
  end

  def take_turn
    moves_per_turn.times do
      new_location = location.neighbour_location

      if move(new_location)
        chop_tree if location.tree?
        return
      end
    end
  end

  def to_s
    'L'.yellow
  end

  private

  def move(new_location)
    return false if new_location.lumberjack?

    location.lumberjack = nil
    @location = new_location
    location.lumberjack = self
  end

  def moves_per_turn
    3
  end

  def chop_tree
    return if location.tree.is_a?(SaplingTree)

    location.tree = nil
    changed
    notify_observers(self, :remove_tree)
  end
end
