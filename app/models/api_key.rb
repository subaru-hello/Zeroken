class ApiKey < ApplicationRecord
  DEFAULT_EXPIRES_WEEK = 1.week
  belongs_to :user

  validates :access_token, uniqueness: true

  scope :active, -> { where('expires_at >= ?', Time.current) }

  def initialize(attributes = {})
    super
    self.access_token = SecureRandom.uuid
    self.expires_at = DEFAULT_EXPIRES_WEEK.after
  end
end
