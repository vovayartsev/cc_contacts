class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :private_email
      t.string :corporate_email
      t.string :phone
      t.string :nickname
      t.string :skype
      t.string :birthday_string

      t.timestamps
    end
  end
end
