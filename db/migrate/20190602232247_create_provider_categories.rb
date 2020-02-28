class CreateProviderCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :provider_categories do |t|
      t.references :provider, foreign_key: true
      t.references :product_category, foreign_key: true

      t.timestamps
    end
  end
end
