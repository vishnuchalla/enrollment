class Admin < ApplicationRecord
  has_secure_password
  validates :Name, :presence => true
  validates :Phone_Number, :presence => true, length: {is:10}
end
