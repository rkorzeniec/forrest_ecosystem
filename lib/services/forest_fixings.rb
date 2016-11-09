class ForestFixings
  attr_reader :forest

  def initialize(forest)
    @forest = forest
  end

  def trees
    ((size * size) * 0.5).to_i
  end

  def lumberjacks
    ((size * size) * 0.1).to_i
  end

  def bears
    ((size * size) * 0.02).to_i
  end

  def premium_lumberjacks(total_lumberjacks, yearly_lumber)
    (yearly_lumber / total_lumberjacks).to_i
  end

  private

  def size
    @_size ||= forest.size
  end
end
