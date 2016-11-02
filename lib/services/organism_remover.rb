class OrganismRemover
  attr_reader :organism, :location

  def initialize(organism, location)
    @organism = organism
    @location = location
  end

  def remove(type)
    organism.location = nil
    location.send("#{type}=", nil)
    !location.send("#{type}?")
  end
end
