class Contact < ApplicationRecord
  has_many :phones

  validates_presence_of :lastname
  def name
    [firstname,lastname].join(' ')
  end

  def self.by_letter(letter)
    where("lastname LIKE ?","#{letter}%").order(:lastname)
  end
end
