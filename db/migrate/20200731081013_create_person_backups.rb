class CreatePersonBackups < ActiveRecord::Migration[5.2]
  def change
    create_table :person_backups do |t|
    	t.belongs_to :person, index: true
    	t.string :email
    	t.string :home_phone_number
    	t.string :mobile_phone_number
    	t.string :address
      t.timestamps
    end
  end
end
