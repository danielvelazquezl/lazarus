# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_03_211334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budget_request_items", force: :cascade do |t|
    t.bigint "budget_request_id"
    t.bigint "product_id"
    t.integer "price"
    t.integer "requested_quantity"
    t.integer "pending_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_request_id"], name: "index_budget_request_items_on_budget_request_id"
    t.index ["product_id"], name: "index_budget_request_items_on_product_id"
  end

  create_table "budget_requests", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "employee_id"
    t.datetime "date"
    t.string "state"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "purchase_request_id"
    t.index ["employee_id"], name: "index_budget_requests_on_employee_id"
    t.index ["provider_id"], name: "index_budget_requests_on_provider_id"
    t.index ["purchase_request_id"], name: "index_budget_requests_on_purchase_request_id"
  end

  create_table "cash_movement_invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sales_invoice_id"
    t.bigint "cash_movement_id"
    t.index ["cash_movement_id"], name: "index_cash_movement_invoices_on_cash_movement_id"
    t.index ["sales_invoice_id"], name: "index_cash_movement_invoices_on_sales_invoice_id"
  end

  create_table "cash_movement_values", force: :cascade do |t|
    t.integer "ammount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "card_number"
    t.bigint "bank_id"
    t.string "drawer"
    t.string "account_number"
    t.integer "check_number"
    t.date "emission_date"
    t.date "due_date"
    t.bigint "pay_method_id"
    t.bigint "cash_movement_id"
    t.index ["bank_id"], name: "index_cash_movement_values_on_bank_id"
    t.index ["cash_movement_id"], name: "index_cash_movement_values_on_cash_movement_id"
    t.index ["pay_method_id"], name: "index_cash_movement_values_on_pay_method_id"
  end

  create_table "cash_movements", force: :cascade do |t|
    t.datetime "date"
    t.string "comments"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cash_id"
    t.bigint "client_id"
    t.index ["cash_id"], name: "index_cash_movements_on_cash_id"
    t.index ["client_id"], name: "index_cash_movements_on_client_id"
  end

  create_table "cashes", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "state"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "person_id"
    t.string "ruc"
    t.integer "credit_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_clients_on_person_id"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "deposits", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ci"
    t.string "sex"
    t.date "birth_date"
    t.string "charge"
    t.index ["person_id"], name: "index_employees_on_person_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "form_items", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_items_on_form_id"
    t.index ["product_id"], name: "index_form_items_on_product_id"
  end

  create_table "forms", force: :cascade do |t|
    t.bigint "person_id"
    t.integer "origin_id"
    t.integer "destination_id"
    t.datetime "date"
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "form_type"
    t.integer "number"
    t.index ["person_id"], name: "index_forms_on_person_id"
  end

  create_table "movement_proof_details", force: :cascade do |t|
    t.bigint "movement_proof_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_movement_proof_details_on_deleted_at"
    t.index ["movement_proof_id"], name: "index_movement_proof_details_on_movement_proof_id"
    t.index ["product_id"], name: "index_movement_proof_details_on_product_id"
  end

  create_table "movement_proofs", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "deposit_id"
    t.bigint "movement_type_id"
    t.datetime "date"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_movement_proofs_on_deleted_at"
    t.index ["deposit_id"], name: "index_movement_proofs_on_deposit_id"
    t.index ["movement_type_id"], name: "index_movement_proofs_on_movement_type_id"
    t.index ["person_id"], name: "index_movement_proofs_on_person_id"
  end

  create_table "movement_types", force: :cascade do |t|
    t.string "description"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_movement_types_on_deleted_at"
  end

  create_table "open_close_cashes", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "start_ammount"
    t.datetime "date_start"
    t.integer "final_ammount"
    t.datetime "final_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cash_id"
    t.boolean "state"
    t.index ["cash_id"], name: "index_open_close_cashes_on_cash_id"
    t.index ["employee_id"], name: "index_open_close_cashes_on_employee_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_ticket_items", force: :cascade do |t|
    t.bigint "order_ticket_id"
    t.bigint "product_id"
    t.integer "request_quantity"
    t.integer "pending_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_ticket_id"], name: "index_order_ticket_items_on_order_ticket_id"
    t.index ["product_id"], name: "index_order_ticket_items_on_product_id"
  end

  create_table "order_tickets", force: :cascade do |t|
    t.bigint "client_id"
    t.integer "ticket_number"
    t.bigint "employee_id"
    t.bigint "pay_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.string "observation"
    t.string "state"
    t.index ["client_id"], name: "index_order_tickets_on_client_id"
    t.index ["employee_id"], name: "index_order_tickets_on_employee_id"
    t.index ["pay_method_id"], name: "index_order_tickets_on_pay_method_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "origin_id"
    t.bigint "destination_id"
    t.string "order_type"
    t.datetime "date_request"
    t.datetime "date_finished"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["destination_id"], name: "index_orders_on_destination_id"
    t.index ["origin_id"], name: "index_orders_on_origin_id"
    t.index ["person_id"], name: "index_orders_on_person_id"
  end

  create_table "pay_methods", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "phone"
    t.string "email"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_people_on_deleted_at"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "resource_id"
    t.boolean "action_read"
    t.boolean "action_create"
    t.boolean "action_update"
    t.boolean "action_destroy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_permissions_on_resource_id"
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "component_id"
    t.index ["product_id"], name: "index_product_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_type"
    t.string "bar_code"
    t.string "description"
    t.integer "unit_cost"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id"
    t.bigint "product_category_id"
    t.datetime "deleted_at"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "provider_categories", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "product_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_provider_categories_on_product_category_id"
    t.index ["provider_id"], name: "index_provider_categories_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.bigint "person_id"
    t.string "ruc"
    t.integer "credit_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_providers_on_person_id"
  end

  create_table "purchase_invoice_items", force: :cascade do |t|
    t.bigint "purchase_invoice_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "price"
    t.integer "iva"
    t.integer "sub_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_invoice_items_on_product_id"
    t.index ["purchase_invoice_id"], name: "index_purchase_invoice_items_on_purchase_invoice_id"
  end

  create_table "purchase_invoices", force: :cascade do |t|
    t.bigint "provider_id"
    t.datetime "date"
    t.integer "total"
    t.integer "iva"
    t.integer "balance"
    t.string "invoice_number"
    t.string "stamped"
    t.bigint "deposit_id"
    t.bigint "pay_method_id"
    t.bigint "purchase_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deposit_id"], name: "index_purchase_invoices_on_deposit_id"
    t.index ["pay_method_id"], name: "index_purchase_invoices_on_pay_method_id"
    t.index ["provider_id"], name: "index_purchase_invoices_on_provider_id"
    t.index ["purchase_order_id"], name: "index_purchase_invoices_on_purchase_order_id"
  end

  create_table "purchase_order_items", force: :cascade do |t|
    t.bigint "purchase_order_id"
    t.bigint "product_id"
    t.integer "price"
    t.integer "requested_quantity"
    t.integer "received_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_order_items_on_product_id"
    t.index ["purchase_order_id"], name: "index_purchase_order_items_on_purchase_order_id"
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "employee_id"
    t.datetime "date"
    t.string "state"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.bigint "purchase_request_id"
    t.index ["employee_id"], name: "index_purchase_orders_on_employee_id"
    t.index ["provider_id"], name: "index_purchase_orders_on_provider_id"
    t.index ["purchase_request_id"], name: "index_purchase_orders_on_purchase_request_id"
  end

  create_table "purchase_request_items", force: :cascade do |t|
    t.bigint "purchase_request_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchase_request_items_on_product_id"
    t.index ["purchase_request_id"], name: "index_purchase_request_items_on_purchase_request_id"
  end

  create_table "purchase_requests", force: :cascade do |t|
    t.datetime "date"
    t.bigint "employee_id"
    t.string "state"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["employee_id"], name: "index_purchase_requests_on_employee_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sales_invoices", force: :cascade do |t|
    t.bigint "employee_id"
    t.datetime "date"
    t.bigint "client_id"
    t.integer "total"
    t.integer "iva"
    t.integer "balance"
    t.integer "invoice_number"
    t.bigint "deposit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stamped_id"
    t.bigint "order_ticket_id"
    t.bigint "pay_method_id"
    t.index ["client_id"], name: "index_sales_invoices_on_client_id"
    t.index ["deposit_id"], name: "index_sales_invoices_on_deposit_id"
    t.index ["employee_id"], name: "index_sales_invoices_on_employee_id"
    t.index ["order_ticket_id"], name: "index_sales_invoices_on_order_ticket_id"
    t.index ["pay_method_id"], name: "index_sales_invoices_on_pay_method_id"
    t.index ["stamped_id"], name: "index_sales_invoices_on_stamped_id"
  end

  create_table "sales_invoices_items", force: :cascade do |t|
    t.bigint "sales_invoice_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "price"
    t.integer "iva"
    t.integer "sub_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sales_invoices_items_on_product_id"
    t.index ["sales_invoice_id"], name: "index_sales_invoices_items_on_sales_invoice_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stampeds", force: :cascade do |t|
    t.integer "number"
    t.integer "first_number"
    t.string "last_number"
    t.date "start_date"
    t.date "finish_date"
    t.string "name"
    t.string "expedition"
    t.string "branch_office"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "deposit_id"
    t.string "internal_code"
    t.integer "quantity"
    t.integer "min_stock"
    t.string "stock_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deposit_id"], name: "index_stocks_on_deposit_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "budget_request_items", "budget_requests"
  add_foreign_key "budget_request_items", "products"
  add_foreign_key "budget_requests", "employees"
  add_foreign_key "budget_requests", "providers"
  add_foreign_key "budget_requests", "purchase_requests"
  add_foreign_key "cash_movement_invoices", "cash_movements"
  add_foreign_key "cash_movement_invoices", "sales_invoices"
  add_foreign_key "cash_movement_values", "banks"
  add_foreign_key "cash_movement_values", "cash_movements"
  add_foreign_key "cash_movement_values", "pay_methods"
  add_foreign_key "cash_movements", "cashes"
  add_foreign_key "cash_movements", "clients"
  add_foreign_key "clients", "people"
  add_foreign_key "employees", "people"
  add_foreign_key "employees", "users"
  add_foreign_key "form_items", "forms"
  add_foreign_key "form_items", "products"
  add_foreign_key "forms", "people"
  add_foreign_key "movement_proof_details", "movement_proofs"
  add_foreign_key "movement_proof_details", "products"
  add_foreign_key "movement_proofs", "deposits"
  add_foreign_key "movement_proofs", "movement_types"
  add_foreign_key "open_close_cashes", "cashes"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_ticket_items", "order_tickets"
  add_foreign_key "order_ticket_items", "products"
  add_foreign_key "order_tickets", "clients"
  add_foreign_key "order_tickets", "employees"
  add_foreign_key "order_tickets", "pay_methods"
  add_foreign_key "orders", "people"
  add_foreign_key "permissions", "resources"
  add_foreign_key "permissions", "roles"
  add_foreign_key "product_items", "products"
  add_foreign_key "product_items", "products", column: "component_id"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "product_categories"
  add_foreign_key "provider_categories", "product_categories"
  add_foreign_key "provider_categories", "providers"
  add_foreign_key "providers", "people"
  add_foreign_key "purchase_invoice_items", "products"
  add_foreign_key "purchase_invoice_items", "purchase_invoices"
  add_foreign_key "purchase_invoices", "deposits"
  add_foreign_key "purchase_invoices", "pay_methods"
  add_foreign_key "purchase_invoices", "providers"
  add_foreign_key "purchase_invoices", "purchase_orders"
  add_foreign_key "purchase_order_items", "products"
  add_foreign_key "purchase_order_items", "purchase_orders"
  add_foreign_key "purchase_orders", "employees"
  add_foreign_key "purchase_orders", "providers"
  add_foreign_key "purchase_orders", "purchase_requests"
  add_foreign_key "purchase_request_items", "products"
  add_foreign_key "purchase_request_items", "purchase_requests"
  add_foreign_key "purchase_requests", "employees"
  add_foreign_key "sales_invoices", "clients"
  add_foreign_key "sales_invoices", "employees"
  add_foreign_key "sales_invoices", "order_tickets"
  add_foreign_key "sales_invoices", "pay_methods"
  add_foreign_key "sales_invoices", "stampeds"
  add_foreign_key "sales_invoices_items", "products"
  add_foreign_key "sales_invoices_items", "sales_invoices"
  add_foreign_key "stocks", "deposits"
  add_foreign_key "stocks", "products"
end
