class UsersController < ApplicationController
  model   :user
  layout  'administration'

  def login
    
    case @request.method
      when :post
        if @session['user'] = User.authenticate(@params['user_login'], @params['user_password'])

          flash[:notice]  = "Login successful"
          redirect_back_or_default :action => "welcome"
        else
          @login    = @params['user_login']
          @message  = "Login unsuccessful"
          
        end
      else
        render :layout=> 'scaffold'
    end
  end
  
  def signup
    
    #comment out following 2 lines to get access to signup method to add new users
    redirect_back_or_default :action => "welcome"
    
    return
    
    case @request.method
      when :post
        @user = User.new(@params['user'])
        
        if @user.save      
          @session['user'] = User.authenticate(@user.login, @params['user']['password'])
          flash[:notice]  = "Signup successful"
          redirect_back_or_default :action => "welcome"          
        end
      when :get
        @user = User.new
    end      
  end  
  
  def delete
    
    redirect_back_or_default :action => "welcome"
    
    return
    
    if @params['id'] and session['user']
      @user = User.find(@params['id'])
      @user.destroy
    end
    redirect_back_or_default :action => "welcome"
  end  
    
  def logout
    session['user'] = nil
    redirect_to :action=>'index', :controller=>'evaluator'
  end
    
  def welcome
  end
  
  def chpw
    user = session['user']
    if user.nil?
      redirect_to :action=>'login', :controller=>'users'
      return
    end
    
    case request.method
      when :post
    
      if params['chpw']['password_confirmation'].nil?
       # Logger.warn "WARN New passwords param is null"
        flash[:notice]  = "New passwords param is null"
        return
      end
    
      if params['chpw']['password'] != params['chpw']['password_confirmation']
        
        flash[:notice]  = "Nove heslo neodpovida potvrzeninoveho hesla"    
        return
      end
    
      user = User.authenticate(user.login, params['chpw']['old_password'])
      
      if user.nil?
       
        flash[:notice]  = "Spatne heslo"    
        return
      end
      
      if (params['chpw']['password'].nil? ||
          params['chpw']['password'].length < 3 || 
          params['chpw']['password'].length > 40 )
         
         flash[:notice]  = "Heslo je prilis kratke"
         return
      end
    
      user.change_password(params['chpw']['password'])
      
      flash[:notice]  = "Heslo zmeneno"
      
      when :get
        return
    else
      flash[:notice]  = "unknown method #{request.method}"
    end
    
  end
  
end
