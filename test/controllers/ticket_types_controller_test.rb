require "test_helper"

class TicketTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ticket_types_index_url
    assert_response :success
  end

  test "should get create" do
    get ticket_types_create_url
    assert_response :success
  end

  test "should get update" do
    get ticket_types_update_url
    assert_response :success
  end

  test "should get destroy" do
    get ticket_types_destroy_url
    assert_response :success
  end
end
