require_relative '../organisms/sapling_tree'
require_relative '../organisms/grown_tree'
require_relative '../organisms/elder_tree'

class TreeFactory
  def self.tree(type = 0, location)
    case type
    when 0 then SaplingTree.new(location)
    when 1 then GrownTree.new(location)
    when 2 then ElderTree.new(location)
    end
  end
end
