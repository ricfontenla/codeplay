class AddPriceToEnrollment < ActiveRecord::Migration[6.1]
  def change
    add_column :enrollments, :price, :decimal
  end
end
