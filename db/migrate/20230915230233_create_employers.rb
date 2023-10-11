class CreateEmployers < ActiveRecord::Migration[5.2]
  def change
    create_table :employers do |t|
      t.string :code
      t.bigint :employer_type_id
      t.string :name
      t.string :business_registration_number
      t.string :ic_passport_number
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :address4
      t.bigint :country_id
      t.bigint :state_id
      t.bigint :town_id
      t.string :postcode
      t.string :phone
      t.string :fax
      t.string :email
      t.string :pic_name
      t.string :pic_phone
      t.boolean :personal_data_consent
      t.string :status
      t.boolean :bad_payment
      t.boolean :blacklisted
      t.datetime :blacklisted_at
      t.text :comment
      t.text :registration_comment
      t.datetime :registration_approved_at
      t.bigint :registration_approval_by
      t.datetime :activated_at
      t.string :approval_status
      t.string :approval_remark
      t.bigint :created_by
      t.bigint :updated_by
      t.bigint :bank_id
      t.string :bank_account_number
      t.bigint :organization_id

      t.timestamps
    end
  end
end
