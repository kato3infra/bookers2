class ModifyBookColumns < ActiveRecord::Migration[6.1]
  def change
    # 既存のカラムを削除
    remove_column :books, :title, :string
    remove_column :books, :description, :text

    # 新しいカラムを追加
    add_column :books, :book_name, :string
    add_column :books, :caption, :text
    add_reference :books, :user, foreign_key: true
  end
end
