class User < ApplicationRecord
  before_save :generate_authentication_token
  DEFAULTPWD = 'ckgl888' 
  validates :name, :email, presence: true
  scope :normal, -> { where.not(name: 'administrator')}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  def check_user
    User.normal.count
  end   
  
  def self.query name
    s = "%#{name}%"
    User.where('name like ?', s)
  end
  
  def api_render
    # array = []
    hash = {}
    hash.merge!(
      username: self.name,
      email: self.email,
      access_token: self.access_token
    )
    # array << hash
    return hash
  end
  
 
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(access_token: token).first
    end
  end
end
