class Membro < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :grupo

  set_table_name "grupos_usuarios"

  validates_uniqueness_of :usuario_id, :scope => :grupo_id
end
