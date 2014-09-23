class Project
  include Mongoid::Document

  has_many :steps
  has_many :comments

  field :title, type: String

end
