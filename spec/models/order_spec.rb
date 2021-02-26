require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  it "患者名、性別、単or連、部位・注意事項、注文内容、試適日１または完成日があれば作成できる" do
    expect(order).to be_valid
  end

  it "患者名がなければ作成できない" do
    order.patient_name = nil
    expect(order.valid?).to eq(false)
  end

  it "性別がなければ作成できない" do
    order.sex = nil
    expect(order.valid?).to eq(false)
  end

  it "部位・注意事項がなければ作成できない" do
    order.note = nil
    expect(order.valid?).to eq(false)
  end

  it "部位・注意事項の文字数が100文字以上であれば作成できない" do
    order.note = "注意事項" * 26
    order.valid?
    expect(order.errors[:note]).to include("は100文字以内で入力してください")
  end

  it "注文内容がなければ作成できない" do
    order.content = nil
    order.content_other = "false"
    order.other_text = nil
    expect(order.valid?).to eq(false)
  end

  it "注文内容のその他にチェックを入れた場合、テキストに未記入だと作成できない" do
    order.content = nil
    order.content_other = "その他"
    order.other_text = nil
    order.valid?
    expect(order.errors[:other_text]).to include("に記入してください。")
  end

  it "注文内容のその他にテキストを記入した場合、その他日のチェックボックスにレ点チェックを入れないと作成できない" do
    order.content = nil
    order.content_other = "false"
    order.other_text = "矯正"
    order.valid?
    expect(order.errors[:content_other]).to include("にレ点チェックを入れてください。")
  end

  it "単冠or連冠がなければ作成できない" do
    order.crown = nil
    expect(order.valid?).to eq(false)
  end

  it "試適１が記入済であれば試適２、完成日は未記入でも作成できる" do
    order.first_try = "2021-03-09"
    order.second_try = nil
    order.complete_day = nil
    expect(order.valid?).to eq(true)
  end

  it "完成日が記入済であれば試適１、試適２は未記入でも作成できる" do
    order.first_try = nil
    order.second_try = nil
    order.complete_day = "2021-03-15"
    expect(order.valid?).to eq(true)
  end

  it "試適１の時間より試適２が早い場合、作成できない" do
    order.first_try = "2021-03-20"
    order.second_try = "2021-03-13"
    order.valid?
    expect(order.errors[:first_try]).to include("より早い時間の入力は無効です")
  end

  it "試適１の時間より完成日が早い場合、作成できない" do
    order.first_try = "2021-03-20"
    order.complete_day = "2021-03-13"
    order.valid?
    expect(order.errors[:first_try]).to include("より早い時間の入力は無効です")
  end

  it "試適２の時間より完成日が早い場合、作成できない" do
    order.second_try = "2021-03-20"
    order.complete_day = "2021-03-13"
    order.valid?
    expect(order.errors[:second_try]).to include("より早い時間の入力は無効です")
  end

  it "試適１が今日よりも早い場合、作成できない" do
    order.first_try = "2021-02-22"
    order.valid?
    expect(order.errors[:first_try]).to include("は今日より早い時間の入力は無効です")
  end

  it "試適２が今日よりも早い場合、作成できない" do
    order.second_try = "2021-02-22"
    order.valid?
    expect(order.errors[:second_try]).to include("は今日より早い時間の入力は無効です")
  end

  it "完成日が今日よりも早い場合、作成できない" do
    order.complete_day = "2021-02-22"
    order.valid?
    expect(order.errors[:complete_day]).to include("は今日より早い時間の入力は無効です")
  end

end
