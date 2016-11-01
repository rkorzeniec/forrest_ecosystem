class Logger
  attr_reader :trees, :lumberjacks, :bears

  def initialize
    @output_stream = ''
    @trees = 0
    @lumberjacks = 0
    @bears = 0
  end

  def update(object, message_type)
    method(message_type).call(object)
  end

  def output
    temp_output = @output_stream
    @output_stream = ''
    temp_output
  end

  def organism_counts
    "Trees: #{trees} | Lumberjacks: #{lumberjacks} | Bears: #{bears}"
  end

  private

  def tree_added(_object)
    @trees += 1
  end

  def lumberjack_added(_object)
    @lumberjacks += 1
    @output_stream += "Lumberjack was spawned\n"
  end

  def bear_added(object)
    @bears += 1
    @output_stream += "Bear was spawned\n"
  end

  def remove_tree(object)
    @trees -= 1
    @output_stream += "#{object.class} chopped tree\n"
  end

  def remove_lumberjack(object)
    @lumberjacks -= 1
    @output_stream += "#{object.class} mauled lumberjack\n"
  end

  def tree_spawned(object)
    @trees += 1
    @output_stream += "#{object.class} spawned tree\n"
  end
end
