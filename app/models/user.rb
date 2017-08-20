class User < ApplicationRecord
  DEFAULTPWD = 'ckgl888' 
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  def check_user
    User.where.not(name: 'administrator').count
  end     
end
