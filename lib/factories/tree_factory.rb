require_relative '../organisms/sapling_tree'
require_relative '../organisms/grown_tree'
require_relative '../organisms/elder_tree'

class TreeFactory
  def self.tree(type = 0, location, logger)
    case type
    when 0 then SaplingTree.new(location, logger)
    when 1 then GrownTree.new(location, logger)
    when 2 then ElderTree.new(location, logger)
    end
  end
end
