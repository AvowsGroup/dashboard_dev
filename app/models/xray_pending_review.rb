class XrayPendingReview < ApplicationRecord
  has_many :fw_transactions,class_name: 'Transaction'
  belongs_to :fw_transaction,class_name:"Transaction",foreign_key: "transaction_id"
end
