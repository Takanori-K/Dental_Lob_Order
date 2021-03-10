require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
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
      complete_day: '2030-10-26-00:00:00'
    )
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

    describe '歯科医院のアクセスできるページの要素検証' do
      context "マイページに遷移" do
        it "マイページの要素検証" do
          visit user_path(@user)

          expect(page).to have_selector 'h1', text: 'マイページ'
          expect(page).to have_selector("img[src$='/default.png']")
          expect(page).to have_selector 'strong', text: '医院名'
          expect(page).to have_selector 'strong', text: 'メールアドレス'
          expect(page).to have_selector 'td', text: @user.name.to_s
          expect(page).to have_selector 'td', text: @user.email.to_s
          expect(page).to have_link '編集'
          expect(page).to have_link '指示書作成'
          expect(page).to have_link '指示書一覧 (完)'
          expect(page).to have_selector 'span', text: '申請中の技工物'
          expect(page).to have_link 'ビデオ通話'
          expect(page).to have_link 'Previous'
          expect(page).to have_link 'Next'
        end
      end
      context "指示書一覧（完了済）に遷移" do
        it "指示書一覧（完了済）の要素検証" do
          visit user_orders_path(user_id: @user.id)

          expect(page).to have_selector 'h1', text: '指示書一覧（完了済）'
          expect(page).to have_selector '.label', text: '患者名'
          expect(page).to have_selector '.label', text: '日付'
          expect(page).to have_button '検索'
          expect(page).to have_selector 'th', text: '患者名'
          expect(page).to have_selector 'th', text: '申請日'
          expect(page).to have_selector 'th', text: '詳細'
          expect(page).to have_link 'マイページ'
        end
      end
    end
  end

  describe '管理者ログイン後' do
    before { login(@admin) }

    describe '指示書の製作物の完成' do
      context "必須項目にチェックがある" do
        it "指示書が完了表示になる" do
          visit user_order_path(id: @order.id, user_id: @user.id)
          check 'admin-check'
          fill_in 'order[weight]', with: '1.5'

          click_button '技工物完了'

          expect(current_path).to eq user_path(@admin)
          expect(page).to have_content '技工物の製作が完了しました。'
        end
      end
      context "必須項目にチェックがなし" do
        it "指示書の完成表示が失敗" do
          visit user_order_path(id: @order.id, user_id: @user.id)
          uncheck 'admin-check'
          fill_in 'order[weight]', with: '1.5'

          click_button '技工物完了'

          expect(page).to have_content '必須項目が空欄です。'
        end
      end
    end

    describe '管理者のアクセスできるページの要素検証' do
      context "マイページに遷移" do
        it "マイページの要素検証" do
          visit user_path(@admin)

          expect(page).to have_selector 'h1', text: 'マイページ'
          expect(page).to have_selector("img[src$='/default.png']")
          expect(page).to have_selector 'strong', text: '医院名'
          expect(page).to have_selector 'strong', text: 'メールアドレス'
          expect(page).to have_selector 'td', text: '管理者'
          expect(page).to have_selector 'td', text: 'admin1@email.com'
          expect(page).to have_link '編集'
          expect(page).to have_link 'Previous'
          expect(page).to have_link 'Next'
          expect(page).to have_selector 'span', text: '新着技工物'
          expect(page).to have_selector 'span', text: '歯科医院一覧'
        end
      end
      context "歯科医院一覧ページに遷移" do
        it "歯科医院一覧の要素検証" do
          visit users_path

          expect(page).to have_selector 'h1', text: '歯科医院一覧'
          expect(page).to have_selector("img[src$='/default.png']")
          expect(page).to have_selector '.title', text: '歯科医院一覧'
          expect(page).to have_link '指示書一覧 (完)'
          expect(page).to have_link 'ビデオ通話'
          expect(page).to have_link '編集'
          expect(page).to have_link '削除'
        end
      end
    end
  end
end
