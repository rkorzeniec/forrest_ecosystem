class LumberjackQuotas
  attr_reader :logger

  def initialize(logger)
    @logger = logger
  end

  def add?
    logger.yearly_lumber >= logger.lumberjacks
  end

  def remove?
    add? && logger.lumberjacks > 1
  end
end
