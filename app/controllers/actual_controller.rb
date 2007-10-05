class ActualController < ApplicationController
  
  layout  'administration'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    #@actual_pages, @actuals = paginate :actuals, :per_page => 10
    
    @title = "Aktuality"
    
    @actual_pages = Paginator.new self, Actual.find(:all ).length, 30, params[:page]
    @actuals = Actual.find :all, 
                  #:group =>  "test_type_id",  
                  :order => 'position',
                  :limit  =>  @actual_pages.items_per_page,
                  :offset =>  @actual_pages.current.offset
    
  end

  def show
    @actual = Actual.find(params[:id])
  end

  def new
    @actual = Actual.new
  end

  def create
    @actual = Actual.new(params[:actual])
    @actual.visible = true
    if @actual.save
      flash[:notice] = 'Actual was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @actual = Actual.find(params[:id])
  end

  def update
    @actual = Actual.find(params[:id])
    
    @actual.visible = true
    
    if @actual.update_attributes(params[:actual])
      flash[:notice] = 'Actual was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Actual.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def up
    tp = Actual.find(params[:id])
    tp.move_higher
    tp.save
    
    redirect_to :action => 'list'  
  end
  
  def down
    tp = Actual.find(params[:id])
    tp.move_lower
    tp.save
    
    redirect_to :action => 'list'  
  end
end
