class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :code
      t.decimal :price
      t.date :enrollment_deadline

      t.timestamps
    end
  end
end
