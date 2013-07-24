require 'test_helper'

class RoomPricesControllerTest < ActionController::TestCase
  setup do
    @room_price = room_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_price" do
    assert_difference('RoomPrice.count') do
      post :create, room_price: { description: @room_price.description, measure_id: @room_price.measure_id, period_id: @room_price.period_id, room_id: @room_price.room_id, value: @room_price.value }
    end

    assert_redirected_to room_price_path(assigns(:room_price))
  end

  test "should show room_price" do
    get :show, id: @room_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_price
    assert_response :success
  end

  test "should update room_price" do
    put :update, id: @room_price, room_price: { description: @room_price.description, measure_id: @room_price.measure_id, period_id: @room_price.period_id, room_id: @room_price.room_id, value: @room_price.value }
    assert_redirected_to room_price_path(assigns(:room_price))
  end

  test "should destroy room_price" do
    assert_difference('RoomPrice.count', -1) do
      delete :destroy, id: @room_price
    end

    assert_redirected_to room_prices_path
  end
end
