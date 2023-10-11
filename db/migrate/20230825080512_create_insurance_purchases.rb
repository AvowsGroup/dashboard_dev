class CreateInsurancePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :insurance_purchases do |t|
      t.integer :order_id
      t.integer :order_item_id
      t.date :start_date
      t.date :end_date
      t.string :product_purchased
      t.integer :batch_id
      t.integer :reg_id
      t.integer :employer_id
      t.string :fw_name
      t.integer :insurance_provider
      t.string :status
      t.string :emp_code
      t.string :emp_name
      t.integer :foreign_worker_id
      t.string :fw_code
      t.string :fw_gender
      t.date :fw_date_of_birth
      t.string :fw_passport_number
      t.integer :fw_country_id
      t.integer :fw_job_type_id
      t.boolean :is_collection
      t.integer :gross_premium
      t.integer :stamp_duty
      t.integer :sst
      t.integer :adminfees
      t.integer :adminfees_sst
      t.integer :total_premium
      t.integer :insurance_service_provider_id

      t.timestamps
    end
  end
end
