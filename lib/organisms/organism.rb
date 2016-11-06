require 'observer'

class Organism
  include Observable

  attr_accessor :location

  def initialize(location, logger)
    @location = location
    add_observer(logger)
    changed
  end

  def can_take_turn?
    !location.nil?
  end

  def logger
    @_logger ||= @observer_peers.select { |k| k.is_a?(Logger) }.first.first
  end
end
