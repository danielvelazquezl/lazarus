class ReportsController < ApplicationController
  #load_and_authorize_resource
  #productos con stock minimo
  def min_stock
    @filterrific = initialize_filterrific(
        Product.products_min_stock,
        params[:filterrific],
        select_options: {
            sorted_by: Product.options_for_sorted_by
        },
        available_filters: [:sorted_by]
    ) || return
    @products = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.pdf { render template: 'reports/min_stock', pdf: 'Stock Mínimo', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end
  end

  #productos vendidos
  def sold_products
    @filterrific = initialize_filterrific(
        Product.sold_products,
        params[:filterrific],
        select_options: {
            sorted_by: Product.sold_products.options_for_sorted_by
        },
        available_filters: [:sorted_by]
        ) || return
    @products = @filterrific.find.page(params[:page])


    respond_to do |format|
      format.html
      format.js
      format.pdf { render template: 'reports/sold_products', pdf: 'Productos Vendidos', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end
  end

  #productos comprados
  def purchased_products
    (@filterrific = initialize_filterrific(
        Product.purchased_products,
        params[:filterrific],
        select_options: {
            sorted_by: Product.options_for_sorted_by
        },
        )) || return
    @products = @filterrific.find.page(params[:page])


    respond_to do |format|
      format.html
      format.js
      format.pdf { render template: 'reports/sold_products', pdf: 'Productos Comprados', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end
  end

  def cash_balance
    @filterrific = initialize_filterrific(
        OpenCloseCash.cashes_closed,
        params[:filterrific],
        select_options: {
            sorted_by: OpenCloseCash.options_for_sorted_by
        },
        available_filters: [:sorted_by]
    ) || return
    @cashes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.pdf { render template: 'reports/cash_balance', pdf: 'Balance de cajas', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end
  end

end