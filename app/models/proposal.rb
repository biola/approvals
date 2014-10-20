class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embeds_many :comments
  embeds_many :approvals

  field :title, type: String
  field :description, type: String
  field :approver_emails, type: Array, default: []

  # field :approved, type: Boolean, default: false
  # field :denied, type: Boolean, default: false

  mount_uploader :attachment, AttachmentUploader

  validates_presence_of :title, :approver_emails

  def to_s
    title
  end

  def set_approver_emails
    approver_emails.join(", ")
  end

  def set_approver_emails=(string)
    self.approver_emails = string.split(",").map(&:strip)
  end

  def approval_count
    approvals.where(approved: true).count
  end

  def denial_count
    approvals.where(approved: false).count
  end

  def outstanding_count
    approvals.where(approved: nil).count
  end

  def approved_emails
    approvals.where(approved: true).pluck(:email)
  end

  def denied_emails
    approvals.where(approved: false).pluck(:email)
  end

  def outstanding_approvals
    approvals.where(approved: nil).pluck(:email)
  end
end
