require 'test_helper'

class PurchaseInvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_invoice = purchase_invoices(:one)
  end

  test "should get index" do
    get purchase_invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_invoice_url
    assert_response :success
  end

  test "should create purchase_invoice" do
    assert_difference('PurchaseInvoice.count') do
      post purchase_invoices_url, params: { purchase_invoice: { balance: @purchase_invoice.balance, date: @purchase_invoice.date, deposit_id: @purchase_invoice.deposit_id, invoice_number: @purchase_invoice.invoice_number, iva: @purchase_invoice.iva, pay_method_id: @purchase_invoice.pay_method_id, provider_id: @purchase_invoice.provider_id, purchase_order_id: @purchase_invoice.purchase_order_id, stamped: @purchase_invoice.stamped, total: @purchase_invoice.total } }
    end

    assert_redirected_to purchase_invoice_url(PurchaseInvoice.last)
  end

  test "should show purchase_invoice" do
    get purchase_invoice_url(@purchase_invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_invoice_url(@purchase_invoice)
    assert_response :success
  end

  test "should update purchase_invoice" do
    patch purchase_invoice_url(@purchase_invoice), params: { purchase_invoice: { balance: @purchase_invoice.balance, date: @purchase_invoice.date, deposit_id: @purchase_invoice.deposit_id, invoice_number: @purchase_invoice.invoice_number, iva: @purchase_invoice.iva, pay_method_id: @purchase_invoice.pay_method_id, provider_id: @purchase_invoice.provider_id, purchase_order_id: @purchase_invoice.purchase_order_id, stamped: @purchase_invoice.stamped, total: @purchase_invoice.total } }
    assert_redirected_to purchase_invoice_url(@purchase_invoice)
  end

  test "should destroy purchase_invoice" do
    assert_difference('PurchaseInvoice.count', -1) do
      delete purchase_invoice_url(@purchase_invoice)
    end

    assert_redirected_to purchase_invoices_url
  end
end
