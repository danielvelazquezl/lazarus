require 'test_helper'

class OrderTicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_ticket = order_tickets(:one)
  end

  test "should get index" do
    get order_tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_order_ticket_url
    assert_response :success
  end

  test "should create order_ticket" do
    assert_difference('OrderTicket.count') do
      post order_tickets_url, params: { order_ticket: { client_id: @order_ticket.client_id, date: @order_ticket.date, employee_id: @order_ticket.employee_id, observation: @order_ticket.observation, pay_method_id: @order_ticket.pay_method_id, state: @order_ticket.state, ticket_number: @order_ticket.ticket_number } }
    end

    assert_redirected_to order_ticket_url(OrderTicket.last)
  end

  test "should show order_ticket" do
    get order_ticket_url(@order_ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_ticket_url(@order_ticket)
    assert_response :success
  end

  test "should update order_ticket" do
    patch order_ticket_url(@order_ticket), params: { order_ticket: { client_id: @order_ticket.client_id, date: @order_ticket.date, employee_id: @order_ticket.employee_id, observation: @order_ticket.observation, pay_method_id: @order_ticket.pay_method_id, state: @order_ticket.state, ticket_number: @order_ticket.ticket_number } }
    assert_redirected_to order_ticket_url(@order_ticket)
  end

  test "should destroy order_ticket" do
    assert_difference('OrderTicket.count', -1) do
      delete order_ticket_url(@order_ticket)
    end

    assert_redirected_to order_tickets_url
  end
end
