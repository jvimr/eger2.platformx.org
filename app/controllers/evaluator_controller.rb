class EvaluatorController < ApplicationController
	
	def initialize
		@f = TwikiFormator.new
	end
	
	
	def index
		#layout 'empty'
		@title = "index"
		render :layout=>'empty'
	end
	
	def home
		@title = "Hlavicka - rozcestnik"
		
		
		@actuals = Actual.find(:all).select{|a| a.visible? }
		
		#@actual_pages, @actuals = paginate , :per_page => 10
				
	end
	
	
	def pages_de(id)
		
		#@test_pages = TestPage.find(:all).select {|a| a.TestType.name == 'de_korresp'}
		@test_pages_pages = Paginator.new self, TestPage.find(:all, :conditions => [ "test_type_id == ?", id] ).length, 10, params[:page]
	    @test_pages = TestPage.find :all, 
									:conditions => [ "test_type_id == ?", id],  
		              				:order => 'position',
								  	:limit  =>  @test_pages_pages.items_per_page,
								  	:offset =>  @test_pages_pages.current.offset		
	end
	
	def korrespondenz
			
			@title = "Arbeitsblatter handelskorrespondenz"
			
			@DE_KORRESP_ID = 6
			
			pages_de @DE_KORRESP_ID
			
	end
	
	def grammatik
		@title = "Arbeitsblatter grammatik"
		
		
		pages_de 7
	end
	
	def audio
		@title = "Online ubungen audio"
		
		pages_de 4
		
		@test_pages.each do |p|
			p.skore = 1
			p.fertig = false
		end
	end
	
	def texte
		@title = "Online ubungen texte"
		
		pages_de 5
		
		@test_pages.each do |p|
					p.skore = 5
					p.fertig = false
		end		
		
	end
	
	def texte_test
		@title = "Online ubungen texte"
		
		@test_page = TestPage.find params[:id]
		
		@test_page.top_text = @f.format @test_page.top_text
		@test_page.test_text = @f.format @test_page.test_text
	end
	
	def texte_eval
		
		flash[:notice] = 'Test id ' + params[:id] + ' successfully done.'
	    redirect_to :action => 'texte'		
		
	end
	
	def audio_test
		@title = "Online ubungen audio"
		
		@test_page = TestPage.find params[:id]
	end
	
	def audio_eval
			
			flash[:notice] = 'Test id ' + params[:id] + ' successfully done.'
			redirect_to :action => 'audio'		
			
   	end	
	
end
