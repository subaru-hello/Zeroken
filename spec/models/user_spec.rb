require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  describe 'メールフォーマットの検証' do
    context 'アドレスが適当な場合' do
      valid_addresses = %w[hello@example.com HOGE@foo.COM P_JP-IT@baz.bar.org baz.bar@foo.jp baz+bar@foo.com]
      it 'フォーマットバリデーションを通過する' do
        valid_addresses.each do |address|
          user.email = address
          expect(user).to be_valid
        end
      end
    end

    context 'アドレスが不適当な場合' do
      invalid_addresses = %w[hello@example,com HOGE@foo. P_JP-IT/baz.bar.org baz._bar@foo.jp baz+foo.com]
      it 'フォーマットバリデーションを通過しない' do
        invalid_addresses.each do |address|
          user.email = address
          expect(user).to be_invalid
        end
      end
    end
  end

  describe 'メールアドレスが適当な場合' do
    context 'パスワードが適当な場合' do
    valid_password = %w[password fooBAR baz1234]
    it  'フォーマットバリデーションを通過する' do
      valid_password.each do |password|
          user.password = password
          user.password_confirmation = password
          expect(user.valid?).to eq true
      end
    end
  end

  context 'パスワードが不適当な場合' do
   invalid_password =%w[パスワード 123456 barr...barr //_foo #####]
   it 'フォーマットバリデーションを通過しない' do
     invalid_passwords.each do |password|
      user.password = password
      user.password_confirmation = password
      expect(user.invalid?).to eq true
     end
    end
  end
end
  describe 'メールアドレスを小文字に変換して保存する' do

    test_email = "FOO@EXAMPLE.COM"
    it "小文字に変換されている" do
      user.email = test_email
      user.save
      expect(User.last.email).to eq test_email.downcase
    end
  end
end