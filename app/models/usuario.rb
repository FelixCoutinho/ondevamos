# encoding: UTF-8
class Usuario < ActiveRecord::Base
  has_many :membros
  has_many :grupos, :through => :membros, :conditions => "grupos_usuarios.autorizado_em is not null"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :password, :length => { :minimum => 6, :maximum => 32 }, :allow_blank => true
end
