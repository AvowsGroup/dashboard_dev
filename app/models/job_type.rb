class JobType < ApplicationRecord
  has_many :transactions, foreign_key: 'fw_job_type_id'
end
