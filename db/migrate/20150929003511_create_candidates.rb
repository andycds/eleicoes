class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
    	t.string :nome
    	t.references :election
		t.timestamps null: false
    end
  end
end
