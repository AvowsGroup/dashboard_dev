class MedicalExamination < ApplicationRecord
	belongs_to :Transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
end
