class UsersController < ApplicationController
  model   :user
  layout  'scaffold'

  def login
    case @request.method
      when :post
        if @session['user'] = User.authenticate(@params['user_login'], @params['user_password'])

          flash['notice']  = "Login successful"
          redirect_back_or_default :action => "welcome"
        else
          @login    = @params['user_login']
          @message  = "Login unsuccessful"
      end
    end
  end
  
  def signup
    
    #comment out following 2 lines to get access to signup method to add new users
  #  redirect_back_or_default :action => "welcome"
    
 #   return
    
    case @request.method
      when :post
        @user = User.new(@params['user'])
        
        if @user.save      
          @session['user'] = User.authenticate(@user.login, @params['user']['password'])
          flash['notice']  = "Signup successful"
          redirect_back_or_default :action => "welcome"          
        end
      when :get
        @user = User.new
    end      
  end  
  
  def delete
    
    redirect_back_or_default :action => "welcome"
    
    return
    
    if @params['id'] and @session['user']
      @user = User.find(@params['id'])
      @user.destroy
    end
    redirect_back_or_default :action => "welcome"
  end  
    
  def logout
    @session['user'] = nil
    redirect_to :action=>'index', :controller=>'evaluator'
  end
    
  def welcome
  end
  
end
