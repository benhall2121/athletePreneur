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
  
end
