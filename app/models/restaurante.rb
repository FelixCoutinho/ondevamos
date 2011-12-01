class Restaurante < ActiveRecord::Base
  has_one :grupo

  validates_presence_of :nome, :grupo_id
end
