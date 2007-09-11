class AdministrationController < ApplicationController
	
	before_filter :login_required
	
	def index
		list
	  	render :action => 'list'
	end
	
	def list
		@test_pages_pages = Paginator.new self, TestPage.find(:all, :conditions => [ "test_type_id == ?", id] ).length, 10, params[:page]
		@test_pages = TestPage.find :all, 
									:group =>  "test_type_id",  
									:order => 'position',
									:limit  =>  @test_pages_pages.items_per_page,
									:offset =>  @test_pages_pages.current.offset
									
		@title = "Administration"	
		
				
	end
	
	def view
		@test_page = TestPage.find params[:id]
		
		
	end
	
	def new
		@test_page = TestPage.new
		
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
	
	def update
		@test_page = TestPage.find(params[:id])
		
		if @test_page.update_attributes(params[:test_page])
			 flash[:notice] = 'Test byl ulozen'
			 redirect_to :action => 'list'
		else
			 render :action => 'edit'
		end		
	end
end
