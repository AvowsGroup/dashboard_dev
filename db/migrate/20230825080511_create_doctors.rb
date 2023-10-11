class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :code
      t.string :name
      t.string :company_name
      t.integer :title_id
      t.string :clinic_name
      t.string :icno
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :address4
      t.integer :country_id
      t.integer :state_id
      t.integer :town_id
      t.string :postcode
      t.string :phone
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :email_payment
      t.string :qualification
      t.integer :apc_year
      t.string :apc_number
      t.timestamp :renewal_agreement_date
      t.integer :district_health_office_id
      t.boolean :has_xray
      t.integer :fp_device
      t.integer :quota
      t.integer :quota_used
      t.integer :quota_modifier
      t.boolean :solo_clinic
      t.boolean :group_clinic
      t.integer :xray_facility_id
      t.integer :laboratory_id
      t.text :comment
      t.string :pairing_options
      t.integer :service_provider_group_id
      t.integer :male_rate
      t.integer :female_rate
      t.integer :bank_id
      t.string :bank_account_number
      t.integer :bank_payment_id
      t.string :status
      t.string :status_reason
      t.timestamp :registration_approved_at
      t.timestamp :activated_at
      t.string :approval_status
      t.text :approval_remark
      t.string :created_by
      t.string :updated_by
      t.integer :payment_method_id
      t.string :business_registration_number
      t.text :status_comment
      t.boolean :has_doctor_association
      t.string :name_of_association
      t.boolean :has_selected_re_medical
      t.string :gender
      t.integer :nationality_id
      t.integer :race_id
      t.text :associations
      t.boolean :paid_biometric_device

      t.timestamps
    end
  end
end
