require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it "歯科医院名、メールアドレス、パスワードがあれば有効であること" do
      expect(user).to be_valid
    end

    it "歯科医院名がなければ登録できない" do
      user.name = nil
      expect(user.valid?).to eq(false)
    end

    it "メールアドレスがなければ登録できない" do
      user.email = nil
      expect(user.valid?).to eq(false)
    end

    it "パスワードがなければ登録できない" do
      user.password = nil
      expect(user.valid?).to eq(false)
    end

    it "パスワードとパスワード確認の値が一致しなければ登録できない" do
      user.password = "password"
      user.password_confirmation = "foobar"
      expect(user.valid?).to eq(false)
    end

    it "パスワードが5文字以下の場合、登録できない" do
      user.password = "test1"
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "パスワードは6文字以上であれば登録できる" do
      user.password = "password"
      expect(user.valid?).to eq(true)
    end

    it "メールアドレスは重複した場合、登録できない" do
      User.create(
        name: "test",
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
      )

      other_user = User.new(
        name: "test2",
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(other_user.valid?).to eq(false)
    end

    it "メールアドレスは正規表現でなければ登録できない" do
      user.email = "test@email"
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end
end
