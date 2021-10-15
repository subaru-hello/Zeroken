class User < ApplicationRecord
  before_save :change_email_to_lowercase
  authenticates_with_sorcery!

  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 10 }

  validates :email,
            presence: true,
            uniqueness: true,
            length: {
              maximum: 50
            },
            format: {
              with: VALID_EMAIL_FORMAT
            }

  private

  def change_email_to_lowercase
    self.email = email.downcase
  end
end
