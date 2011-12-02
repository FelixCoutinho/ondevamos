class Restaurante < ActiveRecord::Base
  has_and_belongs_to_many :grupos, :readonly => true

  validates_presence_of :nome
end
