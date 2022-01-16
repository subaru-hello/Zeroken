class User < ApplicationRecord
  before_save :change_email_to_lowercase
  authenticates_with_sorcery!
  has_many :api_keys, dependent: :destroy
  has_many :analyze_results, dependent: :destroy
  has_many :likes, through: :favorites, source: :alcohol
  has_one_attached :avatar
  enum role: { guest: 0, member: 1 }

  mount_uploader :avatar, AvatarUploader
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PASSWORD_FORMAT = /\A\w+\z/i.freeze

  validates :password, length: { minimum: 6 }, if: :new_or_changes_password
  validates :password,
            confirmation: true,
            format: {
              with: VALID_PASSWORD_FORMAT
            },
            if: :new_or_changes_password
  validates :password_confirmation, presence: true, if: :new_or_changes_password

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 10 }

  validates :email,
            presence: true,
            uniqueness: true,
            length: {
              maximum: 50
            },
            format: {
              with: VALID_EMAIL_REGEX
            }

  # def avatar_url
  #   if avatar.attached?
  #     Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true)
  #   end
  # end

  def activate_api_key!
    return api_keys.active.first if api_keys.active.exists?

    api_keys.create
  end

  private

  def change_email_to_lowercase
    self.email = email.downcase
  end

  def new_or_changes_password
    new_record? || changes[:crypted_password]
  end
end
