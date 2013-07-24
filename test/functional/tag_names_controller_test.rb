require 'test_helper'

class TagNamesControllerTest < ActionController::TestCase
  setup do
    @tag_name = tag_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tag_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag_name" do
    assert_difference('TagName.count') do
      post :create, tag_name: { ident: @tag_name.ident, measure_category_id: @tag_name.measure_category_id, name: @tag_name.name, tag_category_id: @tag_name.tag_category_id }
    end

    assert_redirected_to tag_name_path(assigns(:tag_name))
  end

  test "should show tag_name" do
    get :show, id: @tag_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tag_name
    assert_response :success
  end

  test "should update tag_name" do
    put :update, id: @tag_name, tag_name: { ident: @tag_name.ident, measure_category_id: @tag_name.measure_category_id, name: @tag_name.name, tag_category_id: @tag_name.tag_category_id }
    assert_redirected_to tag_name_path(assigns(:tag_name))
  end

  test "should destroy tag_name" do
    assert_difference('TagName.count', -1) do
      delete :destroy, id: @tag_name
    end

    assert_redirected_to tag_names_path
  end
end
