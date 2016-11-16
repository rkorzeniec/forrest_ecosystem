class ForestFixings
  attr_reader :forest_size

  def initialize(forest_size)
    @forest_size = forest_size
  end

  def trees
    ((forest_size * forest_size) * 0.5).to_i
  end

  def lumberjacks
    ((forest_size * forest_size) * 0.1).to_i
  end

  def bears
    ((forest_size * forest_size) * 0.02).to_i
  end
end
