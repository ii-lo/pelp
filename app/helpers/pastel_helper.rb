module PastelHelper
  def string_to_pastel(str, type = :light)
    h = hash(str) % 360

    case type
    when :dark
      s = 95
      l = 40
    else
      s = 95
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
