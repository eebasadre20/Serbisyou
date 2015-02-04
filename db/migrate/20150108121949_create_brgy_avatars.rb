class CreateBrgyAvatars < ActiveRecord::Migration
  def change
    create_table :brgy_avatars do |t|
      t.string 	 :name
      t.string   :avatar

      t.timestamps
    end
  end
end
