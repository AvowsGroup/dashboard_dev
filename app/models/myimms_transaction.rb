class MyimmsTransaction < ApplicationRecord
	belongs_to :fw_transaction ,class_name: "Transaction",foreign_key: "transaction_id"
end




