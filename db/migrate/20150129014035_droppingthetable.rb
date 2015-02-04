class Droppingthetable < ActiveRecord::Migration
  def change
  	drop_table :average_caches
  	drop_table :clearances
  	drop_table :galleries
  	drop_table :overall_averages
  	drop_table :rates
  	drop_table :rating_caches
  	drop_table :ratings
  	drop_table :rs_evaluations
  	drop_table :rs_reputation_messages
  end
end
