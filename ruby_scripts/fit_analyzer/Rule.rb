class Rule
  require 'Violation.rb'
  def initialize table
    @table = table
  end
  def check
    # placeholder
  end
end

class RuleWait < Rule
  def initilize table
    super.new(table)
  end
  def check
    i = 0
    collection = Violation.new(:wait, @table.path)
    @table.table.each_with_index {|line, no|
      if (line =~ /wait/)
        i += 1
        collection.add_v(@table.line_num + no)
      end
    }
    collection.count = i
    if collection.instance.empty?
      return nil
    else
      return collection
    end
  end
end

class RuleNoComment < Rule
  def initilize table
    super.new(table)
  end
  def check
    collection = Violation.new(:nocomment, @table.path)
    @table.table.each_with_index {|line, no|
      if (line =~ /log message/)
        collection.add_v(@table.line_num + no)
      end
    }
    if collection.instance.empty?
      collection.count = 1
      return collection
    else
      # This is a negative test so we we return a violation only if no log message was found
      return nil
    end
  end
end