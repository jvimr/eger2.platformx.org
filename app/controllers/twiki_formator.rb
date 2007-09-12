require 'logger'

class TwikiFormator
	
	def format(text)
		
		ret = ""
		
		tableStarted = false
		bulletListStarted = false
		olStarted = false
		
		text.each do |line|
			
			l = formatEmptyLine line
			l = formatHorizontalRule l
			
			
			if /^[ \t]*\|.*\|[ \r\n\t]*$/ =~ l   #if this line contains table
			   
				l.sub! /^[ \t]*\|/, '<tr><td>'  #replace first pipe with table row start
				
				l.sub! /\|[ \t\r\n]*$/, '</td></tr>'  #replace last pipe with table row end
				
				l.gsub! /\|/ , '</td> <td>' #replace all remaining pipes with cell delimiter
				
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
				
			if /^[ \t]*\*/ =~ l   # * => <ul>
			
				if bulletListStarted
			
					l.sub! /^[ \t]*\*/, '</li><li>'
				else
					l.sub! /^[ \t]*\*/, '<ul><li>'
					bulletListStarted = true
				end
						
				
			elsif bulletListStarted && /^[ \t]*0/ =~ l
				 l.sub! /^[ \t]*0/, '</li> </ul>'
				bulletListStarted = false
			end
			
			if /^[ \t]*[1-9][0-9]*/ =~ l   # 1 => <ol>
				if olStarted
					l.sub! /^[ \t]*[1-9][0-9]*/, '</li> <li>'
				else
					l.sub! /^[ \t]*[1-9][0-9]*/, '<ol><li>'
					olStarted = true
				end
				
			elsif olStarted &&  /^[ \t]*0/ =~ l
				l.sub! /^[ \t]*0/, '</li> </ol>'
				olStarted = false
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