class OrganismRemover
  attr_reader :organism, :location

  def initialize(organism)
    @organism = organism
    @location = organism.location
  end

  def remove(type)
    organism.location = nil
    location.send("#{type}=", nil)
    !location.send("#{type}?")
  end
end
