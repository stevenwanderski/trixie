class AddSlugToProxy < ActiveRecord::Migration[6.0]
  def change
    add_column :proxies, :slug, :string
  end
end
