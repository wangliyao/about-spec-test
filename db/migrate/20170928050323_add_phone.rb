class AddPhone < ActiveRecord::Migration[5.0]
  def change
    add_column :phones ,:phone,:string
    add_column :phones ,:phone_type,:string
  end
end
