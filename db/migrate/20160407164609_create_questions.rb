# This file does not automatically create a table. It just defines how the table must be created. To execute it you will need to run bin/rake db:migrate.

class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
# You do not need to explicity define the id field as it will be added automatically. Rails will add an 'id' field that is an integer and primary key with 'autoincrement'.
      t.string :title
      t.text :body
# The above syntax is a known as DSL, a domain-specific language.
      t.timestamps null: false
# Timestamps will add two additional fields- created_at and updated_at. They will be of type: datetime and will be automatically set by ActiveRecord.
    end
  end
end
