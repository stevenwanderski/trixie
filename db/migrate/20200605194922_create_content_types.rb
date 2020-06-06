class CreateContentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :content_types, id: :uuid do |t|
      t.string :name, null: false
      t.uuid :user_id

      t.timestamps
    end
  end
end
