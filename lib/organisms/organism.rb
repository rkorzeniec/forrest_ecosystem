require 'observer'

class Organism
  include Observable

  attr_accessor :location

  def initialize(location)
    @location = location
  end

  def can_take_turn?
    !location.nil?
  end

  def logger
    @_logger ||= @observer_peers.select { |k| k.is_a?(Logger) }.first.first
  end
end
