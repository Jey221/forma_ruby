class AddAttributesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :phone_nunber, :string
    add_column :users, :bio, :text
  end
end
