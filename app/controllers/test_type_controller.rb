class TestTypeController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  before_filter :login_required

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @test_type_pages, @test_types = paginate :test_types, :per_page => 10
  end

  def show
    @test_type = TestType.find(params[:id])
  end

  def new
    @test_type = TestType.new
  end

  def create
    @test_type = TestType.new(params[:test_type])
    if @test_type.save
      flash[:notice] = 'TestType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @test_type = TestType.find(params[:id])
  end

  def update
    @test_type = TestType.find(params[:id])
    if @test_type.update_attributes(params[:test_type])
      flash[:notice] = 'TestType was successfully updated.'
      redirect_to :action => 'show', :id => @test_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    TestType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
