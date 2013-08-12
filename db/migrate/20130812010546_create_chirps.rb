class CreateChirps < ActiveRecord::Migration
  def change
    create_table :chirps do |t|
      t.string :body, limit: 150
      t.references :user, index: true

      t.timestamps
    end
  end
end
