require 'test_helper'

class AlmocosControllerTest < ActionController::TestCase
  setup do
    @almoco = almocos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:almocos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create almoco" do
    assert_difference('Almoco.count') do
      post :create, :almoco => @almoco.attributes
    end

    assert_redirected_to almoco_path(assigns(:almoco))
  end

  test "should show almoco" do
    get :show, :id => @almoco.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @almoco.to_param
    assert_response :success
  end

  test "should update almoco" do
    put :update, :id => @almoco.to_param, :almoco => @almoco.attributes
    assert_redirected_to almoco_path(assigns(:almoco))
  end

  test "should destroy almoco" do
    assert_difference('Almoco.count', -1) do
      delete :destroy, :id => @almoco.to_param
    end

    assert_redirected_to almocos_path
  end
end
