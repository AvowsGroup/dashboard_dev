class LaboratoryExamination < ApplicationRecord
	belongs_to :transactions, class_name: 'Transaction', foreign_key: 'transaction_id'

end
