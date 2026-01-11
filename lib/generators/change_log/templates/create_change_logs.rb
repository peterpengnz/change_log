class CreateChangeLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :change_logs do |t|
      t.integer :version, null: false      # store version of each change
      t.string :record_id, limit: 64       # store the actual record id
      t.string :table_name, limit: 64      # store the table name
      t.string :attribute_name, limit: 64  # store the column name
      t.string :user, limit: 64            # store the user who made the change
      t.string :action, limit: 6           # store the change action: create, read, update, delete
      t.text :old_value                    # the value before change
      t.text :new_value                    # value after change
      t.string :field_type, limit: 30      # the column type eg. date, text, varchar, int etc

      t.timestamps
    end
  end
end