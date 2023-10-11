class XrayPendingDecision < ApplicationRecord
  belongs_to :fw_transactions,class_name: 'Transaction',foreign_key: "transaction_id"
end
