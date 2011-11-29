class Restaurante < ActiveRecord::Base
  has_and_belongs_to_many :grupos

  validates_presence_of :nome, :grupo_id
end
