class CreateBuildingBackups < ActiveRecord::Migration[5.2]
  def change
    create_table :building_backups do |t|
    	t.belongs_to :building, index: true
    	t.string :manager_name
      t.timestamps
    end
  end
end
