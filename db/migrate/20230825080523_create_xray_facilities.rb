class CreateXrayFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :xray_facilities do |t|
      t.string :code
      t.string :name
      t.string :company_name
      t.integer :title_id
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
      t.string :email
      t.string :email_payment
      t.string :icno
      t.string :mobile
      t.string :qualification
      t.integer :district_health_office_id
      t.string :xray_license_number
      t.string :xray_file_number
      t.boolean :xray_fac_flag
      t.string :xray_license_tujuan
      t.date :xray_license_expiry_date
      t.boolean :radiologist_operated
      t.string :radiologist_name
      t.integer :apc_year
      t.string :apc_number
      t.string :film_type
      t.date :renewal_agreement_date
      t.boolean :fp_device
      t.text :comment
      t.integer :service_provider_group_id
      t.decimal :male_rate, precision: 10, scale: 2
      t.decimal :female_rate, precision: 10, scale: 2
      t.integer :bank_id
      t.string :bank_account_number
      t.string :bank_payment_id
      t.string :status
      t.text :status_reason
      t.datetime :registration_approved_at
      t.datetime :activated_at
      t.integer :approval_status
      t.text :approval_remark
      t.integer :created_by
      t.integer :updated_by
      t.integer :payment_method_id
      t.string :license_holder_name
      t.string :business_registration_number
      t.text :status_comment
      t.boolean :moh_license_status
      t.boolean :has_doctor_association
      t.string :name_of_association
      t.string :gender
      t.boolean :has_selected_re_medical
      t.integer :nationality_id
      t.integer :race_id
      t.text :associations
      t.integer :xray_license_purposes_id
      t.integer :digital_xray_provider_id
      t.boolean :paid_biometric_device

      t.timestamps
    end
  end
end
