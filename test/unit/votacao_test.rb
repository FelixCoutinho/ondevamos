require 'test_helper'

class VotacaoTest < ActiveSupport::TestCase
  test "nao deve salvar sem data sem usuario sem restaurante e sem grupo" do
    voto = Voto.new
    assert !voto.save
  end

  test "deve conter mensagem de erro para data vazia" do
    voto = Voto.new
    voto.data = ''
    assert !voto.save
    assert_equal "can't be blank", voto.errors[:data].join('; ')
  end

  test "deve conter mensagem de erro para grupo nao informado" do
    voto = Voto.new
    assert !voto.save
    assert_equal "can't be blank", voto.errors[:grupo_id].join('; ')
  end

  test "deve conter mensagem de erro para restaurante nao informado" do
    voto = Voto.new
    assert !voto.save
    assert_equal "can't be blank", voto.errors[:restaurante_id].join('; ')
  end

  test "deve conter mensagem de erro para usuario nao informado" do
    voto = Voto.new
    assert !voto.save
    assert_equal "can't be blank", voto.errors[:usuario_id].join('; ')
  end

  test "deve ser possivel acessar o usuario" do
    voto = Voto.find(1)
    assert_equal Usuario.find(1), voto.usuario
  end

  test "deve ser possivel acessar o restaurante" do
    voto = Voto.find(1)
    assert_equal Restaurante.find(2), voto.restaurante
  end

  test "deve ser possivel acessar o grupo" do
    voto = Voto.find(1)
    assert_equal Grupo.find(2), voto.grupo
  end

  test "verificar se usuario ja votou" do
    usuario = Usuario.find(1)
    grupo = Grupo.find(2)
    voto = Voto.new
    assert voto.jaVotou(usuario, grupo)
  end

  test "verificar contagem total da votacao" do
    grupo = Grupo.find(2)
    voto = Voto.new
    assert_equal  1, voto.contagemVotacao(grupo).length
  end
end
