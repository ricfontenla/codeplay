class AddColumnToLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :duration, :integer
  end
end
