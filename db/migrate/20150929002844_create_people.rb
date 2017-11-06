class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
    	t.string :nome
    	t.string :conselho
    	t.string :documento
    	t.string :password_digest
    	t.references :election
    	t.timestamps null: false
    end
  end
end
