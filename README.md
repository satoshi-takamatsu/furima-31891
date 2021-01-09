# README

# テーブル設計
# _idは全て、ActiveHashのid

## users テーブル
| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| nickname           | string      | null: false                    |
| email              | string      | null: false, unique: true      |
| encrypted_password | string      | null: false                    |
| last_name          | string      | null: false                    |
| first_name         | string      | null: false                    |
| last_name_kana     | string      | null: false                    |
| first_name_kana    | string      | null: false                    |
| birthday           | date        | null: false                    |

### Association
- has_many :items
- has_many :buyers


## items テーブル
| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| name             | string      | null: false                    |
| description      | text        | null: false                    |
| price            | integer     | null: false                    |
| category_id      | integer     | null: false                    | <!-- ActiveHash -->
| state_id         | integer     | null: false                    | <!-- ActiveHash -->
| delivery_fee_id  | integer     | null: false                    | <!-- ActiveHash -->
| shipping_area_id | integer     | null: false                    | <!-- ActiveHash -->
| days_to_ship_id  | integer     | null: false                    | <!-- ActiveHash -->
| user             | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :buyer
- has_one_attached :image <!-- ActiveStorage -->


## buyers テーブル
| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| user             | references  | null: false, foreign_key: true |
| item             | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## shipping_addresses テーブル
| Column                   | Type        | Options                        |
| ------------------------ | ----------- | ------------------------------ |
| postal_code              | string      | null: false                    |
| shipping_area_id         | integer     | null: false                    | <!-- ActiveHash -->
| municipality             | string      | null: false                    |
| street_number            | string      | null: false                    |
| building_name            | string      |                                |
| telephone_number         | string      | null: false                    |
| buyer                    | references  | null: false, foreign_key: true |


### Association
- belongs_to :buyer