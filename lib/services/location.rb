require_relative 'organism_remover'

class Location
  attr_reader :x, :y
  attr_accessor :tree, :bear, :lumberjack

  def initialize(args = {})
    @forest = args[:forest]
    @x = args[:x]
    @y = args[:y]
  end

  def organisms
    organism = []
    organism << tree if tree?
    organism << lumberjack if lumberjack?
    organism << bear if bear?
    organism
  end

  def free?
    return true if tree.nil? && bear.nil? && lumberjack.nil?
    false
  end

  def tree?
    !tree.nil?
  end

  def bear?
    !bear.nil?
  end

  def lumberjack?
    !lumberjack.nil?
  end

  def neighbour_location
    forest.location(valid_nearby_location)
  end

  def remove_tree
    OrganismRemover.new(tree, self).remove(:tree)
  end

  def remove_lumberjack
    OrganismRemover.new(lumberjack, self).remove(:lumberjack)
  end

  def remove_bear
    OrganismRemover.new(bear, self).remove(:bear)
  end

  def to_s
    output = ''
    output += bear? ? bear.to_s : ' '
    output += lumberjack? ? lumberjack.to_s : ' '
    output += tree? ? tree.to_s : ' '
    output
  end

  private

  attr_reader :forest

  def valid_nearby_location
    loop do
      new_x = x + nearby_location
      new_y = y + nearby_location
      next if new_x == x && new_y == y
      next if (new_x < 0 || new_y < 0) || (new_x > (forest.size - 1) || new_y > (forest.size - 1))
      return { x: new_x, y: new_y }
    end
  end

  def nearby_location
    rand(3) - 1
  end
end
