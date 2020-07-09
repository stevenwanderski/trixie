class CreateProxies < ActiveRecord::Migration[6.0]
  def change
    create_table :proxies, id: :uuid do |t|
      t.string :name
      t.text :proxy_url
      t.string :proxy_request_type
      t.text :target_url
      t.string :target_request_type
      t.uuid :user_id

      t.timestamps
    end
  end
end
