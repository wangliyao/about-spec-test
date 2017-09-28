class Contact < ApplicationRecord
  def name
    [firstname,lastname].join(' ')
  end

  def self.by_letter(letter)
    where("lastname LIKE ?","#{letter}%").order(:lastname)
  end
end
