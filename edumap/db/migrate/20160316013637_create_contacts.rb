class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message
      t.text :url

      t.timestamps null: false
    end
  end
end
