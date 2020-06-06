class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields, id: :uuid do |t|
      t.uuid :content_type_id, null: false
      t.string :field_type, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
