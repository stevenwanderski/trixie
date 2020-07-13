class CreateProxyParams < ActiveRecord::Migration[6.0]
  def change
    create_table :proxy_params, id: :uuid do |t|
      t.uuid :proxy_id, null: false
      t.string :param_from
      t.string :param_to

      t.timestamps
    end
  end
end
