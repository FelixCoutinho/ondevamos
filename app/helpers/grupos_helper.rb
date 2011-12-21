module GruposHelper
  def autorizado(grupo, usuario)
    grupo.usuarios.include? usuario
  end

  def aguardandoAutorizacao(grupo, usuario)
    membro = Membro.where(:grupo_id => grupo, :usuario_id => usuario)
    if !membro.first.nil?
      membro.first.autorizado_em.nil?
    else
      false
    end
  end

  def verificar_propietario(usuario, dono)
    usuario.id == dono.id
  end
end
