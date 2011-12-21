module GruposHelper
  def autorizado(grupo, usuario)
    membro = Membro.where(:grupo_id => grupo, :usuario_id => usuario)
    !membro.autorizado_em.nil?
  end

  def verificar_propietario(usuario, dono)
    usuario.id != dono.id   
  end
end
