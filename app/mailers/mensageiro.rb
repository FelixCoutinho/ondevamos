class Mensageiro < ActionMailer::Base
  default :from => "ondevamosonline@gmail.com"

  def autorizacao(membro)
    @membro = membro
    mail(:to => @membro.grupo.usuario.email,
      :subject => "['Onde Vamos?'] Autorizar membro")
  end
end
