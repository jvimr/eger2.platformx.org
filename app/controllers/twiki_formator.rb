require 'logger'

class TwikiFormator
	
	def format(text)
		
		ret = ""
		
		tableStarted = false
		
		text.each do |line|
			l = formatEmptyLine line
			l = formatHorizontalRule l
			
			
			if /^[ \t]*\|.*\|[ \r\n\t]*$/ =~ l
			   
				
				
				l.sub! /^[ \t]*\|/, '<tr><td>'
				
				l.sub! /\|[ \t\r\n]*$/, '</td></tr>'
				
				l.gsub! /\|/ , '</td> <td>'
				
				if !tableStarted
					l = "<table>" + l 
					tableStarted = true
				end				
				
			else
				if tableStarted
					l = "</table>" + l 
					tableStarted = false
				end
			end
				
			
			
			ret += l
		end
		
		ret
	end
	
	def formatEmptyLine(line)
		
		line.gsub! /^[ \r\t\n]*$/, '<br />'

		line
		
			
	end

	def formatHorizontalRule(line)
		
		line.gsub! /^[ \t]*[-][-][-| ][ \t\r\n]*$/, '<hr />'
		
		line
		
	end
	
	
		
  end