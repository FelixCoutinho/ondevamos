# encoding: UTF-8
class Usuario < ActiveRecord::Base
  validates_presence_of :email, :senha
  validates_format_of :email, 
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i, 
                      :message => 'tem que ser válido'
  validates :senha, :length => { :minimum => 6, :maximum => 32 }
end
