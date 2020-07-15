class AddBodyFormatToProxies < ActiveRecord::Migration[6.0]
  def change
    add_column :proxies, :body_format, :string
  end
end
