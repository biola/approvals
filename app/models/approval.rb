class Approval
  include Mongoid::Document

  belongs_to :user
  belongs_to :step

  field :approved, type: Boolean, default: false
  field :denied, type: Boolean, default: false
end
