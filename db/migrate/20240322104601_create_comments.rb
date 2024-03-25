class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body, default: ''
      t.references :commentable, polymorphic: true
      t.references :user

      t.timestamps
    end
  end
end
