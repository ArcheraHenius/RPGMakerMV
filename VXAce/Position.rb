#==============================================================================
# ■ Position
#------------------------------------------------------------------------------
# 　二次元座標を扱うクラスです。
# 右方向 及び 下方向 を正方向として扱います(数学で扱う座標とは異なります)。
#==============================================================================

class Position
  #--------------------------------------------------------------------------
  # ● モジュールのインクルード
  #--------------------------------------------------------------------------
  include Comparable
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #      x : X 座標設定値
  #      y : Y 座標設定値
  #--------------------------------------------------------------------------
  def initialize(x=0, y=0)
    @data = []
    self.x = x; self.y = y
  end
  #--------------------------------------------------------------------------
  # ● 座標の合計値を返す
  #--------------------------------------------------------------------------
  def sum
    # 座標の絶対値の合計値を返す
    return (self.x.abs + self.y.abs)
  end
  #--------------------------------------------------------------------------
  # ● self から other を見たときの self の向きを 4 方向で返す
  #       other : 対象(Position)
  #--------------------------------------------------------------------------
  def dir4(other)
    # other が Position クラスのオブジェクトでない場合は例外
    exception if not other.is_a?(Position)
    # other と self の座標差を算出
    position = other - self
    # 同位置だった場合は 5 を返す
    return 5 if position == Position.new(0, 0)
    # X 軸と Y 軸で距離差が同じ場合はランダムで 1 増加
    if position.x == position.y
      Function.random ? position.x += 1 : position.y += 1
    end
    # X 座標と Y 座標の絶対値を比較
    if (position.x.abs - position.y.abs) > 0
      return position.x > 0 ? 6 : 4
    else
      return position.y > 0 ? 2 : 8
    end
  end
  #--------------------------------------------------------------------------
  # ● self から other を見たときの self の向きを 8 方向で返す
  #       other : 対象(Position)
  #--------------------------------------------------------------------------
  def dir8(other)
    # other が Position クラスのオブジェクトでない場合は例外
    exception if not other.is_a?(Position)
    # other と self の座標差を算出
    position = other - self
    # 同位置だった場合は 5 を返す
    return 5 if position == Position.new(0, 0)
    # X 座標と Y 座標の絶対値を比較
    if (position.x.abs - position.y.abs) > position.sum / 3
      return position.x > 0 ? 6 : 4
    elsif (position.x.abs - position.y.abs) < -(position.sum / 3)
      return position.y > 0 ? 2 : 8
    else
      return position.x < 0 ? position.y < 0 ? 7 : 1 : position.y < 0 ? 9 : 3
    end
  end
  #--------------------------------------------------------------------------
  # ● 座標が半径 r の円内に存在するかどうかの判定
  #--------------------------------------------------------------------------
  def inner_circle?(r)
    # r が Integer クラスのオブジェクトでない場合
    exception if not r.is_a?(Integer)
    x = self.x.abs.to_f / r
    y = self.y.abs.to_f / r
    return (x ** 2 + y ** 2 < 1.0)
  end
  #--------------------------------------------------------------------------
  # ● 絶対値変換
  #--------------------------------------------------------------------------
  def abs
    # それぞれの座標を絶対値に変換した Position オブジェクトを返す
    return Position.new(self.x.abs, self.y.abs)
  end
  #--------------------------------------------------------------------------
  # ● 基本比較演算子
  #--------------------------------------------------------------------------
  def <=>(other)
    # other が Position オブジェクトでない場合は nil を返す
    return nil if not other.is_a?(Position)
    # 座標の合計値を差を返す
    return self.sum - other.sum
  end
  #--------------------------------------------------------------------------
  # ● 比較演算子(一致)
  #--------------------------------------------------------------------------
  def ==(other)
    # other が Position オブジェクトでない場合は nil を返す
    return nil if not other.is_a?(Position)
    # 座標の一致判定結果を返す
    return (self.x == other.x and self.y == other.y)
  end
  #--------------------------------------------------------------------------
  # ● 算術演算子(加算)
  #--------------------------------------------------------------------------
  def +(other)
    p = Position.new
    # other が Position クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x + other.x, self.y + other.y) if other.is_a?(Position)
    # ohter が Interger クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x + other, self.y + other) if other.is_a?(Integer)
    # ohter が Array クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x + other[0], self.y + other[1]) if other.is_a?(Array)
    # どれでもない場合は例外を発生させる
    exception
  end
  #--------------------------------------------------------------------------
  # ● 算術演算子(減算)
  #--------------------------------------------------------------------------
  def -(other)
    p = Position.new
    # other が Position クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x - other.x, self.y - other.y) if other.is_a?(Position)
    # ohter が Interger クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x - other, self.y - other) if other.is_a?(Integer)
    # ohter が Array クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x - other[0], self.y - other[1]) if other.is_a?(Array)
    # どれでもない場合は例外を発生させる
    exception
  end
  #--------------------------------------------------------------------------
  # ● 算術演算子(乗算)
  #--------------------------------------------------------------------------
  def *(other)
    p = Position.new
    # other が Position クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x * other.x, self.y * other.y) if other.is_a?(Position)
    # ohter が Interger クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x * other, self.y * other) if other.is_a?(Integer)
    # ohter が Array クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x * other[0], self.y * other[1]) if other.is_a?(Array)
    # どれでもない場合は例外を発生させる
    exception
  end
  #--------------------------------------------------------------------------
  # ● 算術演算子(除算)
  #--------------------------------------------------------------------------
  def /(other)
    p = Position.new
    # other が Position クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x / other.x, self.y / other.y) if other.is_a?(Position)
    # ohter が Interger クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x / other, self.y / other) if other.is_a?(Integer)
    # ohter が Array クラス(もしくはそのサブクラス)のオブジェクトの場合
    return p.set(self.x / other[0], self.y / other[1]) if other.is_a?(Array)
    # どれでもない場合は例外を発生させる
    exception
  end
  #--------------------------------------------------------------------------
  # ● X 座標の取得
  #--------------------------------------------------------------------------
  def x
    return @data[0]
  end
  #--------------------------------------------------------------------------
  # ● X 座標の設定
  #--------------------------------------------------------------------------
  def x=(value)
    # 整数以外の代入は例外を発生させる
    exception if not value.is_a?(Integer)
    @data[0] = value
    return self
  end
  #--------------------------------------------------------------------------
  # ● Y 座標の取得
  #--------------------------------------------------------------------------
  def y
    return @data[1]
  end
  #--------------------------------------------------------------------------
  # ● Y 座標の設定
  #--------------------------------------------------------------------------
  def y=(value)
    # 整数以外の代入は例外を発生させる
    exception if not value.is_a?(Integer)
    @data[1] = value
    return self
  end
  #--------------------------------------------------------------------------
  # ● 座標を１次元配列に変換して返す
  #--------------------------------------------------------------------------
  def to_a
    return [self.x, self.y]
  end
  #--------------------------------------------------------------------------
  # ● 両方の座標を一度に設定
  #--------------------------------------------------------------------------
  def set(x, y)
    self.x = x; self.y = y
    return self
  end
  #--------------------------------------------------------------------------
  # ● 例外を発生させる
  #--------------------------------------------------------------------------
  def exception
    raise("実引数が期待されているクラスのオブジェクトではありません")
  end
end
