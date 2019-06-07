# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( products.css )
Rails.application.config.assets.precompile += %w( products.js )

Rails.application.config.assets.precompile += %w( orders.css )
Rails.application.config.assets.precompile += %w( orders.js )

Rails.application.config.assets.precompile += %w( brands.css )
Rails.application.config.assets.precompile += %w( brands.js )

Rails.application.config.assets.precompile += %w( product_categories.css )
Rails.application.config.assets.precompile += %w( product_categories.js )

Rails.application.config.assets.precompile += %w( welcome.css )
Rails.application.config.assets.precompile += %w( welcome.js )


Rails.application.config.assets.precompile += %w( devise/sessions.css )
Rails.application.config.assets.precompile += %w( devise/sessions.js )

Rails.application.config.assets.precompile += %w( devise/passwords.css )
Rails.application.config.assets.precompile += %w( devise/passwords.js )
Rails.application.config.assets.precompile += %w( devise/registrations.css )
Rails.application.config.assets.precompile += %w( devise/registrations.js)

Rails.application.config.assets.precompile += %w( deposits.css)
Rails.application.config.assets.precompile += %w( deposits.js)

Rails.application.config.assets.precompile += %w( movement_proofs.css )
Rails.application.config.assets.precompile += %w( movement_proofs.js)

Rails.application.config.assets.precompile += %w( movement_types.css )
Rails.application.config.assets.precompile += %w( movement_types.js )

Rails.application.config.assets.precompile += %w( forms.css )
Rails.application.config.assets.precompile += %w( forms.js )

Rails.application.config.assets.precompile += %w( order_tickets.css )
Rails.application.config.assets.precompile += %w( order_tickets.js )

Rails.application.config.assets.precompile += %w( stocks.css )
Rails.application.config.assets.precompile += %w( stocks.js )

Rails.application.config.assets.precompile += %w( sales_invoices.css )
Rails.application.config.assets.precompile += %w( sales_invoices.js )

Rails.application.config.assets.precompile += %w( roles.css )
Rails.application.config.assets.precompile += %w( roles.js )

Rails.application.config.assets.precompile += %w( cash_movements.css )
Rails.application.config.assets.precompile += %w( cash_movements.js )

Rails.application.config.assets.precompile += %w( clients.css )
Rails.application.config.assets.precompile += %w( clients.js )

Rails.application.config.assets.precompile += %w( employees.css )
Rails.application.config.assets.precompile += %w( employees.js )

Rails.application.config.assets.precompile += %w( providers.css )
Rails.application.config.assets.precompile += %w( providers.js )

Rails.application.config.assets.precompile += %w( users.css )
Rails.application.config.assets.precompile += %w( users.js )

Rails.application.config.assets.precompile += %w( permissions.css )
Rails.application.config.assets.precompile += %w( permissions.js )

Rails.application.config.assets.precompile += %w( stampeds.css )
Rails.application.config.assets.precompile += %w( stampeds.js )

Rails.application.config.assets.precompile += %w( budget_requests.css )
Rails.application.config.assets.precompile += %w( budget_requests.js )

Rails.application.config.assets.precompile += %w( cashes.css )
Rails.application.config.assets.precompile += %w( cashes.js )

Rails.application.config.assets.precompile += %w( open_close_cashes.js )
Rails.application.config.assets.precompile += %w( open_close_cashes.css )

Rails.application.config.assets.precompile += %w( purchase_requests.css )
Rails.application.config.assets.precompile += %w( purchase_requests.js )

Rails.application.config.assets.precompile += %w( purchase_orders.css )
Rails.application.config.assets.precompile += %w( purchase_orders.js )

Rails.application.config.assets.precompile += %w( banks.css )
Rails.application.config.assets.precompile += %w( banks.js )

Rails.application.config.assets.precompile += %w( reports.css )
Rails.application.config.assets.precompile += %w( reports.js )

Rails.application.config.assets.precompile += %w( purchase_invoices.css )
Rails.application.config.assets.precompile += %w( purchase_invoices.js )

Rails.application.config.assets.precompile += %w( filterrific/filterrific-spinner.gif )

Rails.application.config.assets.precompile += %w( pdf.css )