class CreateXqccPools < ActiveRecord::Migration[5.2]
  def change
    create_table :xqcc_pools do |t|
      t.integer :transaction_id
      t.string :case_type
      t.string :status
      t.string :source
      t.datetime :created_at
      t.datetime :updated_at
      t.time :picked_up_at
      t.integer :created_by
      t.integer :updated_by
      t.integer :picked_up_by
      t.string :sourceable_type
      t.integer :sourceable_id
      t.boolean :is_legacy
      t.integer :trans_id
      t.integer :legacy_id
      t.integer :reserved_by

      t.timestamps
    end
  end
end
