require 'open-uri'
class User < ActiveRecord::Base
  has_many :authentications
  has_many :posts
  
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_type, :photo, :image_url, :user_type_apply, :phone
  
  #def apply_omniauth(omniauth)
  #  self.email = omniauth['user_info']['email'] if email.blank?
  #  authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  #end
  
  has_attached_file :photo, :styles => { :small_icon => "20x20#", :icon => "40x40#", :small => "150x150>", :large_icon => '75x75>#' }, #:styles      => {:icon => "50x50#", :thumb=> "100x100#", :small  => "190x190#", :large => "500x500>" },
    :url  => "/assets/user/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/user/:id/:style/:basename.:extension",
    :default_url => "/assets/user/default/:style/default.jpg"
  
  before_validation :download_remote_image, :if => :image_url_provided?

  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    when 'twitter'
      self.apply_twitter(omniauth)
    end
    authentications.build(hash_from_omniauth(omniauth))
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end

  def twitter 
    unless @twitter_user
      provider = self.authentications.find_by_provider('twitter')
      @twitter_user = Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret) rescue nil
    end
    @twitter_user
  end
  
  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
      
      self.image_remote_url = "http://graph.facebook.com/" + extra['id'] + "/picture?type=large"
    end
  end

  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      # Example fetching extra data. Needs migration to User model:
      self.firstname = (extra['name'] rescue '')
      self.image_remote_url = extra['profile_image_url'].gsub(/_normal/,'')
      
    end
  end

  def hash_from_omniauth(omniauth)  
    {
      :provider => omniauth['provider'], 
      :uid => omniauth['uid'], 
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil), 
      :screen_name => (omniauth['extra']['user_hash']['screen_name'] rescue nil)
    }
  end
  
  def image_url_provided?
    !self.image_remote_url.blank?
  end

  def download_remote_image
    self.photo = do_download_remote_image
    self.image_remote_url = image_remote_url
  end

  def do_download_remote_image
    io = open(URI.parse(image_remote_url))
    
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end
  
  def self.search(search, type)
    if search
      where('email LIKE ? or firstname like ? or lastname like ?', "%#{search}%", "%#{search}%", "%#{search}%")
    elsif type
      where('account_type like ?', "%#{type}%")
    else	  
      scoped
    end
  end
  
end
