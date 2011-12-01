require 'test_helper'

class RestauranteTest < ActiveSupport::TestCase
  test "nao deve salvar restaurante sem nome" do
    restaurante = Restaurante.new
    restaurante.grupo = Grupo.find(1)
    assert !restaurante.save
  end

  test "nao deve salvar restaurante sem grupo" do
    restaurante = Restaurante.new
    restaurante.nome = 'Comida Boa'
    assert !restaurante.save
  end

  test "salvar restaurante com nome e grupo" do
    restaurante = Restaurante.new
    restaurante.nome = 'Comida Boa'
    restaurante.grupo_id = 1
    assert restaurante.save
  end

  test "deve conter mensagem de erro de nome invalido" do
    restaurante = Restaurante.new
    assert !restaurante.save
    assert_equal "can't be blank", restaurante.errors[:nome].join('; ')
  end

  test "deve conter mensagem de erro de grupo invalido" do
    restaurante = Restaurante.new
    assert !restaurante.save
    assert_equal "can't be blank", restaurante.errors[:grupo_id].join('; ')
  end
end
