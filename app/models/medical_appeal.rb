class MedicalAppeal < ApplicationRecord
	belongs_to :transactionable,class_name: 'Transition', foreign_key: 'transaction_id'
end
