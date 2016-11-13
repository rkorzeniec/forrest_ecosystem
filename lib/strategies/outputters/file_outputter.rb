class ConsoleOutputter
  def output(context)
    output = File.open('simulation_report.txt', 'w')
    context.report_items.each { |item| output << item }
    output.close
  end
end
