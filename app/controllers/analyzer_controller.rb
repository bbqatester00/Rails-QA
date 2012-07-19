class AnalyzerController < ApplicationController
  def analyzer
  end
  
  def execute_analyzer
    alert("Executing Analyzer")    
    flash[:notice] = "Executing FitNesse Analyzer"
  end
end
