class CreateForeignWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :foreign_workers do |t|
      t.string :code
      t.string :name
      t.string :passport_number
      t.string :gender
      t.datetime :gender_amended_at
      t.date :date_of_birth
      t.bigint :employer_id
      t.bigint :employer_supplement_id
      t.bigint :country_id
      t.bigint :job_type_id
      t.date :arrival_date
      t.string :plks_number
      t.boolean :pati
      t.text :amendment_reason_comment
      t.datetime :employer_amended_at
      t.datetime :amended_at
      t.bigint :amended_by
      t.boolean :blocked
      t.bigint :block_reason_id
      t.text :block_comment
      t.bigint :unblock_reason_id
      t.text :unblock_comment
      t.datetime :blocked_at
      t.bigint :blocked_by
      t.string :afis_id
      t.string :approval_status
      t.string :approval_remark
      t.bigint :created_by
      t.bigint :updated_by
      t.json :amendment_reasons
      t.string :maid_online
      t.string :monitoring
      t.bigint :monitor_reason_id
      t.text :monitor_comment
      t.text :unmonitor_comment
      t.bigint :organization_id
      t.bigint :latest_transaction_id
      t.integer :reg_ind
      t.integer :med_ind_count
      t.string :status

      t.timestamps
    end
  end
end
