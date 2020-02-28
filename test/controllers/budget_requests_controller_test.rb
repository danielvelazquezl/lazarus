require 'test_helper'

class BudgetRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @budget_request = budget_requests(:one)
  end

  test "should get index" do
    get budget_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_budget_request_url
    assert_response :success
  end

  test "should create budget_request" do
    assert_difference('BudgetRequest.count') do
      post budget_requests_url, params: { budget_request: { comment: @budget_request.comment, date: @budget_request.date, employee_id: @budget_request.employee_id, provider_id: @budget_request.provider_id, state: @budget_request.state } }
    end

    assert_redirected_to budget_request_url(BudgetRequest.last)
  end

  test "should show budget_request" do
    get budget_request_url(@budget_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_budget_request_url(@budget_request)
    assert_response :success
  end

  test "should update budget_request" do
    patch budget_request_url(@budget_request), params: { budget_request: { comment: @budget_request.comment, date: @budget_request.date, employee_id: @budget_request.employee_id, provider_id: @budget_request.provider_id, state: @budget_request.state } }
    assert_redirected_to budget_request_url(@budget_request)
  end

  test "should destroy budget_request" do
    assert_difference('BudgetRequest.count', -1) do
      delete budget_request_url(@budget_request)
    end

    assert_redirected_to budget_requests_url
  end
end
