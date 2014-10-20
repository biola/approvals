class Approval
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embedded_in :proposal

  field :approved, type: Boolean, default: nil
  field :name, type: String
  field :email, type: String
  field :photo_url, type: String

  def denied
    approved == false
  end
end
