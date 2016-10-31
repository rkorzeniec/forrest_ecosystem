require 'colorize'
require_relative 'organism'

class Bear < Organism
  attr_reader :mauls

  def initialize(location)
    @mauls = 0
    super
  end

  def take_turn
    moves_per_turn.times do
      new_location = location.neighbour_location

      if move(new_location) && !new_location.lumberjack.nil?
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
    return unless new_location.bear.nil?
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
