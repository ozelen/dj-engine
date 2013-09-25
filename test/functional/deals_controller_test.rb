require 'test_helper'

class DealsControllerTest < ActionController::TestCase
  setup do
    @deal = deals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deal" do
    assert_difference('Deal.count') do
      post :create, deal: { begin_date: @deal.begin_date, contacts: @deal.contacts, dealable_id: @deal.dealable_id, dealable_type: @deal.dealable_type, expire_date: @deal.expire_date, login: @deal.login, password: @deal.password, person_name: @deal.person_name, price: @deal.price, status: @deal.status }
    end

    assert_redirected_to deal_path(assigns(:deal))
  end

  test "should show deal" do
    get :show, id: @deal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deal
    assert_response :success
  end

  test "should update deal" do
    put :update, id: @deal, deal: { begin_date: @deal.begin_date, contacts: @deal.contacts, dealable_id: @deal.dealable_id, dealable_type: @deal.dealable_type, expire_date: @deal.expire_date, login: @deal.login, password: @deal.password, person_name: @deal.person_name, price: @deal.price, status: @deal.status }
    assert_redirected_to deal_path(assigns(:deal))
  end

  test "should destroy deal" do
    assert_difference('Deal.count', -1) do
      delete :destroy, id: @deal
    end

    assert_redirected_to deals_path
  end
end
