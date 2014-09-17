class Step
  include Mongoid::Document
  field :title, type: String
  field :completed, type: Mongoid::Boolean
end
