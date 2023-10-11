class Country < ApplicationRecord
  has_many :transactions, foreign_key: 'fw_country_id'
end
