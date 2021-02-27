require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー新規登録' do
    before do
      visit  new_user_path
    end

    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: 'テスト歯科医院'
        fill_in 'user[email]', with: 'test1@email.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        find('.button.is-success.has-text-weight-semibold').click
      end
    end
  end

  describe 'ログイン' do
    before do
      visit login_path
    end

    context 'ログイン画面に遷移' do
      it 'ログインに成功する' do
        fill_in 'session[email]', with: 'TEST1@email.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
      end

      it 'ログインに失敗する' do
        fill_in 'session[email]', with: ''
        fill_in 'session[password]', with: ''
        click_button 'ログイン'
        expect(current_path).to eq login_path
        expect(page).to have_selector('#flash-alert')
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功' do
          visit edit_user_path(user)
          fill_in 'user[email]', with: 'test2@example.com'
          fill_in 'user[password]', with: 'foobar'
          fill_in 'user[password_confirmation]', with: 'foobar'
          click_button '更新'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'ユーザー情報を更新しました。'
        end
      end
      context 'メールアドレス未記入' do
        it 'ユーザーの編集が失敗' do
          visit edit_user_path(user)
          fill_in 'user[email]', with: nil
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '更新'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(page).to have_content 'メールアドレスは不正な値です'
        end
      end
    end
  end
end
