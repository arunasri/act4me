class MoveToCarrierWave < ActiveRecord::Migration
  def self.up
    add_column :movies, :horizontal, :string
    add_column :movies, :vertical, :string
    #remove_column :movies, :cover_image_uid
  end

  def self.down
    remove_column :movies, :horizontal
    remove_column :movies, :vertical
    #add_column :movies, :cover_image_uid, :string
  end
end
