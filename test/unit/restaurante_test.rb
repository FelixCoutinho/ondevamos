require 'test_helper'

class RestauranteTest < ActiveSupport::TestCase
  test "nao deve salvar restaurante sem nome" do
    restaurante = Restaurante.new
    restaurante.grupos << Grupo.find(1)
    assert !restaurante.save
  end

  test "deve salvar restaurante com nome sem grupo" do
    restaurante = Restaurante.new
    restaurante.nome = 'Comida Boa'
    assert restaurante.save
  end

  test "salvar restaurante com nome" do
    restaurante = Restaurante.new
    restaurante.nome = 'Comida Boa'
    assert restaurante.save
  end

  test "associacao com grupo somente leitura" do
    restaurante = Restaurante.new
    restaurante.nome = 'Comida Boa'
    restaurante.grupos << Grupo.find(3)
    assert restaurante.save
  end

  test "acesso associacao com grupo" do
    restaurante = Restaurante.find(2)
    assert_equal 2, restaurante.grupos.length
  end

  test "deve conter mensagem de erro de nome invalido" do
    restaurante = Restaurante.new
    assert !restaurante.save
    assert_equal "can't be blank", restaurante.errors[:nome].join('; ')
  end
end
