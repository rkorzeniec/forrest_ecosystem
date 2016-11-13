class ConsoleOutputter
  def output(context)
    print `clear`
    puts context.report_items
  end
end
