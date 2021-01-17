class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,              null: false
      t.text :description,         null: false
      t.integer :price,            null: false
      t.references :user,          foreign_key: true

      # 以下はActiveHash
      t.integer :category_id,      null: false
      t.integer :state_id,         null: false
      t.integer :delivery_fee_id,  null: false
      t.integer :shipping_area_id, null: false
      t.integer :day_to_ship_id,   null: false
      t.timestamps
    end
  end
end
