class CreateCorsHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :cors_hosts, id: :uuid do |t|
      t.uuid :proxy_id
      t.string :host

      t.timestamps
    end
  end
end
