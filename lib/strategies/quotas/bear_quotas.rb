class BearQuotas
  attr_reader :logger

  def initialize(logger)
    @logger = logger
  end

  def add?
    logger.yearly_mauls < 1
  end

  def remove?
    logger.yearly_mauls > 0
  end
end
