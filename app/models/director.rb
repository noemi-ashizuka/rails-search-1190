class Director < ApplicationRecord
  has_many :movies

  def full_name
    first_name == "N/A" ? "N/A" : "#{first_name} #{last_name}"
  end
end
