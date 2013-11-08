class ChangeUsersToUser < ActiveRecord::Migration
    def change
    drop_table :users

    create_table :users do |t|
      t.string :email
      t.string :full_name
      t.string :display_name
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
