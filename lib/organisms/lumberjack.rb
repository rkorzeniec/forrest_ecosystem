require 'colorize'
require_relative './organism'
require_relative '../mixins/move'

require 'pry'
require 'rb-readline'

class Lumberjack < Organism
  # include Move

  attr_reader :lumber

  def initialize(location)
    @lumber = 0
    super(location)
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
    return if new_location.nil?
    location.lumberjack = nil
    @location = new_location
    location.lumberjack = self
  end

  def moves_per_turn
    3
  end

  def chop_tree
    @lumber += 1
    location.tree = nil
  end
end
