class Voto < ActiveRecord::Base
  has_one :usuario
  has_one :restaurante

  validates_associated :usuario, :restaurante

  validates :data, :presence => true
end

