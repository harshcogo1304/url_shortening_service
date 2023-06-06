class CreateUrlsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :urls_tables do |t|
      t.string :long_url
      t.string :short_url

      t.timestamps
    end
  end
end
