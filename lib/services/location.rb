class Location
  attr_reader :x, :y
  attr_accessor :tree, :bear, :lumberjack, :forest

  def initialize(args = {})
    @forest = args[:forest]
    @x = args[:x]
    @y = args[:y]
  end

  def free?
    return true if tree_free? && bear_free? && lumberjack_free?
  end

  def tree_free?
    tree.nil?
  end

  def bear_free?
    bear.nil?
  end

  def lumberjack_free?
    lumberjack.nil?
  end

  def neighbour_location
    forest.location(valid_nearby_location)
  end

  def to_s
    return bear.to_s if bear?
    return lumberjack.to_s if lumberjack?
    return tree.to_s if tree?
    ' '
  end

  private

  def valid_nearby_location
    loop do
      new_x = x + nearby_location
      new_y = y + nearby_location
      next if (new_x < 0 || new_y < 0) || (new_x > (forest.size - 1) || new_y > (forest.size - 1))
      next if new_x == x && new_y == y
      return { x: new_x, y: new_y }
    end
  end

  def nearby_location
    rand(3) - 1
  end
end
