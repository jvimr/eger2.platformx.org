require 'logger'

class InputFieldsFormator
  
  def InputFieldsFormator.getItemVal( test_result, inputFieldIndex)
    
    itemVal = test_result[inputFieldIndex.to_i]
            
    if itemVal.nil?
      
      ApplicationController.logger.info "INFO creating new session object for input field id #{inputFieldIndex}"
      
      itemVal = Hash.new
      test_result[inputFieldIndex.to_i] = itemVal
      itemVal[:correct] = false
      itemVal[:correct_vals] = []
      itemVal[:selected] = nil
    end
    
    itemVal
    
  end
  
  def InputFieldsFormator.format(text, test_result)
    
    inputFieldIndex = 0
    ret = ""
    
    text.each do |line|
        
        #input fields - 4-20 dots followed by space and [   ... anything but [ or ] .... ]
        
        if /([\.]{4,20}[ \t]*\[([^\]\[]*)\])/ =~ line
        
          #TODO store valid choice to session?
          
          
          line.gsub! /([\.]{4,20}[ \t]*\[([^\]\[]*)\])/  do |match|
            
            options = $2
            
            itemVal = getItemVal test_result, inputFieldIndex
            
            l = "<input type=\"text\" id=\"test_field_#{ inputFieldIndex}\" name=\"test_field_#{ inputFieldIndex}\" "
            
            if itemVal[:selected]
              l += " value=\"#{itemVal[:selected]}\" "
            end
            
            if(itemVal[:correct])
              l += " disabled=\"true\""
            end
            
            if itemVal[:correct_vals].empty?
              
            end
            
            inputFieldIndex += 1
            
            l + " />"
          
          
            options.split("|").each  do |option| #iterate over each option
            
              option.strip!
            
              #cut out * and whitespaces before option
              stripped = option.sub! /^\*[ \t]*/ , "*"#TODO just for testing - replace with ""

              #if this is correct value and there are no correct values stored
              if stripped && storingOptions #store correct value
                itemVal[:correct_vals] <<  option
              
                ApplicationController.logger.info "storing correct value  #{option} value #{option} for editobox id #{inputFieldIndex - 1}"
              end #if stripped...
            end #options.split .... do
              
          end #line.gsub!..
        end
        
        #combobox options [option1|option2|validoption]
        line.gsub! /([^\*])\[([^\[\]]*)\]/ do |match|
                    
          start =  $1
          options = $2
          
          #read data from session - if user already did this test, we have to fill in what he did fill in
          itemVal = getItemVal test_result, inputFieldIndex
          
          oi = 0
          opts = []
          storingOptions = itemVal[:correct_vals].empty?
          options.split("|").each  do |option| #iterate over each item in combo box
            
            option.strip!
            
            #cut out * and whitespaces before option
            stripped = option.sub! /^\*[ \t]*/ , "*"#TODO just for testing - replace with ""

            #if this is correct value and there are no correct values stored
            if stripped && storingOptions #store correct value
              itemVal[:correct_vals] <<  oi.to_s
              
              ApplicationController.logger.info "storing correct value id #{oi} value #{option.strip} for combo id #{inputFieldIndex}"
            end
            
            selected = ""
            selected = " selected=\"true\" " if !stripped.nil? && itemVal[:selected] === oi.to_s
            
            opts << "  <option value=\"#{oi}\" #{selected}>" + option.strip + "</option>\n"
            oi += 1
          end
          
          opts.sort!{rand(20)-10}
          
          
          lstart = "\n<select name=\"test_field_#{ inputFieldIndex}\" "
          if itemVal[:correct]
            lstart += " disabled=\"true\" "
          end
          lstart += " >\n"
          lend = "</select>\n"
          
          inputFieldIndex += 1
          
          start + lstart + opts.to_s + lend
          
          
        end
        
        #radioboxes ->   *[ option1 | option2 | *valid_option1 | valid_option2]
        line.gsub! /\*\[([^\]\[]*)\]/ do |match|
          
          options = $1
          
          itemVal = getItemVal test_result, inputFieldIndex
          
          oi = 0
          opts = []
          storingOptions = itemVal[:correct_vals].empty?
          
          ds = ""
          ds = " disabled=\"true\" " if itemVal[:correct]
            
          options.split("|").each  do |option|
            
            option.strip!
            stripped = option.sub! /^\*/ , "*" #TODO just for testing - replace with ""
          
            itemVal[:correct_vals] << oi.to_s if storingOptions && stripped  
            selected = ""
            selected = " checked=\"true\"" if stripped && itemVal[:selected] === (oi.to_s)
            opts << "  <input type=\"radio\" name=\"test_field_#{ inputFieldIndex}\" value=\"#{oi}\" #{ds} #{selected}>" + option.strip + "</input><br />\n"
            oi += 1
          end
          
          opts.sort!{rand(20) - 10}

          inputFieldIndex += 1
          
          "<br /> " + opts.to_s
        end
    
     ret += line
      
  
    end

    ret += "<input type=\"hidden\" name=\"test_field_count\" value=\"#{inputFieldIndex}\" />"

  end
  
end