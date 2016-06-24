class Folder < ActiveRecord::Base
  acts_as_tree
  has_many :archives, :dependent => :destroy
end
