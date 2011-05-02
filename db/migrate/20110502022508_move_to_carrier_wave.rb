class MoveToCarrierWave < ActiveRecord::Migration
  def self.up
    add_column :movies, :poster, :string
    remove_column :movies, :cover_image_uid
  end

  def self.down
    remove_column :movies, :poster
    add_column :movies, :cover_image_uid, :string
  end
end
