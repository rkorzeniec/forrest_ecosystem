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
      if move
        chop_tree if location.tree?
        break
      end
    end
  end

  def to_s
    'L'.yellow
  end

  private

  def move
    new_location = location.neighbour_location
    return if new_location.lumberjack? || new_location.bear?

    location.remove_lumberjack
    @location = new_location
    location.lumberjack = self
  end

  def moves_per_turn
    3
  end

  def chop_tree
    return if location.tree.is_a?(SaplingTree)
    return unless location.remove_tree

    changed
    notify_observers(self, :remove_tree)
  end
end
