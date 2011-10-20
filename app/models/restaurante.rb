class Restaurante < ActiveRecord::Base
  validates_presence_of :nome
end

