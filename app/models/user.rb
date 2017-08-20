class User < ApplicationRecord
  DEFAULTPWD = 'ckgl888' 
  validates :name, presence: true
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
end
