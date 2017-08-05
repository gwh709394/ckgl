require 'test_helper'

class CommodityTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commodity_type = commodity_types(:one)
  end

  test "should get index" do
    get commodity_types_url
    assert_response :success
  end

  test "should get new" do
    get new_commodity_type_url
    assert_response :success
  end

  test "should create commodity_type" do
    assert_difference('CommodityType.count') do
      post commodity_types_url, params: { commodity_type: { name: @commodity_type.name } }
    end

    assert_redirected_to commodity_type_url(CommodityType.last)
  end

  test "should show commodity_type" do
    get commodity_type_url(@commodity_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_commodity_type_url(@commodity_type)
    assert_response :success
  end

  test "should update commodity_type" do
    patch commodity_type_url(@commodity_type), params: { commodity_type: { name: @commodity_type.name } }
    assert_redirected_to commodity_type_url(@commodity_type)
  end

  test "should destroy commodity_type" do
    assert_difference('CommodityType.count', -1) do
      delete commodity_type_url(@commodity_type)
    end

    assert_redirected_to commodity_types_url
  end
end
