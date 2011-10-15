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
	
end
