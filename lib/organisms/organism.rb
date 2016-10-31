require 'observer'

class Organism
  include Observable

  attr_reader :location

  def initialize(location)
    @location = location
  end
end
