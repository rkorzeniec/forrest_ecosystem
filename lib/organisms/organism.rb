class Organism
  attr_reader :forest, :x, :y

  def initialize(forest, args = {})
    @forest = forest
    @x = args.fetch(:x)
    @y = args.fetch(:y)
  end

  private

  def valid_nearby_location_for(value)
    loop do
      new_location = value + nearby_location
      return new_location if new_location >= 0 && new_location <= (forest.size - 1)
    end
  end

  def nearby_location
    rand(3) - 1
  end
end
