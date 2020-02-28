require "application_system_test_case"

class OrderTicketsTest < ApplicationSystemTestCase
  setup do
    @order_ticket = order_tickets(:one)
  end

  test "visiting the index" do
    visit order_tickets_url
    assert_selector "h1", text: "Order Tickets"
  end

  test "creating a Order ticket" do
    visit order_tickets_url
    click_on "New Order Ticket"

    fill_in "Client", with: @order_ticket.client_id
    fill_in "Date", with: @order_ticket.date
    fill_in "Employee", with: @order_ticket.employee_id
    fill_in "Observation", with: @order_ticket.observation
    fill_in "Pay Method", with: @order_ticket.pay_method_id
    fill_in "State", with: @order_ticket.state
    fill_in "Ticket Number", with: @order_ticket.ticket_number
    click_on "Create Order ticket"

    assert_text "Order ticket was successfully created"
    click_on "Back"
  end

  test "updating a Order ticket" do
    visit order_tickets_url
    click_on "Edit", match: :first

    fill_in "Client", with: @order_ticket.client_id
    fill_in "Date", with: @order_ticket.date
    fill_in "Employee", with: @order_ticket.employee_id
    fill_in "Observation", with: @order_ticket.observation
    fill_in "Pay Method", with: @order_ticket.pay_method_id
    fill_in "State", with: @order_ticket.state
    fill_in "Ticket Number", with: @order_ticket.ticket_number
    click_on "Update Order ticket"

    assert_text "Order ticket was successfully updated"
    click_on "Back"
  end

  test "destroying a Order ticket" do
    visit order_tickets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order ticket was successfully destroyed"
  end
end
