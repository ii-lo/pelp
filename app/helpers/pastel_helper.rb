module PastelHelper
  def string_to_pastel(str, mode = :normal)
    h = hash(str) % 360
    s = 95

    case mode
    when :darker
      l = 35
    when :dark
      l = 45
    else
      l = 60
    end

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
