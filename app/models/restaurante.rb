class Restaurante < ActiveRecord::Base
  has_and_belongs_to_many :grupos, :readonly => true
  belongs_to :usuario # Dono do restaurante

  validates_presence_of :nome, :usuario_id
  validates_uniqueness_of :nome
end
