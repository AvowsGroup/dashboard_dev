class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :code
      t.integer :customerable_id
      t.string :customerable_type
      t.integer :payment_method_id
      t.string :category
      t.time :date
      t.decimal :amount
      t.string :status
      t.text :comment
      t.text :additional_information
      t.time :created_at
      t.time :updated_at
      t.integer :created_by
      t.integer :updated_by
      t.integer :organization_id
      t.time :paid_at
      t.integer :master_reference_id
      t.integer :reference_id
      t.boolean :personal_data_consent
      t.integer :insurance_service_provider_id

      t.timestamps
    end
  end
end
