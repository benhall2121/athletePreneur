module ApplicationHelper
	
  def username(cu)
    name = ''
    if !cu.firstname.nil? && cu.firstname != ''
      name = cu.firstname 
    end
    
    if !cu.email.nil? && name == '' && cu.email != ''
      name = cu.email 
    end
  	  
    return name
  end
  
  def already_following_user(user)
  	  if current_user.friends.include?(user)
  	  	  return true
  	  else
  	  	  return false
  	  end
  end
  
  def being_followed(user)
  	  if user.friends.include?(current_user) && !current_user.friends.include?(user)
  		return true
    	 else
    	 	 return false
  	  end  
  end
  
  def allowed_to_follow_user(user)
  	  if acount_type_greater(current_user, 'premium')
  	  	  return true  
  	  elsif being_followed(user)
  	  	  return true
  	  else
  	  	  return false
  	  end
  end
  
  def acount_type_greater(user, at)
  	  if at == 'admin'
  	  	  if user.account_type == 'admin'
  	  	  	  return true
  	  	  else
  	  	  	  return false
  	  	  end
  	  elsif at == 'premium'
  	  	  if user.account_type == 'admin' || user.account_type == 'premium'
  	  	  	  return true
  	  	  else
  	  	  	  return false
  	  	  end
  	  else
  	  	  return false
  	  end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
  def user_type
    ['Athlete', 'Company', 'Investor']  
  end
  
  def user_type_with_admin
    ['Admin'] + user_type
  end
  
  def is_admin?
    if !current_user.nil? && current_user.account_type == 'admin'
      return true
    else
      return false
    end
  end
  	
end
