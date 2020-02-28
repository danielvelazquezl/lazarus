require "application_system_test_case"

class PurchaseInvoicesTest < ApplicationSystemTestCase
  setup do
    @purchase_invoice = purchase_invoices(:one)
  end

  test "visiting the index" do
    visit purchase_invoices_url
    assert_selector "h1", text: "Purchase Invoices"
  end

  test "creating a Purchase invoice" do
    visit purchase_invoices_url
    click_on "New Purchase Invoice"

    fill_in "Balance", with: @purchase_invoice.balance
    fill_in "Date", with: @purchase_invoice.date
    fill_in "Deposit", with: @purchase_invoice.deposit_id
    fill_in "Invoice Number", with: @purchase_invoice.invoice_number
    fill_in "Iva", with: @purchase_invoice.iva
    fill_in "Pay Method", with: @purchase_invoice.pay_method_id
    fill_in "Provider", with: @purchase_invoice.provider_id
    fill_in "Purchase Order", with: @purchase_invoice.purchase_order_id
    fill_in "Stamped", with: @purchase_invoice.stamped
    fill_in "Total", with: @purchase_invoice.total
    click_on "Create Purchase invoice"

    assert_text "Purchase invoice was successfully created"
    click_on "Back"
  end

  test "updating a Purchase invoice" do
    visit purchase_invoices_url
    click_on "Edit", match: :first

    fill_in "Balance", with: @purchase_invoice.balance
    fill_in "Date", with: @purchase_invoice.date
    fill_in "Deposit", with: @purchase_invoice.deposit_id
    fill_in "Invoice Number", with: @purchase_invoice.invoice_number
    fill_in "Iva", with: @purchase_invoice.iva
    fill_in "Pay Method", with: @purchase_invoice.pay_method_id
    fill_in "Provider", with: @purchase_invoice.provider_id
    fill_in "Purchase Order", with: @purchase_invoice.purchase_order_id
    fill_in "Stamped", with: @purchase_invoice.stamped
    fill_in "Total", with: @purchase_invoice.total
    click_on "Update Purchase invoice"

    assert_text "Purchase invoice was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase invoice" do
    visit purchase_invoices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase invoice was successfully destroyed"
  end
end
