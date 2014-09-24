class User
  include Mongoid::Document

  has_many :approvals
  has_many :comments

  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :biola_id, type: Integer
  field :title, type: String
  field :email, type: String
  field :photo_url, type: String
  field :department, type: String
  field :affiliations, type: Array
  field :entitlements, type: Array
  alias_attribute :netid, :username

  # for logging in
  field :current_login_at, type: DateTime
  field :last_login_at, type: DateTime
  field :login_count, type: Integer

  validates :username, presence: true, uniqueness: true

  def name
    [first_name, last_name].compact.join(" ")
  end

  def to_s
    name
  end

  def update_login_info!
    self.last_login_at = current_login_at
    self.current_login_at = Time.now
    self.login_count = login_count.to_i + 1
    self.save
  end

  def has_role?(*roles)
    (self.roles & roles).any?
  end

  def roles
    (Array(affiliations) + relevant_entitlements).map(&:to_sym)
  end

  def admin?
    has_role?(:admin) || developer?
  end

  def developer?
    has_role?(:developer)
  end


  private

  # Find URNs that match the namespaces and remove the namespace
  # See http://en.wikipedia.org/wiki/Uniform_Resource_Name
  def relevant_entitlements
    urns = Array(entitlements)
    nids = Settings.urn_namespaces

    return [] if urns.blank?

    clean_urns = urns.map { |e| e.gsub(/^urn:/i, '') }
    clean_nids = nids.map { |n| n.gsub(/^urn:/i, '') }

    clean_urns.map { |urn|
      clean_nids.map { |nid|
        urn[0...nid.length] == nid ? urn[nid.length..urn.length] : nil
      }
    }.flatten.compact
  end

  def self.role_to_entitlement(role)
    Settings.urn_namespaces.map do |namespace|
      "#{namespace}#{role}"
    end
  end
end
