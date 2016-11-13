#!/usr/bin/ruby

require './lib/forest_simulation'

simulation = ForestSimulation.new(4800)
simulation.setup
simulation.execute
