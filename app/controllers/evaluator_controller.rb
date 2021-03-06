class EvaluatorController < ApplicationController
	
	def initialize
    super 
		@f = TwikiFormator.new
	end
	
	
	def index
		#layout 'empty'
		@title = "index"
		render :layout=>'empty'
	end
	
  def podcasts
    @title = "Podcasts"
  end
  
  def dics
    @title = "Wörterbücher"
  end
  
  def kontakt
    @title = "Kontakt"
  end
  
  def links
    @title = "Links"
  end
  
	def home
		@title = "Home"
		
		@actuals = Actual.find( :all, :order => 'position' ).select{|a| a.visible? }
		#@actuals = Actual.find(:all).select{|a| a.visible? }
		
		#@actual_pages, @actuals = paginate , :per_page => 10
				
	end
	
	
	def pages_de(id)
		
		#@test_pages = TestPage.find(:all).select {|a| a.TestType.name == 'de_korresp'}
		@test_pages_pages = Paginator.new self, TestPage.find(:all, :conditions => [ "test_type_id == ?", id] ).length, 30, params[:page]
	    @test_pages = TestPage.find :all, 
									:conditions => [ "test_type_id == ?", id],  
		              				:order => 'position',
								  	:limit  =>  @test_pages_pages.items_per_page,
								  	:offset =>  @test_pages_pages.current.offset		
	end
	
	def korrespondenz
			
			@title = "Arbeitsblatter Handelskorrespondenz"
			
			@DE_KORRESP_ID = 6
			
			pages_de @DE_KORRESP_ID
      
      count_results
			
	end
	
	def grammatik
		@title = "Grammatische Tests"
		
		
		pages_de 7
    
    count_results
	end
	
	def audio
		@title = "Die Liste der Hörtexte"
    
    session[:tests] = nil if params[:clearcache]
		
		pages_de 4
    
    count_results
  end
	
  def count_results 
    @completed_tests_count = 0
    @total_questions_count = 0
    @attempted_tests_count = 0
    @correct_answers_count = 0
    
		@test_pages.each do |p|
			res = get_test_result p.id.to_s
          
          logger.info "INFO got no results for test id #{p.id}" if res.nil?
          logger.info "INFO got following results for test id #{p.id}: #{res}" if res.length > 0
          
          @attempted_tests_count += 1 if res.length > 0
          
          p.skore = 0
          res.each_value do |val|
            p.skore += 1 if val[:correct]
            @correct_answers_count += 1 if val[:correct]
            
            @total_questions_count += 1 
          end
          
          p.fertig = (p.skore == res.length) && res.length > 0
          p.fertig = false if res.length == 0
          
          @completed_tests_count += 1 if p.fertig
          
          p.skore = round1((p.skore.to_f / res.length) * 100 ) if res.length > 0
          p.skore = 0.0 if res.length == 0
   
 
    end #@test_pages.each.....
    
    #@total_questions_count = "?"
    #@completed_tests_count = "?"
    @completed_tests_percent = "-0 %"
    @completed_tests_percent =  round1((@completed_tests_count.to_f / @test_pages.length ) * 100 ).to_s + " %" if @test_pages.length > 0

    @total_score = "0 %"
    @total_score = round1((@correct_answers_count.to_f / @total_questions_count) * 100).to_s + " %" if  @total_questions_count > 0
    
    @attempted_tests_percent = "0 %"
    @attempted_tests_percent = round1((@attempted_tests_count.to_f /  @test_pages.length ) * 100).to_s + " %" if @test_pages.length > 0
    
	
  end
	
  def round1(flt)
    ((flt*10).round.to_f)/10
  end
  
	def texte
		@title = "Online Übungen Texte"
    
    session[:tests] = nil if params[:clearcache]
    
		
		pages_de 5
		
		count_results
		
	end
	
  def get_test_result(id)
    
    tests = session[:tests]
    
    if tests.nil?
        logger.info "INFO: creating new item in session for tests"
        tests = Hash.new
        session[:tests] = tests
      
    end
    
    test_result = tests[id]
    
    if test_result.nil?
      
      logger.info "INFO creating new session item for test id #{id}"
      
      test_result = Hash.new
      tests[id] = test_result
     
    end
    
    test_result
    
  end
  
	def texte_test
   
   session[:tests][params[:id]] = nil if params[:clearcache]
    
    test_result_params = get_test_result params[:id]
    
		@test_page = TestPage.find params[:id]
		
    @title = "Online Übungen Text - " +  @test_page.name
    
		@test_page.top_text =  @f.format @test_page.top_text
		@test_page.test_text = @f.format(InputFieldsFormator.format( @test_page.test_text, test_result_params))
    
    
	end
	
	def texte_eval
		
    test_result = get_test_result params[:id]
      
    fieldCount = params[:test_field_count]  
    
    correctCount = eval_test params, test_result, fieldCount
    
    
    flash[:notice] = "Richtig #{correctCount} aus #{  fieldCount} Fragen" if correctCount > 0 && fieldCount.to_i > 0
      
    
    redirect_to :action => 'texte'    
  end
    
  def eval_test(params, test_result, fieldCount)
    
    logger.info "INFO got #{test_result.length} items stored in session for test id #{params[:id]}"
    logger.info "INFO got following items stored for test id #{params[:id]}: [#{test_result.keys.collect{|a| "#{a} "}}]"
   # msg = "count #{fieldCount} " 
   
    correctCount = 0;
    0.upto(fieldCount.to_i - 1) do |i|
      name = "test_field_#{i}"
      
      val = params[name]
      
      #msg += "#{name}=>#{val}," if val

      id1 = i.to_i
      tr = test_result[id1]
      logger.warn "WARN no result stored for input id #{id1} test id #{params[:id]} - #{tr}" if tr.nil?
      
      if tr

        logger.info "INFO item id #{id1}, selected value is #{val}, correct values are #{tr[:correct_vals]}, correct value already selected=>#{tr[:correct]}"
      
        if val  && !tr[:correct]
          val.strip!
        
          tr[:selected] = val
          tr[:correct] = tr[:correct_vals].include? val
          
          logger.info "INFO item id #{id1}, correct!" if tr[:correct]
          
        #  msg += " id #{id1} - correct! " if tr[:correct]
      
        end
        correctCount += 1 if tr[:correct]
      end
      
    end
    correctCount
		
	end
	
	def audio_test
		
    
    session[:tests][params[:id]] = nil if params[:clearcache]
		
    test_result_params = get_test_result params[:id]
    
		@test_page = TestPage.find params[:id]
    
    
    
    #@test_page.top_text =  @f.format @test_page.top_text
    @test_page.test_text = @f.format(InputFieldsFormator.format( @test_page.test_text, test_result_params, false, false), "0")
    
    @title = "Online Übungen Audio - " + @test_page.name
    
	end
	
	def audio_eval
			
      test_result = get_test_result params[:id]
      
      fieldCount = params[:test_field_count]  
    
      correctCount = eval_test params, test_result, fieldCount
    
    
      flash[:notice] = "Richtig #{correctCount} aus #{fieldCount} Fragen" if correctCount > 0 && fieldCount.to_i > 0
     
      
			#flash[:notice] = 'Test id ' + params[:id] + ' successfully done.'
			redirect_to :action => 'audio'		
			
	end
	
  def texte_orig
    @title = "Gramatische teste"
    
    session[:tests] = nil if params[:clearcache]
    
    
    pages_de 3
    
    count_results
    
  end
  
  def texte_orig_test
   
      session[:tests][params[:id]] = nil if params[:clearcache]
    
    test_result_params = get_test_result params[:id]
    
    @test_page = TestPage.find params[:id]
    
    @title = "Gramatische Test - " +  @test_page.name
    
    @test_page.top_text =  @f.format @test_page.top_text
    @test_page.test_text = @f.format(InputFieldsFormator.format( @test_page.test_text, test_result_params))
    
    
  end
  
  def texte_orig_eval
    
    test_result = get_test_result params[:id]
      
    fieldCount = params[:test_field_count]  
    
    correctCount = eval_test params, test_result, fieldCount
    
    
    flash[:notice] = "Richtig #{correctCount} aus #{fieldCount} Fragen" if correctCount > 0 && fieldCount.to_i > 0
      
    
    redirect_to :action => 'texte_orig'    
  end
end
