class CreatePcrReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :pcr_reviews do |t|
      t.bigint :transaction_id
      t.string :case_type
      t.text :comment
      t.string :status
      t.string :result
      t.datetime :transmitted_at
      t.bigint :created_by_id
      t.bigint :updated_by_id
      t.bigint :pcr_id
      t.string :poolable_type
      t.bigint :poolable_id
      t.boolean :is_legacy
      t.string :trans_id
      t.bigint :legacy_id
      t.bigint :medical_appeal_id
      t.string :belong
      t.text :belong_comment

      t.timestamps
    end
  end
end
