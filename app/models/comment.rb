class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :approval

  field :name, type: String
  field :email, type: String
  field :text, type: String
  field :photo_url, type: String
  field :approved, type: Boolean, default: false
  field :denied, type: Boolean, default: false

end
