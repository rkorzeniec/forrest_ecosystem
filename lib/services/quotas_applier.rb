require 'forwardable'

class QuotasApplier
  extend Forwardable
  def_delegators :context, :forest, :forest_populator

  attr_accessor :quota

  def initialize(context)
    @context = context
  end

  def apply(organism_type)
    return populate(organism_type) if quota.add?
    return vacate(organism_type) if quota.remove?
  end

  private

  attr_reader :context

  def populate(organism_type)
    forest_populator.send("populate_#{organism_type}s", 1)
  end

  def vacate(organism_type)
    organism = forest.send("find_random_#{organism_type}")
    OrganismRemover.new(organism).remove(organism_type)
  end
end
