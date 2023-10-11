class CreateXrayPendingDecisions < ActiveRecord::Migration[5.2]
  def change
    create_table :xray_pending_decisions do |t|
      t.bigint :transaction_id
      t.text :comment
      t.string :status
      t.string :decision
      t.string :sourceable_type
      t.bigint :sourceable_id
      t.datetime :transmitted_at
      t.datetime :created_at
      t.datetime :updated_at
      t.bigint :created_by
      t.bigint :updated_by
      t.bigint :reviewed_by
      t.string :condition_hiv
      t.string :condition_tuberculosis
      t.string :condition_malaria
      t.string :condition_leprosy
      t.string :condition_std
      t.string :condition_hepatitis
      t.string :condition_cancer
      t.string :condition_epilepsy
      t.string :condition_psychiatric_disorder
      t.string :condition_other
      t.string :condition_hypertension
      t.string :condition_heart_diseases
      t.string :condition_bronchial_asthma
      t.string :condition_diabetes_mellitus
      t.string :condition_peptic_ulcer
      t.string :condition_kidney_diseases
      t.string :condition_urine_for_pregnant
      t.string :condition_urine_for_opiates
      t.string :condition_urine_for_cannabis
      t.text :certification_comment
      t.boolean :is_legacy
      t.string :trans_id
      t.bigint :legacy_id
      t.bigint :pcr_id
      t.bigint :approval_by
      t.string :approval_decision
      t.text :approval_comment
      t.datetime :reviewed_at

      t.timestamps
    end
  end
end
