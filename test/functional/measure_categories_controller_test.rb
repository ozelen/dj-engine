require 'test_helper'

class MeasureCategoriesControllerTest < ActionController::TestCase
  setup do
    @measure_category = measure_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:measure_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create measure_category" do
    assert_difference('MeasureCategory.count') do
      post :create, measure_category: { data_type: @measure_category.data_type, filter: @measure_category.filter, name: @measure_category.name }
    end

    assert_redirected_to measure_category_path(assigns(:measure_category))
  end

  test "should show measure_category" do
    get :show, id: @measure_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @measure_category
    assert_response :success
  end

  test "should update measure_category" do
    put :update, id: @measure_category, measure_category: { data_type: @measure_category.data_type, filter: @measure_category.filter, name: @measure_category.name }
    assert_redirected_to measure_category_path(assigns(:measure_category))
  end

  test "should destroy measure_category" do
    assert_difference('MeasureCategory.count', -1) do
      delete :destroy, id: @measure_category
    end

    assert_redirected_to measure_categories_path
  end
end
