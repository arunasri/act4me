class DropUnusedColumns < ActiveRecord::Migration
  def self.up
    remove_column :tweets, :open_amplify
    remove_column :tweets, :max_polarity
    remove_column :tweets, :min_polarity
    remove_column :tweets, :mean_polarity
    remove_column :tweets, :featured
    remove_column :tweets, :iso_language_code
  end

  def self.down
    add_column :tweets, :open_amplify, :text
    add_column :tweets, :max_polarity,  :integer, :default => nil
    add_column :tweets, :min_polarity,   :integer, :default => nil
    add_column :tweets, :mean_polarity,  :integer, :default => nil
    add_column :tweets, :iso_language_code, :string
    add_column :tweets, :featured, :boolean, :default => false
  end
end
