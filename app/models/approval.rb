class Approval
  include Mongoid::Document
  field :approved, type: Mongoid::Boolean
  field :denied, type: Mongoid::Boolean
end
