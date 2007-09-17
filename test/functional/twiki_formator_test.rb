require File.dirname(__FILE__) + '/../test_helper'
require 'twiki_formator'
require 'logger'

class TwikiFormatorTest < Test::Unit::TestCase
	
	
	
	def test_empty_line
	
		@logger = Logger.new(STDOUT) unless @logger
			
		t = TwikiFormator.new
		
		line = "\n"
		
		l = t.formatEmptyLine(line)
		
		@logger.debug "line [" + line + "] converted to [" + l + "]"
		
		assert_equal l, '<br />'
		
		
		
		line = "a\n"
				
		l = t.formatEmptyLine(line)
				
		@logger.debug "line [" + line + "] converted to [" + l + "]"
				
		assert_not_equal l, '<br />'
				
		
		
		
		
	end
	
	
	def test_hr
		
		@logger = Logger.new(STDOUT) unless @logger
					
    	t = TwikiFormator.new
				
		line = "---"
				
		l = t.formatHorizontalRule(line)
		
		@logger.debug "line [" + line + "] converted to [" + l + "]"
		
		assert_equal l, '<hr />'
				
	    
		line = "a---"
						
		l = t.formatHorizontalRule(line)
				
		@logger.debug "line [" + line + "] converted to [" + l + "]"
				
		assert_not_equal l, '<hr />'		
		
	end
	
	def test_hr_nl
		@logger = Logger.new(STDOUT) unless @logger
							
		t = TwikiFormator.new
						
		line = "---\ndsf\n\nsdfasdf\n\n"
						
		l = t.format(line)		
		
		@logger.debug "line [" + line + "] converted to [" + l + "]"
	end
	
		
	def test_table
			@logger = Logger.new(STDOUT) unless @logger
								
			t = TwikiFormator.new
							
			line = "---\n| cell1 | cell2 | cell3 |\n\n\n\n"
							
			l = t.format(line)		
			
			@logger.debug "line [" + line + "] converted to [" + l + "]"
	end
		
	def test_ul
				@logger = Logger.new(STDOUT) unless @logger
									
				t = TwikiFormator.new
								
				line = "---\n* item1 \n*item2\n*item 3 \n 0\n\n\n\n"
								
				l = t.format(line)		
				
				
				@logger.debug "line [" + line + "] converted to [" + l + "]"
	end
		
	
	
  end