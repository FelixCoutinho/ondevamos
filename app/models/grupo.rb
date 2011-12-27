
class Grupo < ActiveRecord::Base
  has_many :membros
  has_many :usuarios, :through => :membros, :conditions => "grupos_usuarios.autorizado_em is not null"
  has_and_belongs_to_many :restaurantes
  belongs_to :usuario # Dono do grupo

  Frequencias = {
    (DIARIA = "Todo dia") => 1,
    (UTEIS = "Todos os dias da semana (seg. a sex.)") => 2,
    (SEMANAL = "Semanal") => 3,
    (MENSAL = "Mensal") => 4,
    (ANUAL = "Anual") => 5
  }

  validates_presence_of :nome, :usuario_id, :frequencia, :inicio

  validates :inicio, :date => { :after_or_equal_to => Date.today }
end
