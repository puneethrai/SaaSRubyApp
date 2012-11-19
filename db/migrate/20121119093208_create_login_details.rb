class CreateLoginDetails < ActiveRecord::Migration
  def change
    create_table :login_details do |t|
      t.string :username
      t.text :password

      t.timestamps
    end
  end
end
