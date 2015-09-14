# coding: UTF-8
require 'd1lcs/string'

require 'json'
require 'open-uri'
require 'logger'

module D1lcs
  class Element
    # 1キャラシ(1行)を作成する各要素を用意するためのクラス
    
    # オンラインキャラクターシートのJSON出力用URL
    CHARA_SHEET_URL = 'http://detatoko-saga.com/character/%d.json'

    # エラーが発生した時
    attr_reader :error

    # JSON でデータを取り込む
    # @param id [Fixnum] オンラインキャラシの登録ID
    # @return [String] 完成した1行キャラシ
    # ToDo: エラー処理を書く
    def initialize(request)
      @logger = Logger.new(STDERR)
      @logger.progname = 'Detatoko1LineCharaSheet'

      unless @request = check_id(request)
        @error = "Error: キャラクターシートID '#{request}' は無効です"
        return
      end
      if (@chara_sheet = json_parse) == nil
        @error = "Error: キャラクターシートID '#{request}' を読み込めませんでした"
        return
      end

      @pcname = pcname
      @level = level
      @hpmp = hpmp
      @classes = classes
      @skills = skills
      @timing, @janre = timing_janre
      @charaID = charaID
      @plname = plname
    end

    # 1行キャラクターシートを出力する
    # @return [String]
    def chara_sheet_line
      [@pcname, @level, @hpmp, @classes, @skills, @janre, @charaID, @plname].join('|')
    end
    alias :print :chara_sheet_line
    alias :to_s :chara_sheet_line

    private

    # PC の名前
    # @return [String]
    def pcname
      @chara_sheet['name'].dispformat(NAME_WIDTH)
    end

    # PC のレベル
    # @return [String]
    def level
      unify_dispsize2(@chara_sheet['level'].to_s)
    end

    # 体力・気力・フラグ
    # @return [String]
    def hpmp
      hpmp = ''
      %w(h m).each { |type|
        hpmp << (@chara_sheet["#{type}p"]['total'].to_s * 2).insert(2, '/')
      }
      hpmp.insert(-6, ' ') << ' 0'
    end

    # クラス
    # @return [String]
    def classes
      @chara_sheet['class'].map { |array| classID_short(array['id']) }.join
    end

    # スキル
    # @return [String]
    def skills
      @chara_sheet['skill'].map { |array| array['name'].chars.first }.join
    end

    # スキルタイミング・ジャンル
    # @return [Array<String>] [timing, string] の順番
    def timing_janre
      timing = [0, 2, 1, 0]
      janre = Array.new(6, 0)
      @chara_sheet['skill'].each { |skill|
        timing[skill['timing'].to_i - 1] += 1
        janre[skill['janre'].to_i - 1] += 1
      }
      [timing, janre].map { |array|
        array.map { |value|
          unify_dispsize2(value.to_s).tr('０', '　')
        }.join
      }
    end

    # キャラクターID
    # @return [String]
    def charaID
      "#{'% 4d' % @chara_sheet['id']}"
    end

    # プレイヤー名
    # @return [String]
    def plname
      @chara_sheet['player_name']
    end

    # リクエストされたキャラクターIDが正しいか確認する
    # @param [String] request
    # @return [Fixnum/false]
    def check_id(request)
      id = request.to_i
      case id
      when 0
        false
      else
        id
      end
    end

    # 公式キャラシから JSON をダウンロードし、Hash に変換する
    # @return [Hash]
    def json_parse
      begin
        JSON.parse(open(URI.parse(CHARA_SHEET_URL % @request)).read)
      rescue => e
        @logger.error { ["requestID:#{@request}", e.class, e].join(' : ') }
        nil
      end
    end

    # 半角2文字幅で表示をそろえるため数字の全角・半角を調整する
    # @param [String] num 整数(1桁もしくは2桁)
    # @result [String] 1桁なら全角に、2桁なら半角の整数
    def unify_dispsize2(num)
      case num.size
      when 1
        num.half_to_full
      when 2
        num.full_to_half
      end
    end

    # クラスIDから全角2文字の短縮形に変換する
    # @param [Fixnum] class_id JSONから読み込むことを考慮し文字列型
    # @return [String]
    def classID_short(class_id)
      class_ids = ['勇者', '魔王', '姫様', 'ドラ', '戦士', '魔使',
                   '神聖', '暗黒', 'マス', 'モン', '謎　', 'ザコ',
                   'メカ', '商人', '占師'               # フロンティア
      ]
      class_ids[class_id.to_i - 1]
    end
  end
end
