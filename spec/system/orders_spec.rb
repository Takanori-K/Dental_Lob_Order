require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:admin) { create(:admin) }
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'ログイン後' do
    before { login(@user) }
    describe '指示書作成' do
      context "必須項目の入力値が正常" do
        it "指示書作成が成功" do
          visit new_user_order_path(@user)
          fill_in '患者名', with: 'テスト患者'
          select '女', from: 'order[sex]'
          select '単冠', from: 'order[crown]'
          fill_in 'order[note]', with: '上顎１番'
          check 'order-content-AC　'
          fill_in 'order[first_try]', with: DateTime.current + 1.day
          fill_in 'order[complete_day]', with: DateTime.current + 2.day
          find('#reception', visible: false)
          click_button '指示書作成'
          expect(current_path).to eq user_path(@user)
          expect(page).to have_content '技工指示書を新規作成しました。'
        end
      end
      context "必須項目の入力値が未記入" do
        it "指示書作成が失敗" do
          visit new_user_order_path(@user)
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

      context "作成された指示書が更新できるか" do
        it "指示書の更新ができる" do
          @order = @user.orders.create!(
            patient_name: "テスト",
            sex: "男",
            color: "a1",
            note: "上顎１番",
            metal: "クインテス",
            content: "AC",
            crown: "単冠",
            first_try: '2030-03-15-00:00:00',
            reception_date: '2030-03-03',
            complete_day: '2030-10-26-00:00:00',
          )

          visit edit_user_order_path(id: @order.id, user_id: @user.id)

          fill_in '患者名', with: '患者'
          select '女', from: 'order[sex]'
          select 'A2', from: 'order[color]'
          select '連結', from: "order[crown]"
          fill_in 'order[note]', with: '下顎３番'
          fill_in 'order[metal]', with: 'パラ'
          check 'order-content-MB　'
          attach_file 'order[image_1]', "#{Rails.root}/spec/fixtures/DSC_0041.jpg", visible: false
          attach_file 'order[image_2]', "#{Rails.root}/spec/fixtures/DSC_0065.jpg", visible: false
          attach_file 'order[image_3]', "#{Rails.root}/spec/fixtures/DSC_2243.jpg", visible: false
          fill_in 'order[first_try]', with: '2030-07-03-00:00:00'
          fill_in 'order[second_try]', with: '2030-09-22-00:00:00'
          fill_in 'order[complete_day]', with: '2030-10-23-00:00:00'

          click_button '指示書更新'

          expect(page).to have_content '指示書を更新しました。'

          visit user_order_path(id: @order.id, user_id: @user.id)

          expect(page).to have_content '患者'
          expect(page).to have_content '女'
          expect(page).to have_content 'A2'
          expect(page).to have_content '連結'
          expect(page).to have_content '下顎３番'
          expect(page).to have_content 'パラ'
          expect(page).to have_content 'MB'
          expect(page).to have_content '03月03日(日)'
          expect(page).to have_selector("img[src$='DSC_0041.jpg']")
          expect(page).to have_selector("img[src$='DSC_0065.jpg']")
          expect(page).to have_selector("img[src$='DSC_2243.jpg']")
          expect(page).to have_content '07月03日(水) 00時00分'
          expect(page).to have_content '09月22日(日) 00時00分'
          expect(page).to have_content '10月23日(水) 00時00分'
        end
      end
    end
  end
end
