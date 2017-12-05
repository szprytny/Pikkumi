require 'test_helper'

class ProfileTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_type = profile_types(:one)
  end

  test "should get index" do
    get profile_types_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_type_url
    assert_response :success
  end

  test "should create profile_type" do
    assert_difference('ProfileType.count') do
      post profile_types_url, params: { profile_type: { typeName: @profile_type.typeName } }
    end

    assert_redirected_to profile_type_url(ProfileType.last)
  end

  test "should show profile_type" do
    get profile_type_url(@profile_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_type_url(@profile_type)
    assert_response :success
  end

  test "should update profile_type" do
    patch profile_type_url(@profile_type), params: { profile_type: { typeName: @profile_type.typeName } }
    assert_redirected_to profile_type_url(@profile_type)
  end

  test "should destroy profile_type" do
    assert_difference('ProfileType.count', -1) do
      delete profile_type_url(@profile_type)
    end

    assert_redirected_to profile_types_url
  end
end
