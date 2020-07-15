class CreateProxyHeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :proxy_headers, id: :uuid do |t|
      t.uuid :proxy_id, null: false
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
