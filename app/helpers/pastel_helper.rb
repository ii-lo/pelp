module PastelHelper
  MODE_L = {
    darker: 35,
    dark: 45,
    light: 80,
    lighter: 96,
    normal: 60
  }

  MODE_L.default = 60

  def string_to_pastel(str, mode = :normal)
    h = hash(str) % 360
    s = 95

    l = MODE_L[mode]

    Color::HSL.new(h, s, l).html
  end

  private

  def hash(str)
    h = 0
    str.each_byte do |b|
      h += (b << 6) + (b << 16) - b
    end
    h
  end
end
