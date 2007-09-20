class AdministrationController < ApplicationController
	
	before_filter :login_required
	
	def index
		list
	  	render :action => 'list'
	end
	
	def list
		@test_pages_pages = Paginator.new self, TestPage.find(:all ).length, 10, params[:page]
		@test_pages = TestPage.find :all, 
									#:group =>  "test_type_id",  
									:order => 'language_id, test_type_id, position',
									:limit  =>  @test_pages_pages.items_per_page,
									:offset =>  @test_pages_pages.current.offset
									
		@title = "Administration"	
		
				
	end
	
	def view
		@test_page = TestPage.find params[:id]
		
		
	end
	
	def new
		@test_page = TestPage.new
		
    @test_page.test_type_id = params[:id]
    case @test_page.test_type_id
     # when 4 #de_audio
     # when 6 #de_korresp
     # when 7 #de_grammar
     # when 3 #de_orig
     # when 5 #de_text
      when 3..7  
        @test_page.language_id = 2
        
      when 1 #en_orig
        @test_page.language_id = 1
      when 2 #fr_orig
        @test_page.language_id = 3
     
   end
   
    params[:id] = nil
    
		@testTypes = TestType.find :all
		@languages = Language.find :all		
	end
	
	def create
		@test_page = TestPage.new(params[:test_page])
		if @test_page.save
		  flash[:notice] = 'Test byl vytvoren.'
		  redirect_to :action => 'list'
		else
		  render :action => 'new'
		end
	end	
	
	def edit
		@test_page = TestPage.find params[:id]
		@testTypes = TestType.find :all
		@languages = Language.find :all		
    
    
	end
	
  
  def destroy
    t = TestPage.find(params[:id]).destroy 
    #t.deleted = true
    #t.save
    
    redirect_to :action => 'list'
  end
  
	def update
		@test_page = TestPage.find(params[:id])
		
		if @test_page.update_attributes(params[:test_page])
			 flash[:notice] = 'Test byl ulozen'
			 redirect_to :action => 'list'
		else
			 render :action => 'edit'
		end		
  end

  def up
    
    tp = TestPage.find(params[:id])
    
    tp.move_higher
    tp.save
    
    redirect_to :action => 'list'  
    
  end
  
  def down
    
    tp = TestPage.find(params[:id])
    
    tp.move_lower
    tp.save
    
    redirect_to :action => 'list'
  end
end
