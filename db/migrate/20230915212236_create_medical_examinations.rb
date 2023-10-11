class CreateMedicalExaminations < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_examinations do |t|
      t.bigint :transaction_id
      t.decimal :physical_height
      t.decimal :physical_weight
      t.integer :physical_pulse
      t.integer :physical_blood_pressure_systolic
      t.integer :physical_blood_pressure_diastolic
      t.date :physical_last_menstrual_period_date
      t.string :result
      t.string :suitability
      t.datetime :transmitted_at
      t.bigint :created_by
      t.bigint :updated_by
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :medical_examinations, :deleted_at
    add_index :medical_examinations, :created_at
    add_index :medical_examinations, :updated_at
  end
end
