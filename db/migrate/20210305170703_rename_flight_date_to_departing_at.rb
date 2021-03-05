class RenameFlightDateToDepartingAt < ActiveRecord::Migration[5.2]
  def change
    rename_column :flights, :date, :departing_at
  end
end
