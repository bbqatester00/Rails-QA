class Violation
  attr_accessor :count, :instance, :path, :type
  
  def initialize type = :NONE, path="" 
    @type = type
    @path = path
    @instance = []
    @count = 0
  end
  def add_v line_num
    @instance << line_num
  end
  def to_s
    len = Dir.pwd.length
    return @count.to_s + " number of " + @type.to_s + " violations in " + @path[len..-1]
  end
  def to_printf
    # My attempt at pretty printing the violations. 
    return "%-3d : %10s violation in %s\n" % [@count, @type.to_s, @path[Dir.pwd.length..-1]]
  end
  #def each
    
  #end
end