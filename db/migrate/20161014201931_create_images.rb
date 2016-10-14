class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :repository, index: true, foreign_key: true
      t.text   :dockerfile
      t.string :docker_image_id

      t.timestamps null: false
    end
  end
end
