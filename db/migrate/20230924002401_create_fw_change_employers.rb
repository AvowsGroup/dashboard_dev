class CreateFwChangeEmployers < ActiveRecord::Migration[5.2]
  def change
    create_table :fw_change_employers do |t|
      t.integer :foreign_worker_id
      t.integer :customerable_id
      t.string :customerable_type
      t.integer :old_employer_id
      t.integer :new_employer_id
      t.string :fw_name
      t.string :fw_passport_number
      t.integer :fw_country_id
      t.string :fw_gender
      t.date :fw_date_of_birth
      t.integer :requested_by
      t.datetime :requested_at
      t.integer :approval_by
      t.datetime :approval_at
      t.string :decision
      t.string :status
      t.string :approval_comment
      t.string :comment
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :created_by
      t.integer :updated_by
      t.integer :assigned_to

      t.timestamps
    end
  end
end
