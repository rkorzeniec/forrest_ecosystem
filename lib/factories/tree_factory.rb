require_relative '../organisms/sapling_tree'
require_relative '../organisms/grown_tree'
require_relative '../organisms/elder_tree'

class TreeFactory
  def self.tree(type = 0, forest, args)
    case type
    when 0 then SaplingTree.new(forest, args)
    when 1 then GrownTree.new(forest, args)
    when 2 then ElderTree.new(forest, args)
    end
  end
end
