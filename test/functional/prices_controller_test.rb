require 'test_helper'

class PricesControllerTest < ActionController::TestCase
  setup do
    @price = room_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create price" do
    assert_difference('Price.count') do
      post :create, price: { description: @price.description, measure_id: @price.measure_id, period_id: @price.period_id, room_id: @price.room_id, value: @price.value }
    end

    assert_redirected_to room_price_path(assigns(:price))
  end

  test "should show price" do
    get :show, id: @price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @price
    assert_response :success
  end

  test "should update price" do
    put :update, id: @price, price: { description: @price.description, measure_id: @price.measure_id, period_id: @price.period_id, room_id: @price.room_id, value: @price.value }
    assert_redirected_to room_price_path(assigns(:price))
  end

  test "should destroy price" do
    assert_difference('Price.count', -1) do
      delete :destroy, id: @price
    end

    assert_redirected_to room_prices_path
  end
end
