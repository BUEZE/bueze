# CreateBookrankings
class CreateBookrankings < ActiveRecord::Migration
  def change
    # Can look tutorial at here https://ihower.tw/rails4/migrations.html

    # CMD:
    # rake db:create_migration NAME=create_bookranking
    # rake db:migrate

    # Data types
    # Rails中的型態	說明				MySQL			Postgres				SQLite3
    # :string		有限長度字串		varchar(255)	character varying(255)	varchar(255)
    # :text			不限長度文字		text			text					text
    # :integer		整數				int(4)			integer					integer
    # :float		浮點數			float			float					float
    # :decimal		十進位數			decimal			decimal					decimal
    # :datetime		日期時間			datetime		timestamp				datetime
    # :timestamp	時間戳章			datetime		timestamp				datetime
    # :time			時間				time			time					datetime
    # :date			日期				date			date					date
    # :binary		二進位			blob			bytea					blob
    # :boolean		布林值			tinyint			boolean					boolean
    create_table :bookrankings do |t|
      t.text :booknames
      t.integer :rank
      t.text :price_description
      t.integer :price
      t.text :author
      t.date :date
      t.text :source
      t.text :prod_id
      t.timestamps null: false
    end
  end

  def drop
    drop_table :bookrankings
  end

  # maybe add change_table() change_column() remove_column() in future
end
