class AddPhoneData < ActiveRecord::Migration[5.0]
  def change
    add_column :phones ,:contact_id , :string
  end
end
