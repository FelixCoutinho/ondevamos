# encoding: UTF-8
require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  test "nao deve salvar sem email e sem password" do
    usuario = Usuario.new
    assert !usuario.save
  end

  test "deve conter mensagem de erro para email vazio" do
    usuario = Usuario.new
    usuario.password = 'GT%*%!grQ'
    usuario.email = ''
    assert !usuario.save
    assert_equal "can't be blank", usuario.errors[:email].join('; ')
  end

  test "deve conter mensagem de erro para password vazio" do
    usuario = Usuario.new
    usuario.email = 'francisco@aol.com'
    usuario.password = ''
    assert !usuario.save
    assert_equal "can't be blank", usuario.errors[:password].join('; ')
  end

  test "nao deve salvar com email em formato invalido" do
    usuario = Usuario.new
    usuario.email = 'francisco@.com'
    assert !usuario.save
  end

  test "deve conter mensagem de email invalido" do
    usuario = Usuario.new
    usuario.email = 'francisco@.com'
    assert !usuario.save
    assert_equal "is invalid", usuario.errors[:email].join('; ')
  end

  test "deve conter mensagem de password com formato invalido" do
    usuario = Usuario.new
    usuario.password = 'GT%RQ'
    assert_equal "", usuario.errors[:password].join('; ')
    assert !usuario.save
  end

  test "associacao com grupo" do
    usuario = Usuario.find(1)
    assert_equal 2, usuario.grupos.length
  end
end
