class CreateInstructors < ActiveRecord::Migration[6.1]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.text :bio

      t.timestamps
    end
  end
end
