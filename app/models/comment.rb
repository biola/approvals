class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embedded_in :proposal

  field :name, type: String
  field :email, type: String
  field :text, type: String
  field :photo_url, type: String

  validates_presence_of :text

end
