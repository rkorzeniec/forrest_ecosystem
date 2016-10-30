module Move
  def move(new_x, new_y)
    forest.assign_location(nil, x: x, y: y)
    forest.assign_location(self, x: new_x, y: new_y)
    @x = new_x
    @y = new_y
  end
end
