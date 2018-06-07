class CreateUserComments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_comments do |t|
      t.text :description
      t.string :system_ip
      t.boolean :is_active, default: false
      t.string :visibility

      t.timestamps
    end
  end
end
