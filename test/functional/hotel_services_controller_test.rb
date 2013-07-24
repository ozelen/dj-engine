require 'test_helper'

class HotelServicesControllerTest < ActionController::TestCase
  setup do
    @hotel_service = hotel_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hotel_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hotel_service" do
    assert_difference('HotelService.count') do
      post :create, hotel_service: { description: @hotel_service.description, hotel_id: @hotel_service.hotel_id, name: @hotel_service.name, price: @hotel_service.price, service_type_id: @hotel_service.service_type_id }
    end

    assert_redirected_to hotel_service_path(assigns(:hotel_service))
  end

  test "should show hotel_service" do
    get :show, id: @hotel_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hotel_service
    assert_response :success
  end

  test "should update hotel_service" do
    put :update, id: @hotel_service, hotel_service: { description: @hotel_service.description, hotel_id: @hotel_service.hotel_id, name: @hotel_service.name, price: @hotel_service.price, service_type_id: @hotel_service.service_type_id }
    assert_redirected_to hotel_service_path(assigns(:hotel_service))
  end

  test "should destroy hotel_service" do
    assert_difference('HotelService.count', -1) do
      delete :destroy, id: @hotel_service
    end

    assert_redirected_to hotel_services_path
  end
end
