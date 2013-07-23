require 'test_helper'

class SourceInstancesControllerTest < ActionController::TestCase
  setup do
    @source_instance = source_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_instance" do
    assert_difference('SourceInstance.count') do
      post :create, source_instance: { description: @source_instance.description, name: @source_instance.name, source_class_id: @source_instance.source_class_id }
    end

    assert_redirected_to source_instance_path(assigns(:source_instance))
  end

  test "should show source_instance" do
    get :show, id: @source_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_instance
    assert_response :success
  end

  test "should update source_instance" do
    put :update, id: @source_instance, source_instance: { description: @source_instance.description, name: @source_instance.name, source_class_id: @source_instance.source_class_id }
    assert_redirected_to source_instance_path(assigns(:source_instance))
  end

  test "should destroy source_instance" do
    assert_difference('SourceInstance.count', -1) do
      delete :destroy, id: @source_instance
    end

    assert_redirected_to source_instances_path
  end
end
