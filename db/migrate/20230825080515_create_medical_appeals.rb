class CreateMedicalAppeals < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_appeals do |t|
      t.integer :transaction_id
      t.string :registered_by_type
      t.integer :created_by
      t.integer :officer_in_charge_id
      t.integer :doctor_id
      t.integer :laboratory_id
      t.integer :xray_facility_id
      t.string :doctor_reason
      t.string :appeal_reason
      t.string :status
      t.string :result
      t.timestamp :officer_assigned_at
      t.integer :radiologist_id
      t.string :pcr_result
      t.string :xray_result
      t.timestamp :xray_selected_at
      t.timestamp :doctor_done_at
      t.timestamp :laboratory_done_at
      t.timestamp :xray_facility_done_at
      t.timestamp :radiologist_done_at
      t.integer :updated_by
      t.timestamp :deleted_at
      t.timestamp :completed_at
      t.boolean :is_amendment
      t.boolean :latest_appeal
      t.timestamp :employer_consented_at
      t.boolean :doctor_document_uploaded
      t.boolean :laboratory_document_uploaded
      t.boolean :is_moh
      t.boolean :employer_document_uploaded
      t.boolean :is_specialist
      t.timestamp :employer_document_uploaded_date

      t.timestamps
    end
  end
end
