class Grupo < ActiveRecord::Base
  has_many :membros
  has_many :usuarios, :through => :membros, :conditions => "grupos_usuarios.autorizado_em is not null"
  has_and_belongs_to_many :restaurantes
  belongs_to :usuario # Dono do grupo

  validates_presence_of :nome, :usuario_id
end
