# db/migrate/timestamp_create_pcr_pools.rb

class CreatePcrPools < ActiveRecord::Migration[4.2]
  def change
    create_table :pcr_pools do |t|
      t.bigint :transaction_id
      t.string :case_type
      t.string :status
      t.string :source
      t.string :sourceable_type
      t.bigint :sourceable_id
      t.datetime :picked_up_at
      t.bigint :created_by_id
      t.bigint :updated_by_id
      t.bigint :picked_up_by_id
      t.boolean :is_legacy, default: false, null: false
      t.string :trans_id
      t.bigint :legacy_id
      t.bigint :medical_appeal_id
      t.bigint :xray_retake_id

      t.timestamps
    end
  end
end
