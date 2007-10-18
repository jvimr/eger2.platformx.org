class TestPageController < ApplicationController

  before_filter :login_required

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @test_page_pages, @test_pages = paginate :test_pages, :per_page => 10
  end

  def show
    @test_page = TestPage.find(params[:id])
  end

  def new
    @test_page = TestPage.new
	@testTypes = TestType.find :all
	@languages = Language.find :all
  end

  def create
    @test_page = TestPage.new(params[:test_page])
    if @test_page.save
      flash[:notice] = 'TestPage was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @test_page = TestPage.find(params[:id])
	@testTypes = TestType.find :all
	@languages = Language.find :all	
  end

  def update
    @test_page = TestPage.find(params[:id])
    if @test_page.update_attributes(params[:test_page])
      flash[:notice] = 'TestPage was successfully updated.'
      redirect_to :action => 'show', :id => @test_page
    else
      render :action => 'edit'
    end
  end

  def destroy
    TestPage.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
