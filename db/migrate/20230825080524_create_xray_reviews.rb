class CreateXrayReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :xray_reviews do |t|
      t.integer :transaction_id
      t.integer :batch_id
      t.string :case_type
      t.string :status
      t.string :result
      t.time :transmitted_at
      t.time :created_at
      t.time :updated_at
      t.integer :created_by
      t.integer :updated_by
      t.integer :radiographer_id
      t.string :poolable_type
      t.integer :poolable_id
      t.boolean :is_legacy
      t.string :trans_id
      t.integer :legacy_id
      t.column :is_iqa, :character, limit: 1

      t.timestamps
    end
  end
end
