require 'test_helper'

class MacroProcessesControllerTest < ActionController::TestCase
  setup do
    @macro_process = macro_processes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:macro_processes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create macro_process" do
    assert_difference('MacroProcess.count') do
      post :create, :macro_process => @macro_process.attributes
    end

    assert_redirected_to macro_process_path(assigns(:macro_process))
  end

  test "should show macro_process" do
    get :show, :id => @macro_process.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @macro_process.to_param
    assert_response :success
  end

  test "should update macro_process" do
    put :update, :id => @macro_process.to_param, :macro_process => @macro_process.attributes
    assert_redirected_to macro_process_path(assigns(:macro_process))
  end

  test "should destroy macro_process" do
    assert_difference('MacroProcess.count', -1) do
      delete :destroy, :id => @macro_process.to_param
    end

    assert_redirected_to macro_processes_path
  end
end
