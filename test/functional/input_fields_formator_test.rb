require File.dirname(__FILE__) + '/../test_helper'
require 'twiki_formator'
require 'logger'

class TwikiFormatorTest < Test::Unit::TestCase
  
    def test_inputbox
      
      @logger = Logger.new(STDOUT) unless @logger
      
      
    
      line = "\n .... [ moznost1 | moznost2 | moznost3 ] sfasdf \n"
    
      l = InputFieldsFormator.format(line)
    
      @logger.debug "line [" + line + "] converted to [" + l + "]"
    
    
    
      
    end
    
    
    def test_combobox
      
      @logger = Logger.new(STDOUT) unless @logger
      
      
    
      line = "\nzacatek vety [ moznost1 | moznost2 | moznost3 ] sfasdf \n"
    
      l = InputFieldsFormator.format(line)
    
      @logger.debug "line [" + line + "] converted to [" + l + "]"
    
    
    
      
    end
    
    
    def test_matcher
      
      @logger = Logger.new(STDOUT) unless @logger
      
      line = "fasdfs [ option1 | option2 | *option3 ] asdfsaf"
      
      line.gsub! /[^\*]\[([^\[\]]*)\]/ do |match |
        @logger.debug "Match is [" +  $1 + "]"
        
        m01 = $1
        
        m01.gsub /[\||\[]\s*\*([^\]\|\[]*)/ do |m2|
          @logger.debug "submatch is [" +  $1 + "]"
        end
        
      end
      
    end
end