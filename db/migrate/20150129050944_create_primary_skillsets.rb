class CreatePrimarySkillsets < ActiveRecord::Migration
  def change
    create_table :primary_skillsets do |t|
      t.integer  :service_id
      t.integer  :serviceprovider_id

      t.timestamps
    end
    add_index :primary_skillsets, :service_id
    add_index :primary_skillsets, :serviceprovider_id
  end
end
