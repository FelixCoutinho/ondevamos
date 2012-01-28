# encoding: UTF-8
class Mensageiro < ActionMailer::Base
  default :from => "ondevamosonline@gmail.com"

  def autorizacao(membro)
    @membro = membro
    mail(
      :to => @membro.grupo.usuario.email,
      :subject => "['Onde Vamos?'] Autorizar membro",
      :body => @membro) do |format|
      format.html
    end
  end

  def autorizado(membro)
    @membro = membro
    mail(
      :to => @membro.usuario.email,
      :subject => "['Onde Vamos?'] Você foi autorizado",
      :body => @membro) do |format|
      format.html
    end
  end
end
