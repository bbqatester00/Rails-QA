class Context
  def initialize ob
    # whatever needs to be here
  end
  def to_s
    puts self
  end
  
end

class TableContext < Context
  attr_accessor :table, :type, :path, :line_num
  
  def initialize array_of_lines
    @table = array_of_lines
    compute_type
  end
  def compute_type
    first_line = @table[0]
    @type = case
      when first_line == nil
        raise error
      when (first_line =~ /\!\|script/)
        :SCRIPT_TABLE
      when (first_line =~ /ComponentDefinitionTable/)
        :COMPONENT_TABLE
      when (first_line[0...7] == "|script") 
        :LF_SCRIPT_TABLE
      when (first_line =~ /\|import/)
        :IMPORT_TABLE
      when (first_line =~ /\|switch to/)
        :CONTEXT_TABLE
      when (first_line =~ /\!\|DataPool/)
        :DATAPOOL_TABLE
      else 
        :UNDEFINED_TABLE
      end
  end
end