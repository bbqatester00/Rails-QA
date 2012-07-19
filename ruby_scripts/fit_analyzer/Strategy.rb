class Strategy
  require 'Rule.rb'
  require 'Violation.rb'
  def initialize 

    # do something
  end
end

class TableStrategy < Strategy
  def initialize table_context_object
    unless table_context_object.class == TableContext
      raise error "table strategy was passed something not a tablecontext"
    end
    @table = table_context_object
  end
  def check
    case @table.type
    when :SCRIPT_TABLE
      script = ScriptTableStrategy.new(@table)
      return script.check()
    else
      return [Violation.new]
    end
  end
end

class ScriptTableStrategy < TableStrategy
  def initialize table_context
    @table = table_context
  end
  def check
    wait_violation = RuleWait.new(@table).check()
    nocomment_violation = RuleNoComment.new(@table).check()
    if wait_violation == nil and nocomment_violation == nil
      return [Violation.new]
    end
    return wait_violation, nocomment_violation
  end
end