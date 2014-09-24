class Approval
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embeds_many :comments

  field :title, type: String
  field :description, type: String

  # field :approved, type: Boolean, default: false
  # field :denied, type: Boolean, default: false

  field :approver_emails, type: Array, default: []
  field :approved_emails, type: Array, default: []
  field :denied_emails, type: Array, default: []

  mount_uploader :attachment, AttachmentUploader

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
    approved_emails.length
  end

  def denial_count
    denied_emails.length
  end

  def outstanding_approvals
    approver_emails - approved_emails - denied_emails
  end

  def outstanding_count
    outstanding_approvals.count
  end

  def approve(email)
    self.approved_emails << email
    self.denied_emails.delete email
  end

  def deny(email)
    self.denied_emails << email
    self.approved_emails.delete email
  end

end
