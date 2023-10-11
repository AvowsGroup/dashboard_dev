class PcrPool < ApplicationRecord
  belongs_to :fw_transaction,class_name: "Transaction",foreign_key: "transaction_id"
  belongs_to :pcr_review
end
