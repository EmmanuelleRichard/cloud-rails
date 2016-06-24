class Archive < ActiveRecord::Base
  belongs_to :user
  belongs_to :folder
  has_attached_file :uploaded_file,
                    :url => "/archives/get/:id",
                    :path => ":Rails_root/archives/:id/:basename.:extension"


  validates_attachment_size :uploaded_file, :less_than => 200.megabytes
  validates_attachment_presence :uploaded_file
  validates_attachment_content_type :uploaded_file, :content_type => [/\Aapplication\/.*\Z/, /\Aimage\/.*\Z/]

end
