class Parser
  # Defines the parse method which will accept an open file.
  # At this time it will create tables from the files.
  # Once a table is complete, parse will create a Table Context object
  # and send that to the Table Strategy object. 
  require 'Strategy.rb'
  require 'Context.rb'
  def initialize
    # Initializing the parser object
  end
  
  def parse file
    in_table = false
    scratch = Array.new
    table_a = Array.new
    create_table = Proc.new {
      context = TableContext.new(scratch)
      context.line_num = file.lineno
      #print file
      context.path = File.expand_path(file.path)
      strategy = TableStrategy.new(context)
      return strategy.check
    }
    file.each_line { |line|
      if (line[0] == "|") or (line[0,2] == "!|")
        in_table = true
        scratch << line
        create_table.call if file.eof?
      else
        if in_table
          create_table.call
        end
        in_table = false
      end
    }
    return [Violation.new]
  end
end