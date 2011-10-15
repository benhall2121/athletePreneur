class RegistrationsController < Devise::RegistrationsController
  before_filter :is_admin, :except => ['create', 'build_resource', 'show']
  before_filter :is_following, :only => ['show']
	
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end
  
  def index
  end
  
  def show
    @user = User.find(params[:id])	  
  end
  
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
