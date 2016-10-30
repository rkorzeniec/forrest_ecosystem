require_relative 'tree'

class SaplingTree < Tree
  def to_s
    't'.green
  end

  private

  def mature_period_in_months
    12
  end

  def spawning_permitted?
    false
  end

  def spawn_chance
    0
  end

  def grow_to
    GrownTree
  end
end
