class StudentValidator<ActiveModel::Validator
  def validate(record)
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    record.errors.add :base, "invalid Student email format" unless record.email.match(email_regex)
  end
end

class Student < ApplicationRecord
  has_secure_password
  has_many :enrolls, dependent: :destroy
  has_many :waitlists, dependent: :destroy
  validates :Name, :presence => true
  validates :email, :presence => true
  validates :password_digest, :presence => true
  validates :date_of_birth, :presence => true
  validates :Phone_Number, :presence => true, length: {is:10}
  validates :Major, :presence => true
  validates :Student_ID, :presence => true
  validates_with StudentValidator

end
