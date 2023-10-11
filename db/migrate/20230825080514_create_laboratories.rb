class CreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      t.string :code
      t.string :name
      t.string :company_name
      t.string :business_registration_number
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
      t.string :pic_name
      t.string :pic_phone
      t.string :qualification
      t.string :pathologist_name
      t.string :nsr_number
      t.integer :laboratory_type_id
      t.date :renewal_agreement_date
      t.integer :district_health_office_id
      t.string :samm_number
      t.string :license
      t.integer :license_year
      t.string :web_service
      t.string :web_service_passphrase
      t.text :comment
      t.integer :service_provider_group_id
      t.integer :male_rate
      t.integer :female_rate
      t.integer :bank_id
      t.string :bank_account_number
      t.string :bank_payment_id
      t.string :status
      t.string :status_reason
      t.timestamp :registration_approved_at
      t.timestamp :activated_at
      t.string :approval_status
      t.text :approval_remark
      t.string :created_by
      t.string :updated_by
      t.integer :payment_method_id
      t.date :samm_accredited_since
      t.date :samm_expiry_date
      t.text :status_comment

      t.timestamps
    end
  end
end
