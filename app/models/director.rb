class Director < ApplicationRecord
  def full_name
    first_name == "N/A" ? "N/A" : "#{first_name} #{last_name}"
  end
end
