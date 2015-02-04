class AddPrimarySkillsetRefToCategorizations < ActiveRecord::Migration
  def change
    add_reference :categorizations, :primary_skillset, index: true
  end
end
