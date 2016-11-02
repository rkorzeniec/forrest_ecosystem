require 'colorize'
require_relative 'organism'

class Lumberjack < Organism
  def initialize(location)
    super
    location.lumberjack = self
  end

  def take_turn
    moves_per_turn.times do
      if move
        return if location.tree? && chop_tree
      end
    end
  end

  def to_s
    'L'.yellow
  end

  private

  def move
    new_location = location.neighbour_location
    return false if new_location.lumberjack? || new_location.bear?

    location.remove_lumberjack
    @location = new_location
    location.lumberjack = self
  end

  def moves_per_turn
    3
  end

  def chop_tree
    return false if location.tree.is_a?(SaplingTree)
    return false unless location.remove_tree

    changed
    notify_observers(self, :remove_tree)
    true
  end
end
