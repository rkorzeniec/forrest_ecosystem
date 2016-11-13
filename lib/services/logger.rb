class Logger
  attr_reader :trees, :lumberjacks, :bears, :total

  def initialize
    @output_stream = ''
    @trees = 0
    @lumberjacks = 0
    @bears = 0
    @total = { lumber: 0, mauls: 0 }
    default_monthly_counts
    default_yearly_counts
  end

  def update(object, message_type, *args)
    method(message_type).call(object, *args)
  end

  def output_logs
    temp_output = @output_stream
    @output_stream = ''
    temp_output
  end

  def monthly_counts
    temp_logs = @monthly
    default_monthly_counts
    temp_logs
  end

  def yearly_counts
    temp_logs = @yearly
    default_yearly_counts
    temp_logs
  end

  def yearly_lumber
    @yearly[:lumber]
  end

  def yearly_mauls
    @yearly[:mauls]
  end

  private

  def default_monthly_counts
    @monthly = { lumber: 0, mauls: 0 }
  end

  def default_yearly_counts
    @yearly = { lumber: 0, mauls: 0 }
  end

  def tree_added(object)
    @trees += 1
    @output_stream += "#{object.class} was spawned\n"
  end

  def lumberjack_added(_object)
    @lumberjacks += 1
    @output_stream += "Lumberjack was spawned\n"
  end

  def bear_added(_object)
    @bears += 1
    @output_stream += "Bear was spawned\n"
  end

  def chop_tree(object, lumber_quantity)
    @monthly[:lumber] += lumber_quantity
    @yearly[:lumber] += lumber_quantity
    @total[:lumber] += lumber_quantity
    @output_stream += "#{object.class} chopped tree. "
  end

  def maul_lumberjack(object)
    @monthly[:mauls] += 1
    @yearly[:mauls] += 1
    @total[:mauls] += 1
    @output_stream += "#{object.class} mauled lumberjack. "
  end

  def tree_removed(object)
    @trees -= 1
    @output_stream += "#{object.class} removed\n"
  end

  def lumberjack_removed(object)
    @lumberjacks -= 1
    @output_stream += "#{object.class} removed\n"
  end

  def bear_removed(object)
    @bears -= 1
    @output_stream += "#{object.class} removed\n"
  end
end
