class CreateMedicalExaminationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_examination_details do |t|
      t.bigint :transaction_id
      t.integer :condition_id
      t.bigint :medical_examination_id
      t.date :date_value
      t.string :text_value
      t.bigint :created_by
      t.bigint :updated_by
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
      t.boolean :history

      t.timestamps
    end
    add_index :medical_examination_details, :deleted_at
    add_index :medical_examination_details, :created_at
    add_index :medical_examination_details, :updated_at
  end
end
