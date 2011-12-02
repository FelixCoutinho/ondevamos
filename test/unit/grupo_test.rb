require 'test_helper'

class GrupoTest < ActiveSupport::TestCase
  test "nao deve salvar sem nome e sem usuario" do
    grupo = Grupo.new
    assert !grupo.save
  end

  test "nao deve salvar sem nome mesmo com usuario" do
    grupo = Grupo.new
    grupo.usuario = Usuario.find(1)
    assert !grupo.save
  end

  test "nao deve salvar sem usuario mesmo com nome" do
    grupo = Grupo.new
    grupo.nome = 'Varridos'
    assert !grupo.save
  end

  test "deve salvar com usuario e nome" do
    grupo = Grupo.new
    grupo.nome = 'Varridos'
    grupo.usuario_id = 2
    assert grupo.save
  end

  test "deve conter mensagem de erro de nome invalido" do
    grupo = Grupo.new
    assert !grupo.save
    assert_equal "can't be blank", grupo.errors[:nome].join('; ')
  end

  test "deve conter mensagem de erro de usuario invalido" do
    grupo = Grupo.new
    assert !grupo.save
    assert_equal "can't be blank", grupo.errors[:usuario_id].join('; ')
  end

  test "associacao com usuarios" do
    grupo = Grupo.find(2)
    assert_equal 1, grupo.usuarios.length
  end

  test "associacao com restaurantes" do
    grupo = Grupo.find(1)
    assert_equal 2, grupo.restaurantes.length
  end

  test "associacao com usuario proprietario" do
    grupo = Grupo.find(1)
    assert_equal 'joao.silva@gmail.com', grupo.usuario.email
  end

  test "associar restaurante com grupo" do
    grupo = Grupo.find(1)
    grupo.restaurantes << Restaurante.find(2)
    assert grupo.save
  end
end
