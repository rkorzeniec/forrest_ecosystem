require 'colorize'
require_relative 'organism'

class Lumberjack < Organism
  attr_reader :lumber

  def initialize(location, logger)
    super
    @lumber = 0
    location.lumberjack = self
    notify_observers(self, :lumberjack_added)
  end

  def take_turn
    moves_per_turn.times do
      if move
        return if location.tree? && chop_tree(location.tree)
      end
    end
  end

  def removed
    changed
    notify_observers(self, :lumberjack_removed)
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

  def chop_tree(tree)
    return false if tree.is_a?(SaplingTree)
    return false unless location.remove_tree

    @lumber += tree.lumber
    changed
    notify_observers(self, :chop_tree, tree.lumber)
    true
  end
end
