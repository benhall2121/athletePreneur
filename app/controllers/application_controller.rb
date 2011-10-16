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
    if !current_user.nil? && !current_user.account_type.nil?
      show_user_path(current_user)
    else
      verify_user_path
    end
  end
  
  def html_truncate(html, truncate_length, options={})
    text, result = [], []
    # get all text (including punctuation) and tags and stick them in a hash
    html.scan(/<\/?[^>]*>|[A-Za-z0-9.,\/&#;\!\+\(\)\-"'?]+/).each { |t| text << t }
    text.each do |str|
      if truncate_length > 0
        if str =~ /<\/?[^>]*>/
          previous_tag = str
          result << str
        else
          result << str
          truncate_length -= str.length
        end
      else
        # now stick the next tag with a  that matches the previous
        # open tag on the end of the result
        if previous_tag && str =~ /<\/([#{previous_tag}]*)>/
          result << str
        end
      end
    end
    return result.join(" ") + options[:omission].to_s
  end
  
  
  
  
  
  
  
  
end
