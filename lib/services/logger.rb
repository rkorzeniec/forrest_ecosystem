class Logger
  attr_reader :trees, :lumberjacks, :bears

  def initialize
    @output_stream = ''
    @trees = 0
    @lumberjacks = 0
    @bears = 0
    default_monthly_logs
    default_yearly_logs
  end

  def update(object, message_type, *args)
    method(message_type).call(object, *args)
  end

  def output_logs
    temp_output = @output_stream
    @output_stream = ''
    temp_output
  end

  def organism_counts
    "Trees: #{trees} | Lumberjacks: #{lumberjacks} | Bears: #{bears}"
  end

  def output_monthly_logs
    temp_logs = @monthly_logs
    default_monthly_logs
    "Monthly lumber: #{temp_logs[:lumber]} | Monthly mauls #{temp_logs[:mauls]}"
  end

  def output_yearly_logs
    temp_logs = @yearly_logs
    default_yearly_logs
    "Yearly lumber: #{temp_logs[:lumber]} | Yearly mauls #{temp_logs[:mauls]}"
  end

  def yearly_lumber
    @yearly_logs[:lumber]
  end

  def yearly_mauls
    @yearly_logs[:mauls]
  end

  private

  def default_monthly_logs
    @monthly_logs = { lumber: 0, mauls: 0 }
  end

  def default_yearly_logs
    @yearly_logs = { lumber: 0, mauls: 0 }
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
    @monthly_logs[:lumber] += lumber_quantity
    @yearly_logs[:lumber] += lumber_quantity
    @output_stream += "#{object.class} chopped tree. "
  end

  def maul_lumberjack(object)
    @monthly_logs[:mauls] += 1
    @yearly_logs[:mauls] += 1
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
