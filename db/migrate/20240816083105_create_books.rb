class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :image
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
