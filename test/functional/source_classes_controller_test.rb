require 'test_helper'

class SourceClassesControllerTest < ActionController::TestCase
  setup do
    @source_class = source_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_class" do
    assert_difference('SourceClass.count') do
      post :create, source_class: { description: @source_class.description, name: @source_class.name, parent_id: @source_class.parent_id }
    end

    assert_redirected_to source_class_path(assigns(:source_class))
  end

  test "should show source_class" do
    get :show, id: @source_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_class
    assert_response :success
  end

  test "should update source_class" do
    put :update, id: @source_class, source_class: { description: @source_class.description, name: @source_class.name, parent_id: @source_class.parent_id }
    assert_redirected_to source_class_path(assigns(:source_class))
  end

  test "should destroy source_class" do
    assert_difference('SourceClass.count', -1) do
      delete :destroy, id: @source_class
    end

    assert_redirected_to source_classes_path
  end
end
