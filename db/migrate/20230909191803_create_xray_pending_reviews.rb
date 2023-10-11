class CreateXrayPendingReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :xray_pending_reviews do |t|
      t.references :transaction, foreign_key: true
      t.string :quarantine_type
      t.text :quarantine_reason
      t.string :source
      t.text :comment
      t.string :status
      t.string :decision
      t.datetime :transmitted_at
      t.bigint :created_by
      t.bigint :updated_by
      t.bigint :reviewed_by
      t.string :is_audit_comparison
      t.boolean :is_legacy
      t.string :trans_id
      t.bigint :legacy_id

      t.timestamps
    end
  end
end
