class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def is_admin
    if !current_user.nil? && current_user.account_type == 'admin'  	    
      return true
    else
      redirect_to root_url
    end
  end
  
  def is_premium
    if !current_user.nil? && (current_user.account_type == 'premium' || current_user.account_type == 'admin')  	    
      return true
    else
      redirect_to root_url
    end
  end
  
  def is_athlete
    if !current_user.nil? && (current_user.account_type == 'premium' || current_user.account_type == 'admin' || current_user.account_type == 'athlete')  	    
      return true
    else
      redirect_to root_url
    end
  end
  
  def is_following 
  end
  
  def is_verified_user
    if !current_user.nil? && !current_user.account_type.nil?
      return true
    elsif !current_user.nil?
      redirect_to verify_user_path
    else
      flash[:notice] = "This section is for verified users. Please Sign In."   
      redirect_to authentications_path
    end	  
  end
  
  def after_sign_in_path_for(resource)
    if !current_user.account_type.nil?
      show_user_path(current_user)
    else
      verify_user_path
    end
  end
end
