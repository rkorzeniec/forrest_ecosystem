require 'colorize'
require_relative 'organism'

class Lumberjack < Organism
  attr_reader :lumber

  def initialize(location)
    @lumber = 0
    super
  end

  def take_turn
    moves_per_turn.times do
      new_location = location.neighbour_location

      if move(new_location) && !new_location.tree.nil?
        chop_tree
        return
      end
    end
  end

  def to_s
    'L'.yellow
  end

  private

  def move(new_location)
    return unless new_location.lumberjack.nil?
    location.lumberjack = nil
    @location = new_location
    location.lumberjack = self
  end

  def moves_per_turn
    3
  end

  def chop_tree
    return if location.tree.is_a?(SaplingTree)

    @lumber += 1
    location.tree = nil
  end
end
