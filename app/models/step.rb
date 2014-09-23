class Step
  include Mongoid::Document

  belongs_to :project
  belongs_to :step
  has_many :steps
  has_many :approvals
  has_many :comments

  field :title, type: String
  field :position, type: Integer
  field :completed, type: Boolean, default: false

end
