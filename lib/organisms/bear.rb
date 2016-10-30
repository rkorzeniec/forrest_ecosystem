require 'colorize'
require_relative './organism'
require_relative '../mixins/move'

require 'pry'
require 'rb-readline'

class Bear < Organism
  include Move

  attr_reader :mauls

  def initialize(location)
    @mauls = 0
    super(location)
  end

  def take_turn
    moves_per_turn.times do
      new_location = location.neighbour_location

      if move(new_location) && !new_location.tree.nil?
        maul
        return
      end
    end
  end

  def to_s
    'B'.cyan
  end

  private

  def move(new_location)
    location.bear = nil
    @location = new_location
    location.bear = self
  end

  def moves_per_turn
    5
  end

  def maul
    @mauls += 1
    location.lumberjack = nil
  end
end
