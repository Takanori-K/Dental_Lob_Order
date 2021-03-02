require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  let(:order) { create(:order)}

  describe 'ログイン後' do
    before { login(user) }
    describe '指示書作成' do
      context "必須項目の入力値が正常" do
        it "指示書作成が成功" do
          visit new_user_order_path(user)
          fill_in '患者名', with: 'テスト患者'
          select '女', from: 'order[sex]'
          select '単冠', from: 'order[crown]'
          fill_in 'order[note]', with: '上顎１番'
          check 'order-content-AC　'
          fill_in 'order[first_try]', with: DateTime.current + 1.day
          fill_in 'order[complete_day]', with: DateTime.current + 2.day
          find('#reception', visible: false)
          click_button '指示書作成'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content '技工指示書を新規作成しました。'
        end
      end
      context "必須項目の入力値が未記入" do
        it "指示書作成が失敗" do
          visit new_user_order_path(user)
          fill_in '患者名', with: nil
          select '女', from: 'order[sex]'
          select '単冠', from: 'order[crown]'
          fill_in 'order[note]', with: nil
          uncheck 'order-content-AC　'
          fill_in 'order[first_try]', with: nil
          fill_in 'order[complete_day]', with: nil
          find('#reception', visible: false)
          click_button '指示書作成'
          expect(page).to have_content '患者名を入力してください'
          expect(page).to have_content '部位・注意事項を入力してください'
          expect(page).to have_content '注文内容にレ点チェックを入れてください。'
          expect(page).to have_content '試適１または 完成日 に日付を入れてください。'
        end
      end
    end
  end
end
