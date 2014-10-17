module PastelHelper
  def string_to_pastel(str)
    h = hash(str) % 360
    s = 94
    l = 62

    Color::HSL.new(h, s, l).html
  end

  private def hash(str)
    h = 0
    str.each_byte do |b|
      h += (b << 6) + (b << 16) - b;
    end
    h
  end
end
