class CreateThings < ActiveRecord::Migration[7.0]
  def change

    create_enum :thing_which, %w[one two three]
    create_table :things do |t|
      t.string :name
      t.enum :which, enum_type: :thing_which, default: 'one'

      t.timestamps
    end
  end
end
