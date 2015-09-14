require 'spec_helper'

describe D1lcs do
  it 'has a version number' do
    expect(D1lcs::VERSION).not_to be nil
  end

  it 'returns title line' do
    expect(D1lcs.title_line).to eq('名前        |Lv|体力　気力 旗|クラス　|スキル　　　|意感交肉技知|ID  |プレイヤー')
  end

  it 'output ID=1' do
    expect(D1lcs::Element.new(1).chara_sheet_line).to eq('王道勇者    |１|11/11 10/10 0|勇者戦士|聖希折鉄強必|１１　４　　|   1|でたとこサーガ')
  end

  it 'output ID=0' do
    expect(D1lcs::Element.new(0).error).to eq("Error: キャラクターシートID '0' は無効です")
  end
end
