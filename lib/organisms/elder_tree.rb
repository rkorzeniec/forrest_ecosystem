require_relative 'tree'

class ElderTree < Tree
  private

  def mature_period_in_months
    nil
  end

  def spawning_permitted?
    true
  end

  def spawn_chance
    20
  end
end
