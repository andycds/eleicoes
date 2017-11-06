class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.references :person
    	t.references :candidate
    	t.references :election
		t.timestamps null: false
    end
  end
end
