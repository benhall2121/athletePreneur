class RegistrationsController < Devise::RegistrationsController
  before_filter :is_verified_user, :except => ['verify_user', 'update_verify_user']
  before_filter :is_admin, :except => ['create', 'build_resource', 'show', 'verify_user', 'update_verify_user']
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
  
  def verify_user
    @user = current_user 
  end
  
  def update_verify_user
    current_user.update_attributes( :name => params[:user][:name], :phone => params[:user][:phone], :email => params[:user][:email], :user_type_apply => params[:user][:user_type_apply])
    flash[:notice] = "Thank you! We will let you know when your account has been verified"
    redirect_to root_url
  end
  
  def admin_verify_user
    @user = User.find(:all, :conditions => ['account_type is ? or account_type = ?', nil,''])
  end
  
  def admin_update_verify_user
  	  
    @user = User.find(params[:id])
    @user.update_attributes(:account_type => params[:account_type])
    
    render :nothing => true
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
