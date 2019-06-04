class ReportsController < ApplicationController

  #productos con stock minimo
  def min_stock
    @products = Product.products_min_stock

    respond_to do |format|
      format.html
      format.pdf { render template: 'reports/min_stock', pdf: 'Stock Mínimo', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end
  end

  #productos vendidos
  def sold_products
    (@filterrific = initialize_filterrific(
        Product.sold_products,
        params[:filterrific],
        select_options: {
            sorted_by: Product.options_for_sorted_by
        },
        )) || return
    @products = @filterrific.find.page(params[:page])


    respond_to do |format|
      format.html
      format.pdf { render template: 'reports/sold_products', pdf: 'Productos Vendidos', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end
  end

  #productos comprados
  def purchased_products

  end

end