require "application_system_test_case"

class BudgetRequestsTest < ApplicationSystemTestCase
  setup do
    @budget_request = budget_requests(:one)
  end

  test "visiting the index" do
    visit budget_requests_url
    assert_selector "h1", text: "Budget Requests"
  end

  test "creating a Budget request" do
    visit budget_requests_url
    click_on "New Budget Request"

    fill_in "Comment", with: @budget_request.comment
    fill_in "Date", with: @budget_request.date
    fill_in "Employee", with: @budget_request.employee_id
    fill_in "Provider", with: @budget_request.provider_id
    fill_in "State", with: @budget_request.state
    click_on "Create Budget request"

    assert_text "Budget request was successfully created"
    click_on "Back"
  end

  test "updating a Budget request" do
    visit budget_requests_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @budget_request.comment
    fill_in "Date", with: @budget_request.date
    fill_in "Employee", with: @budget_request.employee_id
    fill_in "Provider", with: @budget_request.provider_id
    fill_in "State", with: @budget_request.state
    click_on "Update Budget request"

    assert_text "Budget request was successfully updated"
    click_on "Back"
  end

  test "destroying a Budget request" do
    visit budget_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Budget request was successfully destroyed"
  end
end
