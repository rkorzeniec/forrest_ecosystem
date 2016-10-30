require_relative 'tree'

class GrownTree < Tree
  private

  def mature_period_in_months
    120
  end

  def spawning_permitted?
    true
  end

  def spawn_chance
    10
  end

  def grow_to
    ElderTree
  end
end
