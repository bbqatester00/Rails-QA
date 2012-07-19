module FitAnalyzer
  $LOAD_PATH.unshift File.dirname($PROGRAM_NAME)
  require 'Parser.rb'
  
  def command_line_interface
    # TODO: Read ARGV for options
    default_root="/Users/gsypolt/BbAssist/FitNesseRoot"
    search_type = "all"
    log_file = "/Users/gsypolt/rubyqa_project/ruby_scripts/fit_analyzer/logs/fitanalyser.log"
    fit_analyzer default_root, search_type, log_file
  end
  
  def fit_analyzer root, search, log
    
    parser = Parser.new
    file_search(root,search) { |file|
      begin
        open_file = File.open file
        violations = parser.parse open_file 
        # Perhaps we should raise an exception here instead of printing the stack. 
        print "nil" + caller if violations.class == NilClass
        print "file" + caller if violations.class == File
        violations.each {|element|
          add_to_log_file element, log
        }
        open_file.close
      rescue Errno::ENOENT
      end  
    }
  end
  
  def file_search fitNesseRoot, type
    folder = case type
      when "regression"
        "RegressionSuite"
      when "scenario"
        "ScenarioLib"
      when "component"
        "*Components"
      when "all"
        "**"
      else
        raise Exception, "Need regression, component, scenario, all, or none as second argument."
      end
    Dir.chdir(fitNesseRoot + "/LearnMainline/BbLearnTests/") {
      Dir.glob("./**/" + folder + "/**/content.txt") { |f| 
        # puts File.expand_path(f)
        yield f
      } 
    }
  end
  
  def add_to_log_file violation, path
    open_log = File.open(path, "a")
    if violation.instance_of? NilClass
      return
    elsif violation.count == 0
      return
    end
    open_log.printf violation.to_printf
    open_log.close
  end
end

include FitAnalyzer
# Execution for the entire program begins here:
command_line_interface